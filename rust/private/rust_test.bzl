"""Unittests for rust rules."""

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")
load("@rules_cc//cc:defs.bzl", "cc_library")
load("//rust:rust_common.bzl", "CrateInfo")
load(":rust.bzl", "rust_library")

def _rlib_has_no_native_libs_test_impl(ctx):
    env = analysistest.begin(ctx)
    tut = analysistest.target_under_test(env)
    asserts.equals(env, "some value", tut[CrateInfo].val)

    return analysistest.end(env)

rlib_has_no_native_libs_test = analysistest.make(_rlib_has_no_native_libs_test_impl)

def _rlib_has_no_native_libs_test():
    rust_library(
        name = "rlib_has_native_dep",
        srcs = ["use_native_dep.rs"],
        deps = [":native_dep"],
        crate_type = "rlib",
    )

    cc_library(
        name = "native_dep",
        srcs = ["native_dep.cc"],
    )

    rlib_has_no_native_libs_test(
        name = "rlib_has_no_native_libs_test",
        target_under_test = ":rlib_has_native_dep",
    )

# Entry point from the BUILD file; macro for running each test case's macro and
# declaring a test suite that wraps them together.
def rust_test_suite(name):
    # Call all test functions and wrap their targets in a suite.
    _rlib_has_no_native_libs_test()

    native.test_suite(
        name = name,
        tests = [
            ":rlib_has_no_native_libs_test",
        ],
    )
