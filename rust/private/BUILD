load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

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
