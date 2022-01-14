load("//rust:defs.bzl", "rust_common")

# buildifier: disable=module-docstring
def _wasm_bindgen_transition(settings, attr):
    """The implementation of the `wasm_bindgen_transition` transition

    Args:
        settings (dict): A dict {String:Object} of all settings declared
            in the inputs parameter to `transition()`
        attr (dict): A dict of attributes and values of the rule to which
            the transition is attached

    Returns:
        dict: A dict of new build settings values to apply
    """
    return {"//command_line_option:platforms": str(Label("//rust/platform:wasm"))}

wasm_bindgen_transition = transition(
    implementation = _wasm_bindgen_transition,
    inputs = [],
    outputs = ["//command_line_option:platforms"],
)

def _rename_first_party_crates_transition_impl(settings, attr):
    """The implementation of the `rename_first_party_crates` transition

    Args:
        settings (dict): A dict {String:Object} of all settings declared
            in the inputs parameter to `transition()`
        attr (dict): A dict of attributes and values of the rule to which
            the transition is attached

    Returns:
        dict: with rename_first_party_crates always set to False
    """
    return {"@//rust/settings:rename_first_party_crates": False}

_rename_first_party_crates_transition = transition(
    implementation = _rename_first_party_crates_transition_impl,
    inputs = [],
    outputs = ["@//rust/settings:rename_first_party_crates"],
)


def _with_disabled_rename_first_party_crates_exec_impl(ctx):
    target = ctx.attr.target[0]
    symlink = ctx.actions.declare_file(target.label.name + "_symlink")
    ctx.actions.symlink(output = symlink, target_file = ctx.executable.target, is_executable = True)
    return [target[rust_common.crate_info], DefaultInfo(executable = symlink)]

with_disabled_rename_first_party_crates_exec = rule(
    implementation = _with_disabled_rename_first_party_crates_exec_impl,
    attrs = {
        "target": attr.label(
            cfg = _rename_first_party_crates_transition,
            allow_single_file = True,
            executable = True,
            mandatory = True,),
        "_allowlist_function_transition": attr.label(
            default = Label("//tools/allowlists/function_transition_allowlist"),
        ),
    }
)

def _with_disabled_rename_first_party_crates_impl(ctx):
    target = ctx.attr.target[0]
    return [target[rust_common.crate_info], target[rust_common.dep_info]]

with_disabled_rename_first_party_crates = rule(
    implementation = _with_disabled_rename_first_party_crates_impl,
    attrs = {
        "target": attr.label(
            cfg = _rename_first_party_crates_transition,
            allow_single_file = True,
            mandatory = True,),
        "_allowlist_function_transition": attr.label(
            default = Label("//tools/allowlists/function_transition_allowlist"),
        ),
    }
)