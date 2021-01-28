load("@rules_rust//rust:rust.bzl", "rust_binary")

package(default_visibility = ["//ffi/rust_calling_cc:__subpackages__"])

rust_binary(
    name = "matrix",
    srcs = [
        "src/ffi.rs",
        "src/matrix.rs",
    ],
    deps = [
        "//ffi/rust_calling_cc/cc:native_matrix",
    ],
)

rust_binary(
    name = "matrix_dynamically_linked",
    srcs = [
        "src/ffi.rs",
        "src/matrix.rs",
    ],
    crate_root = "src/matrix.rs",
    deps = [
        "//ffi/rust_calling_cc/cc:native_matrix_so",
    ],
)
