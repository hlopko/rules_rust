load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load(":rust_test.bzl", "rust_test_suite")

bzl_library(
    name = "rules",
    srcs = glob(
        ["**/*.bzl"],
        exclude = ["**/*_test.bzl"],
    ),
    visibility = ["//rust:__subpackages__"],
    deps = [
        "//rust/platform:rules",
    ],
)

############################ UNIT TESTS #############################
rust_test_suite(name = "rust_test_suite")

bzl_library(
    name = "rules",
    srcs = glob(
        ["**/*.bzl"],
        exclude = ["**/*_test.bzl"],
    ),
    visibility = ["//rust:__subpackages__"],
    deps = [
        "//rust/platform:rules",
    ],
)
