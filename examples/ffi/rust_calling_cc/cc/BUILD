load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_import", "cc_library", "cc_test")

package(default_visibility = ["//ffi/rust_calling_cc:__subpackages__"])

cc_library(
    name = "native_matrix",
    srcs = ["matrix.cc"],
    hdrs = ["matrix.h"],
)

cc_test(
    name = "native_matrix_test",
    srcs = ["matrix_test.cc"],
    deps = [
        ":native_matrix",
    ],
)

## Do the same as above, but with a dynamic c library.

cc_import(
    name = "native_matrix_so",
    hdrs = ["matrix.h"],
    shared_library = ":libnative_matrix_so.so",
)

cc_binary(
    name = "libnative_matrix_so.so",
    srcs = ["matrix.cc", "matrix.h"],
    linkshared = True,
)
