include(FetchContent)

# Find an installed GoogleTest package or fetch and verify the pinned release
function(fetch_gtest)
    string(
        CONCAT
        gtest_url
        "https://github.com/google/googletest/releases/download/"
        "v1.17.0/googletest-1.17.0.tar.gz"
    )
    set(
        gtest_sha256
        65fab701d9829d38cb77c14acdc431d2108bfdbf8979e40eb8ae567edf10b27c
    )

    FetchContent_Declare(
        googletest
        URL ${gtest_url}
        URL_HASH SHA256=${gtest_sha256}
        DOWNLOAD_EXTRACT_TIMESTAMP
        FALSE
        FIND_PACKAGE_ARGS
        NAMES
        GTest
    )

    # Prevent overriding parent project's compiler/linker settings on Windows
    # cmake-lint: disable=C0103
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endfunction()
