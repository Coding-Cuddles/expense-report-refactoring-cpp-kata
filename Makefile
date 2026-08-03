COLOR_CYAN := \033[36m
COLOR_RESET := \033[0m

CLICOLOR ?= 1
GTEST_COLOR ?= 1
export CLICOLOR GTEST_COLOR

BUILDDIR ?= build
BUILDCONFIG ?= Debug
SRCS := $(shell git ls-files '*.cpp' '*.h' '*.hpp')

.DEFAULT_GOAL := help

.PHONY: all
all: test ## Build and run tests

.PHONY: help
help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make [options] $(COLOR_CYAN)[target] ...$(COLOR_RESET)\n\n"} \
	/^[a-zA-Z_-]+:.*##/ {printf "  $(COLOR_CYAN)%-20s$(COLOR_RESET) %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)

.PHONY: build
build: ## Configure and build
	cmake -S . -B ${BUILDDIR} -DCMAKE_BUILD_TYPE=${BUILDCONFIG}
	cmake --build ${BUILDDIR} --config ${BUILDCONFIG}

.PHONY: test
test: build ## Build and run tests
	ctest --test-dir ${BUILDDIR} --build-config ${BUILDCONFIG} --output-on-failure

.PHONY: format
format: ## Format C++ sources in place
	clang-format -i -style=file $(SRCS)

.PHONY: format-check
format-check: ## Fail if C++ sources require formatting
	clang-format -style=file --dry-run -Werror $(SRCS) \
		|| (echo "Some files require formatting. Run 'make format' to fix." && exit 1)

.PHONY: clean
clean: ## Remove generated build artifacts
	rm -rf ${BUILDDIR} compile_commands.json

ifneq ($(VERBOSE),1)
.SILENT:
endif
