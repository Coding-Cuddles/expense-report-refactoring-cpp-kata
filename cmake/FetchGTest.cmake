include(FetchContent)

function(fetch_gtest)
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/releases/download/v1.16.0/googletest-1.16.0.tar.gz
        URL_HASH MD5=9a75eb2ac97300cdb8b65b1a5833f411
        DOWNLOAD_EXTRACT_TIMESTAMP
        FALSE
        FIND_PACKAGE_ARGS
        NAMES
        GTest
    )

    # Prevent overriding parent project's compiler/linker settings on Windows
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endfunction()
