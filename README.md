# Expense Report Refactoring C++ Kata

[![CI](https://github.com/Coding-Cuddles/expense-report-refactoring-cpp-kata/actions/workflows/main.yml/badge.svg)](https://github.com/Coding-Cuddles/expense-report-refactoring-cpp-kata/actions/workflows/main.yml)
[![C++17](https://img.shields.io/badge/C%2B%2B-17-blue.svg)](https://en.cppreference.com/w/cpp/17)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Practice the Open-Closed Principle by refactoring an expense report without
changing its behavior. Setup is complete when all four starter tests pass.

## Overview

This kata complements [Clean Code: SOLID, Ep. 10 - Open-Closed Principle](https://cleancoders.com/episode/clean-code-episode-10).

In this exercise, you'll practice refactoring code to adhere to the Open-Closed
Principle (OCP). You'll be working with an expense report system that tracks
different types of expenses and prints a final report.

## Instructions

### Exercise 1

The `ExpenseReport` class in the `expense_report.h` file generates an expense
report. It iterates over a list of expenses, printing out a line for each
expense and totaling up the amounts.

The current implementation, however, is complex and hard to understand, and
it's not easy to modify or extend its behavior. It's your task to refactor this
code to make it cleaner and more maintainable, while ensuring that it still
correctly calculates and prints the report.

Make sure the program still behaves the same way after your refactoring.
There's a unit test suite in place that checks that on a very rudimentary level
by just looking at the output of the program.

### Exercise 2

When you're done with refactoring, test the quality of your refactoring by
implementing two additional scenarios:

1. Extend our system to handle two more types of expenses.

   1. **Transportation**. Surcharge: 5% of the expense amount.
   2. **Supplies**. Surcharge: No surcharge.

2. Add dynamic surcharge based on day of week.

   - For dinners on weekends, the surcharge is 15% of the expense amount.
   - For breakfasts on weekends, the surcharge is 10% of the expense amount.
   - On weekdays, the surcharges remain the same as before (10% for dinner
     and 5% for breakfast).

   You may need to add a `date` field to the `Expense` class to support this
   requirement. The date should be the date when the expense occurred.

> [!TIP]
>
> You can use the `std::tm` type in C++ to work with dates, and you
> can determine if a date is a weekend by using the following function:
>
> ```cpp
> #include <ctime>
> #include <iomanip>
> #include <iostream>
> #include <string>
>
> bool is_weekend(const std::string& date_str)
> {
>     std::tm date{};
>     std::istringstream ss(date_str);
>     ss >> std::get_time(&date, "%Y-%m-%d");
>     std::mktime(&date);
>
>     int day_of_week = date.tm_wday;
>     // Check if it's Saturday (6) or Sunday (0)
>     return day_of_week == 6 || day_of_week == 0;
> }
>
> int main()
> {
>     std::string date_str = "2023-06-17";  // this is a Saturday
>     std::cout << is_weekend(date_str) << std::endl;  // this should print: 1
>     return 0;
> }
> ```

## Prerequisites

Required:

- [Git](https://git-scm.com/downloads)
- A compiler with C++17 support. Choose one:
  - [GCC](https://gcc.gnu.org/) 10+ on Linux
  - [LLVM Clang](https://llvm.org/) 14+ on Linux
  - [Apple Clang](https://developer.apple.com/xcode/) 17+ on macOS
  - [MSVC](https://visualstudio.microsoft.com/) 2022 on Windows
- [CMake 3.24 or later](https://cmake.org)

Optional:

- [GNU Make](https://www.gnu.org/software/make/), for shorter commands. Every
  required task also has direct CMake and CTest commands. Make may be
  unavailable on Windows.

You do not need to install GoogleTest separately. CMake finds an installed
copy or downloads the pinned release when needed.

## Set up the kata

1. Clone the repository:

   ```console
   git clone https://github.com/Coding-Cuddles/expense-report-refactoring-cpp-kata.git
   ```

2. Enter the repository directory:

   ```console
   cd expense-report-refactoring-cpp-kata
   ```

3. Run the starter tests. Use Make when it is installed:

   ```console
   make test
   ```

   Otherwise, use CMake and CTest directly:

   ```console
   cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
   cmake --build build --config Debug
   ctest --test-dir build --build-config Debug --output-on-failure
   ```

The first run may download and build GoogleTest. CTest should report
`100% tests passed`.

If a command reports a missing compiler or CMake, install that prerequisite
and run the setup commands again.

Setup is complete when CTest reports `100% tests passed`.

## Work on the kata

1. Refactor `expense_report.h` while preserving the behavior covered by
   `test_expense_report.cpp`.

2. Run the tests after each change. Use Make when it is installed:

   ```console
   make test
   ```

   Otherwise, use CMake and CTest directly:

   ```console
   cmake --build build --config Debug
   ctest --test-dir build --build-config Debug --output-on-failure
   ```

   Continue when CTest reports `100% tests passed`.

## Make command reference

Make is optional. Run `make` or `make help` to list these commands in the
terminal.

| Command             | Result                                    |
| ------------------- | ----------------------------------------- |
| `make all`          | Build and run the test suite              |
| `make help`         | Show the Make command reference           |
| `make build`        | Configure and build without running tests |
| `make test`         | Build and run the test suite              |
| `make format`       | Format tracked C++ and header files       |
| `make format-check` | Check formatting without changing files   |
| `make clean`        | Remove generated build artifacts          |
