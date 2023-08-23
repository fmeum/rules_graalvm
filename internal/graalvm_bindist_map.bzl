"Binary mappings for GraalVM distribution artifacts."

# ! THIS FILE IS GENERATED. DO NOT EDIT. !

# Last updated: 2023-08-20T20:17:36.410026 by Sandboxed user

# To learn how to regenerate this file, consult the contributor docs for
# the `rules_graalvm` repository: https://github.com/sgammon/rules_graalvm

# Enumerates available distribution types.
# buildifier: disable=name-conventions
_DistributionType = struct(
    ORACLE = "oracle",
    COMMUNITY = "ce",
    ENTERPRISE = "ee",
)

# Enumerates available platform types.
# buildifier: disable=name-conventions
_DistributionPlatform = struct(
    MACOS_X64 = "macos-x64",
    MACOS_AARCH64 = "macos-aarch64",
    LINUX_X64 = "linux-x64",
    LINUX_AARCH64 = "linux-aarch64",
    WINDOWS_X64 = "windows-x64",
)

# Enumerates available platform types.
# buildifier: disable=name-conventions
_DistributionComponent = struct(
    NATIVE_IMAGE = "native-image",
    JS = "js",
    WASM = "wasm",
    PYTHON = "python",
    LLVM = "llvm",
    RUBY = "ruby",
    ESPRESSO = "espresso",
    REGEX = "regex",
    ICU4J = "icu4j",
    TRUFFLEJSON = "trufflejson",
)

# Lists dependencies for known components.
# buildifier: disable=name-conventions
_ComponentDependencies = {
    "regex": [_DistributionComponent.ICU4J],
    "js": [_DistributionComponent.ICU4J, _DistributionComponent.REGEX],
    "python": [_DistributionComponent.LLVM],
    "ruby": [_DistributionComponent.LLVM],
    "llvm-toolchain": [_DistributionComponent.LLVM],
}

# Aligned GraalVM distribution versions.
# buildifier: disable=name-conventions
_AlignedVersions = {
    "20.0.2": "23.0.1",
    "20.0.1": "23.0.1",
    "17.0.8": "23.0.1",
    "17.0.7": "23.0.1",
}

# VM release versions for calculating prefixes.
# buildifier: disable=name-conventions
_VmReleaseVersions = {
    "20.0.2": "20.0.2+9.1",
    "20.0.1": "20.0.1+9.1",
    "17.0.8": "17.0.8+7.1",
    "17.0.7": "17.0.7+9.1",
}

def _generate_distribution_coordinate(dist, platform, version, component = None):
    """Generate a well-formed distribution coordinate key.

    Generates a key for the generated binary distribution map, which holds download
    URLs and known-good integrity values.

    Args:
        dist: Distribution for the coordinate (a `DistributionType`).
        platform: Platform for the release (a `DistributionPlatform`).
        version: Version string for the GraalVM release (aligned releases accepted).
        component: Component to download; if downloading a JDK, `None` is expected.

    Returns:
        Generated distribution coordinate key.
    """

    segments = [
        dist,
        version,
        platform,
    ]
    if component != None:
        segments.append(component)
    segments.append(_AlignedVersions.get(version, version))

    # format:  `<dist>_<rlse>_<platfrm>_<vrsn>`
    # example: `oracle_20.0.2_linux-x64_23.0.1`
    return "_".join(segments)

def _resolve_distribution_artifact(dist, platform, version, component = None, strict = True):
    """Resolve a distribution artifact URL and integrity set.

    Given the provided inputs, attempts to resolve a distribution config payload
    which includes an artifact URL and integrity values. If no matching artifact
    can be located, an error is thrown.

    Args:
        dist: Distribution for the coordinate (a `DistributionType`).
        platform: Platform for the release (a `DistributionPlatform`).
        version: Version string for the GraalVM release (aligned releases accepted).
        component: Component to download; if downloading a JDK, `None` is expected.
        strict: Fail if the component cannot be found.

    Returns:
        Distribution artifact config payload, or throws.
    """

    if dist == None:
        fail("Cannot calculate GraalVM artifact coordinate with `None` as `dist`")
    if platform == None:
        fail("Cannot calculate GraalVM artifact coordinate with `None` as `platform`")
    if version == None:
        fail("Cannot calculate GraalVM artifact coordinate with `None` as `version`")

    target_key = _generate_distribution_coordinate(dist, platform, version, component)
    config = _GRAALVM_BINDIST.get(target_key)
    if config == None and strict:
        fail("Failed to resolve distribution artifact at key '" + target_key + "'")
    return config

# Generated mappings.
_GRAALVM_BINDIST = {
    "ce_17.0.7_linux-aarch64_23.0.1": {
        # GraalVM CE 17.0.7 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_linux-aarch64_bin.tar.gz",
        "sha256": "cb5bedf6244d30018856559a393029e98de48c9608eb35ec6c4937dcb7d97224",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.7_linux-x64_23.0.1": {
        # GraalVM CE 17.0.7 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_linux-x64_bin.tar.gz",
        "sha256": "094e5a7dcc4a903b70741d5c3c1688f83e83e2d44eb3d8d798c5d79ed902032c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.7_macos-aarch64_23.0.1": {
        # GraalVM CE 17.0.7 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_macos-aarch64_bin.tar.gz",
        "sha256": "05d9a51786c578cea346760b3ec3af3721780afb850b739407a2a123f5d081fd",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.7_macos-x64_23.0.1": {
        # GraalVM CE 17.0.7 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_macos-x64_bin.tar.gz",
        "sha256": "7b38776fc9259af5b9b02ffa21d8c7bf3991fa29bc689d6d1a10a305cd8f50af",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.7_windows-x64_23.0.1": {
        # GraalVM CE 17.0.7 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.7/graalvm-community-jdk-17.0.7_windows-x64_bin.zip",
        "sha256": "1fa8d5f56e7d2bbc3033e7f1f562d9ff0d07431436ca7d781c40c5433eedd348",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-aarch64_23.0.1": {
        # GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.8/graalvm-community-jdk-17.0.8_linux-aarch64_bin.tar.gz",
        "sha256": "c4f26318114d6bd125cc95ee070289afdd42c6683867adf832f2ab2819c3b685",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-aarch64_espresso_23.0.1": {
        # Espresso for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "a2d56cba5b09e2466572cf4c7c82541b4b53777b2d83a9585680113abc8453ad",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_17.0.8_linux-aarch64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java17-linux-aarch64-23.0.1.jar",
        "sha256": "175305109fcf0f3212ea878853060099fdf3d3225546dd6b96337ff0d2d4454e",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-aarch64_js_23.0.1": {
        # GraalJs for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "6a5bd10b0e98099d6884191e24e7be40292278dd178151ebc3b77d1be7f65d75",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_17.0.8_linux-aarch64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java17-linux-aarch64-23.0.1.jar",
        "sha256": "0327e0f65acdd147da7cce70a422c69da52d1b60e24c49a54b997d85dc54088f",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-aarch64_llvm_23.0.1": {
        # Sulong for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "2b23869f9d599c8f8e89635f7f0a471d3bc55b8f4f5641d628c082f257af9f55",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_17.0.8_linux-aarch64_native-image_23.0.1": {
        # Native Image for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "9ba10c81e353f0f5629b69a34b65a02c1211db64a2882c14938a5978859c5bb2",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-aarch64_python_23.0.1": {
        # GraalPython for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "762b8e28ec573ee406c83e3d1e6247f9c986af37efeac7b702a0ec53f2b4a005",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-aarch64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java17-linux-aarch64-23.0.1.jar",
        "sha256": "6309c8ea3be3f687394393ed14937a084dd0905cef2e8f075fc67d6caeef4f11",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-aarch64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "2bfd23d2afc1d2a7db38b5bea9ba1dca72e570ee854fc26b038ec8747ae30ef7",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-aarch64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java17-linux-aarch64-23.0.1.jar",
        "sha256": "4bb13c1a905804b50ef3bdba510d44d95e9f59746ad9a71c4f82c976d820e6c1",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_17.0.8_linux-x64_23.0.1": {
        # GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.8/graalvm-community-jdk-17.0.8_linux-x64_bin.tar.gz",
        "sha256": "1dffdf5c7cc5bf38558e9f093eef6a14072a6dff0be3a9906208b37b53ecc009",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-x64_espresso-llvm_23.0.1": {
        # Espresso for LLVM for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-llvm-installable-ce-java17-linux-amd64-23.0.1.jar",
        "sha256": "c4b480db48c34d351e7e7af70f24c6fb575b318f1477ea935fc2593fba58365d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "6a719ea20204686d88fbdcffa6c1cb56192c8e0188f68327cf3380468f770d1e",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_17.0.8_linux-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java17-linux-amd64-23.0.1.jar",
        "sha256": "3fb44c9051a04997dcf8cd1cc04af0feb09ed0f1b0b325a4f767319aafc01a2c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "2d97b131192063a1071bb82c8181722b970a874671814a3e3c70d7bc2df1fcee",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_17.0.8_linux-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java17-linux-amd64-23.0.1.jar",
        "sha256": "3d0cfc56e4c5329bfa66b907e5115f7c0bd14c8230eb0ebfda44f101bc203294",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "4353554eeda7871895f9b4b6053dc15cf42e7544498230a7cac2707df74eea78",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_17.0.8_linux-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "e10aebfe396b361e100944ede746316f5e78d15f0853b504863142e755e38fa9",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-x64_python_23.0.1": {
        # GraalPython for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "a8f64aab9439d94f503f5a7d45a820700e52f660c7050214159945bbfb5895a5",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java17-linux-amd64-23.0.1.jar",
        "sha256": "770852489943f3d8d29c7cae5ba99c0e309e023501881243fa86ab4d2f8cc13c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_linux-x64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "b63db35ef339919bd6205901d08fbad1cbe0b4073dfa5ad2544b73eac6d496bb",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_linux-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java17-linux-amd64-23.0.1.jar",
        "sha256": "57dc185a704675bc7e8fd96dd7eee8cf2ae50385fd5e8c07a270fe4500ec5f35",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_17.0.8_macos-aarch64_23.0.1": {
        # GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.8/graalvm-community-jdk-17.0.8_macos-aarch64_bin.tar.gz",
        "sha256": "89209bbf8346d8dd0847d431bd8654db7d4ff634745207f20af2045c4869fb49",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-aarch64_espresso_23.0.1": {
        # Espresso for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "636e36ccb4fd4b62fba170adef35384211b73c2e7c079ab803cd2a69604ae496",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_17.0.8_macos-aarch64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "afbd7a7c5ced38d17216d31e4ef67fa9b48621d6662a3c847935b13a87e8746e",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-aarch64_js_23.0.1": {
        # GraalJs for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "3b19891a47f47ce54b0a98908fb368a68278eb5bde3f2e6ed4d71a5d64182eef",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_17.0.8_macos-aarch64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "03f47877f37b3244fbc2bc1c9cae568ffd9fc359c6736deb4323b8e9542ed5cb",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-aarch64_llvm_23.0.1": {
        # Sulong for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "d6218402ca6ae453becf1de41ff28a81bb66c6a34064773166808a5260894955",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_17.0.8_macos-aarch64_native-image_23.0.1": {
        # Native Image for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "e53efea01d2aeb006b7d234271dc54e8d1b2274b3ad55d83b368bac786533951",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-aarch64_python_23.0.1": {
        # GraalPython for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "6f2719a30c117fcaa060c0fa46a66eb4df8bf7a18c5e27c729cf31e5a7c5036c",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-aarch64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "7b094bc8f0aa3b8011d2f9db2540e887a2fb31fc4b68db2caab8c3c6be4f761f",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-aarch64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "3f488f5a4728a0cc34507a4152c9abc8a9e476de755e5d8ba407ce72442e869a",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-aarch64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java17-darwin-aarch64-23.0.1.jar",
        "sha256": "e5f5de6a0a8a30d8b8a657802fe84f4a9eefe2f7ad29d997022771524d8de100",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_17.0.8_macos-x64_23.0.1": {
        # GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.8/graalvm-community-jdk-17.0.8_macos-x64_bin.tar.gz",
        "sha256": "cf4bb646018da8bf93f67e5cdae0f583b276d278d0b667d779a68d11d3b6873d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-x64_espresso-llvm_23.0.1": {
        # Espresso for LLVM for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-llvm-installable-ce-java17-darwin-amd64-23.0.1.jar",
        "sha256": "11c6e6cd5f32681bfd648f842ff5f6b6e8fd527869024ce0807c4466f2acf63c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "81270d66f73d80d1d2cebc892790438413c9f7f0c91997eb482e8862bc3b8a42",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_17.0.8_macos-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java17-darwin-amd64-23.0.1.jar",
        "sha256": "3c7d6855061005738546701d500c8ab6b6033d566b9a7566030a6e22c8ce264d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "0179b7daf431196431dc7c58bba52fc69aafd224eea5719957f7fe6c4ba1535e",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_17.0.8_macos-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java17-darwin-amd64-23.0.1.jar",
        "sha256": "62e5630ea54f2002c021a04eaafeefba5c841fee44c680de6a2cebc0361b9d91",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "52e77081875aa63e8ec490d6081c388dd8b164c11d68346122bdb51b6f0ec842",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_17.0.8_macos-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "b0dcd0f1560acee915e5f412b018ee8292643ec33db4477730b0bf52c187e96d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-x64_python_23.0.1": {
        # GraalPython for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "0403ca9b98440ce3d2a8e312f13835b3e7c1ad9c6b4881b840484e5f14605214",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java17-darwin-amd64-23.0.1.jar",
        "sha256": "3903e7d347b0e7d183bb69c52e0e81d9085146cdf96c509ff085dc8a22ebb456",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_macos-x64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "744e808875db7c5c83ca2001ea3e85e925b349ba0a9d4046cafd7d099d0e8bf6",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_macos-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java17-darwin-amd64-23.0.1.jar",
        "sha256": "af2c15909a3a1636e3a8135e876cd9c9190ede304cb79add237a30a27e314376",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_17.0.8_windows-x64_23.0.1": {
        # GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-17.0.8/graalvm-community-jdk-17.0.8_windows-x64_bin.zip",
        "sha256": "31e60e416b015057a7826fa489ac9753261e815a525fa362f8a770a3d0a364b0",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_windows-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java17-windows-amd64-23.0.1.jar",
        "sha256": "8ba5915da48086fc068cd50bad63e85e67782342c6e999bac49222d0ed837991",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_17.0.8_windows-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java17-windows-amd64-23.0.1.jar",
        "sha256": "99a13a292bf812252192bee1a086aeb680db6f8c37ed591e7051968e5d241642",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_windows-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 17.0.8 (Java 17), Windows (amd64), gersion 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java17-windows-amd64-23.0.1.jar",
        "sha256": "ba912ff5773b1d5dc1f6893d1a3730586bbcfd2bbd6a1a0c471c4b259e49e35e",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_17.0.8_windows-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java17-windows-amd64-23.0.1.jar",
        "sha256": "2074a65247af1e9352340a46245e9d317404fbc21534ee4ab6dcc01b56746333",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_17.0.8_windows-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java17-windows-amd64-23.0.1.jar",
        "sha256": "ffecc678d5d34248c961e114145cec62338d0601d6ee9a8f417f60016fbaa3f1",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_17.0.8_windows-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java17-windows-amd64-23.0.1.jar",
        "sha256": "9a8ce72275e44608d96f9242948356421a37d37707ff43e9b2e0ab762635a205",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_windows-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java17-windows-amd64-23.0.1.jar",
        "sha256": "87cc80b283ffaca0a1f165978807c6cd04f1666b0168d5a6cc22a29ef33deb6e",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "ce_17.0.8_windows-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java17-windows-amd64-23.0.1.jar",
        "sha256": "a5db5e10dd596e2ca79ca6ecc1a1f2b25cc4ccc8bbe890c982cbd9ace9c1ab26",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_20.0.1_linux-aarch64_23.0.1": {
        # GraalVM CE 20.0.1 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.1/graalvm-community-jdk-20.0.1_linux-aarch64_bin.tar.gz",
        "sha256": "ffb205a6fc0b84cbc5d38e86ce12fe01294ba1507c1a72535f63a57c57513a35",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.1_linux-x64_23.0.1": {
        # GraalVM CE 20.0.1 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.1/graalvm-community-jdk-20.0.1_linux-x64_bin.tar.gz",
        "sha256": "1c965f4698a5435bb8d094c9b2a13f7079e43d9934915964a2ee15fb81b53a79",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.1_macos-aarch64_23.0.1": {
        # GraalVM CE 20.0.1 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.1/graalvm-community-jdk-20.0.1_macos-aarch64_bin.tar.gz",
        "sha256": "be18d18f1fb805a0a3185c3eb6f08d6f7c93172025d8c8bd16c2a70b5105e28c",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.1_macos-x64_23.0.1": {
        # GraalVM CE 20.0.1 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.1/graalvm-community-jdk-20.0.1_macos-x64_bin.tar.gz",
        "sha256": "0baffa8076049915c93e97f61ea9528959c6d30e9f03943c71a7b995fc73e36d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.1_windows-x64_23.0.1": {
        # GraalVM CE 20.0.1 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.1/graalvm-community-jdk-20.0.1_windows-x64_bin.zip",
        "sha256": "5729ab19ce27a25c12640c530d2d898a51f1a9075cbc3ca7793438044c7e0e41",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-aarch64_23.0.1": {
        # GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.2/graalvm-community-jdk-20.0.2_linux-aarch64_bin.tar.gz",
        "sha256": "6022709c124191da5087d0b0c62c3246943b3d5a386717c8d1af593637217028",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-aarch64_espresso_23.0.1": {
        # Espresso for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "899c736b59aa0fe354630a812f24b5944e3c0e22286e7be3db14ac0bcb88778e",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_20.0.2_linux-aarch64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java20-linux-aarch64-23.0.1.jar",
        "sha256": "b938f54036d4179f062fbd236f001691136ace1589657b2a3f53239a6b8a0c4b",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-aarch64_js_23.0.1": {
        # GraalJs for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "799d6be66923801583fa20f8ea0ee2ad537fe11b1c194930621035adeb47d3aa",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_20.0.2_linux-aarch64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java20-linux-aarch64-23.0.1.jar",
        "sha256": "9a72562bf8995bd78e2d988f4a2b35e9db0eb8c400c6958e48b94d372245926f",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-aarch64_llvm_23.0.1": {
        # Sulong for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "03696746a6ca7150bb55fa1adc6a97bfe3310dc4af87e3e58b399dea9e15caa7",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_20.0.2_linux-aarch64_native-image_23.0.1": {
        # Native Image for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "943147b239c95495f514488b441aab495f68f4de39e5e55a2bd2a3045eea389a",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-aarch64_python_23.0.1": {
        # GraalPython for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "7814163acd96c89b76cbce66091de8da43d42a6ff05a751bf165ca60f548bcb3",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-aarch64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java20-linux-aarch64-23.0.1.jar",
        "sha256": "8d0ebfda4c1f8c0a291b1bc7fc5c3a3b04ae0e7c1ee3e3f1cafc649e0a9bb3fb",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-aarch64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "90862e8cc1d1653b8253e6147365e8bfba98d82d0fbf48c9c8142796cea334b7",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-aarch64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java20-linux-aarch64-23.0.1.jar",
        "sha256": "cfdf7a38e2cdeae94ebe4aab70f9a3f57306faac48b248c8b1d6227a5163c7ac",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_20.0.2_linux-x64_23.0.1": {
        # GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.2/graalvm-community-jdk-20.0.2_linux-x64_bin.tar.gz",
        "sha256": "941a85a690e7b1c4e1fcfac321561ca46033bba3ac4882dd15d4f45edd06726c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-x64_espresso-llvm_23.0.1": {
        # Espresso for LLVM for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-llvm-installable-ce-java20-linux-amd64-23.0.1.jar",
        "sha256": "a94022b12269b4b1e2d54fab24f855204bfa7622a07004fc4f5506c0528eec11",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "5072bf466f52f4c0e71378bee755139e758ce759d2ccae14beb424734496aa74",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_20.0.2_linux-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java20-linux-amd64-23.0.1.jar",
        "sha256": "dafb348bffa09d1538c9c97a320785d3d2cc6c94dc345f1a84a9372a5626dc7c",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "372dda758e2feae88029f3e23d319127ed08e0392272f02d30333e2ae3199b5a",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_20.0.2_linux-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java20-linux-amd64-23.0.1.jar",
        "sha256": "08acbfcd274e461abb255f1ab156fc873d2f05dc8844995d7f43ddb16369e459",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "045f4e4568caff567f7dd30888f88a06a5e593789152f3135a02bda273920640",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_20.0.2_linux-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "702468f86a1a3025d81f04b0ff4aaed8d65da3204456953552378e6cbbd4d922",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-x64_python_23.0.1": {
        # GraalPython for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "c0afd164f64efc368680ff8690651c3e6e0fd5256d360a2a51c86a82469f93e4",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java20-linux-amd64-23.0.1.jar",
        "sha256": "1b34edf86d4a378bcf00029083da620547c6cc022cfb677b26c1a3946df38dab",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_linux-x64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "22161003e0fa238ab5b94a6722ce9c7359c0ba0c1c37f0d0d8ae30fdabc57d7e",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_linux-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java20-linux-amd64-23.0.1.jar",
        "sha256": "aed4f0103742f1ee54c789f162d55debdf3bbfa0dd720f978dfebd262890a07d",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_20.0.2_macos-aarch64_23.0.1": {
        # GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.2/graalvm-community-jdk-20.0.2_macos-aarch64_bin.tar.gz",
        "sha256": "96e2227c4319ecb5eed755f8abb1411a56f51dd8f30e9770127bcd1cce2cd644",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-aarch64_espresso_23.0.1": {
        # Espresso for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "462f014888234fa5b0f46b6dc8fb9a510c956b616095d1a411c8ef13087c032a",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_20.0.2_macos-aarch64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "ce22497e3e2c16ca3db46c58290d620033fda8559d4f696ae138c6ce077b1d7c",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-aarch64_js_23.0.1": {
        # GraalJs for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "643807def4fc5c67e3a17ce0b1edc848fff9fd99b49bb4989f9431171d3f9e7f",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_20.0.2_macos-aarch64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "803d667c4ef9f3749a1758bbeed73951afbc742eff2a4565e7eca7e1a4696fd9",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-aarch64_llvm_23.0.1": {
        # Sulong for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "aebb1384dc4ba84abd9884d477df5257eb581f7b6388006c83f3eb2697343601",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_20.0.2_macos-aarch64_native-image_23.0.1": {
        # Native Image for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "d5a9e6c10429cd0762273971a7bf928bfaa3832bb170d2c3f19a980eb062ccf1",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-aarch64_python_23.0.1": {
        # GraalPython for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "7ad19652becc6406a172afc747dae7bb4d32ba7f66e5c90b7487ea6147d7f7f2",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-aarch64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "b2e3e3f3054337c2e7b194d557e177b839a2915e505218a574a7a9926e326d08",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-aarch64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "ddfc260b9ecccaa52e84a784acb86002756d11c70183662838311572b33ebb66",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-aarch64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java20-darwin-aarch64-23.0.1.jar",
        "sha256": "abd923b90fd9e46d5da39873bded91b9a344c47727ca74a2ad2aac054c4109ce",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_20.0.2_macos-x64_23.0.1": {
        # GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.2/graalvm-community-jdk-20.0.2_macos-x64_bin.tar.gz",
        "sha256": "5e57fffa27282f27976a07d27611256ea4219f02756612fe500a5ff80ed5fc2a",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-x64_espresso-llvm_23.0.1": {
        # Espresso for LLVM for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-llvm-installable-ce-java20-darwin-amd64-23.0.1.jar",
        "sha256": "50680a349607300792edcafbdd74f33b612f1a2d47090fddbdfefd21b6811514",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "a43cc9ce68a252752d2deef44e5ab5be2a51cb910dc7a3b91824fb7e02fcc449",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_20.0.2_macos-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java20-darwin-amd64-23.0.1.jar",
        "sha256": "40c72a79d3665a658367a71030bb0a22e526c754ebcb7d05a89d10bfa24aec7a",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "6da0d5807d16a7d2d71c74b2ccbdde915983a98a78653146737468c387a802bd",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_20.0.2_macos-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java20-darwin-amd64-23.0.1.jar",
        "sha256": "6d74c09981caced673c9d9ff053320f5c31ed81e479ecf01cc512561e61c5ac8",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "6af2fcfcbae803eb8759709508c80b50299449c75d7dfec01d627d313ad19987",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_20.0.2_macos-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "d3bbaa3c3c562f4f11a3a0f75e0aa7e0162d6aad4e104558ce6ce125b5081c9a",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-x64_python_23.0.1": {
        # GraalPython for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graalpython/releases/download/graal-23.0.1/python-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "cf77cae5a2b484f47fbf760ac33854ad281b843e772d2c4ba4605bed7e993d37",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/python",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java20-darwin-amd64-23.0.1.jar",
        "sha256": "e1df45e8a2d0a16e68fa0f1a277dfdaa9c50e07537395884a4c802b4600ae027",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_macos-x64_ruby_23.0.1": {
        # TruffleRuby for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/oracle/truffleruby/releases/download/graal-23.0.1/ruby-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "7b30b5a0a2c8509808d366c12272263d98c078e62a44dbbc43b6a4f289bc9ef7",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/ruby",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_macos-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java20-darwin-amd64-23.0.1.jar",
        "sha256": "fc67b654f13c6ed5024f6611ff1ae41b08580c0baf98c338495dcd11f03462bc",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "ce_20.0.2_windows-x64_23.0.1": {
        # GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-20.0.2/graalvm-community-jdk-20.0.2_windows-x64_bin.zip",
        "sha256": "457708cf7c5fbc88dc62f17f19223b62f29cc723243e6076a18953236e1a0899",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_windows-x64_espresso_23.0.1": {
        # Espresso for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/espresso-installable-svm-java20-windows-amd64-23.0.1.jar",
        "sha256": "eb9e125bb75319ab1543d7fe1950c87cef56aa789a1246323e95354328c9d3f2",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/java",
        ],
    },
    "ce_20.0.2_windows-x64_icu4j_23.0.1": {
        # ICU4j for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/icu4j-installable-ce-java20-windows-amd64-23.0.1.jar",
        "sha256": "9160df43f6fce928b3671d59f9d611bb1c3bed3952c60eb28ecdd08d5f1560ab",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_windows-x64_js_23.0.1": {
        # GraalJs for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/oracle/graaljs/releases/download/graal-23.0.1/js-installable-svm-java20-windows-amd64-23.0.1.jar",
        "sha256": "65239e60132e3314d7077d9eda1a229e6a52c21aa5f349f615a33c99bc96d896",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/javascript",
        ],
        "dependencies": [
            "icu4j",
            "regex",
        ],
    },
    "ce_20.0.2_windows-x64_llvm-toolchain_23.0.1": {
        # LLVM Toolchain for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-toolchain-installable-ce-java20-windows-amd64-23.0.1.jar",
        "sha256": "7b3c977c179b1b0252dda2f38e71f663f6243ca89c2ea50d7643ce18119a5e01",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
        "dependencies": [
            "llvm",
        ],
    },
    "ce_20.0.2_windows-x64_llvm_23.0.1": {
        # Sulong for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/llvm-installable-svm-java20-windows-amd64-23.0.1.jar",
        "sha256": "6bd092fec0121b6ab389fe0578b3a054028d7cf5a92ab251e8edab1dd8e7d834",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/llvm",
        ],
    },
    "ce_20.0.2_windows-x64_native-image_23.0.1": {
        # Native Image for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/native-image-installable-svm-java20-windows-amd64-23.0.1.jar",
        "sha256": "2b35275d491797a0bd427ffa7e4fb7ca829b0c5e9db1f355031331f59c1e2c55",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_windows-x64_regex_23.0.1": {
        # TruffleRegex for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/regex-installable-ce-java20-windows-amd64-23.0.1.jar",
        "sha256": "4646722b78da6213fa6094f7dabfdbbb1d9ee490bc30834b7dac846ec0a2d622",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "ce_20.0.2_windows-x64_wasm_23.0.1": {
        # GraalWasm for GraalVM CE 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-23.0.1/wasm-installable-svm-java20-windows-amd64-23.0.1.jar",
        "sha256": "5c70c1dc418198f75adead6290bc4345ba0ccf39897f312ca8260f850a05123b",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
            "@rules_graalvm//platform/engine/wasm",
        ],
    },
    "oracle_17.0.7_linux-aarch64_23.0.1": {
        # Oracle GraalVM 17.0.7 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.7_linux-aarch64_bin.tar.gz",
        "sha256": "fabcc3c58a5712fd4edd5ed7519e7c9f390941e0deac64df77cca220428d59f0",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.7_linux-x64_23.0.1": {
        # Oracle GraalVM 17.0.7 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.7_linux-x64_bin.tar.gz",
        "sha256": "6b1e55ca6e8a6242d7bd1f9a073cc4453a4285a9f9fe28daaa545a2ff4ee28d8",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.7_macos-aarch64_23.0.1": {
        # Oracle GraalVM 17.0.7 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.7_macos-aarch64_bin.tar.gz",
        "sha256": "b0b1377c75b8047662225eb18ca5172bf0291b041af6230c97eb75da68d87c14",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.7_macos-x64_23.0.1": {
        # Oracle GraalVM 17.0.7 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.7_macos-x64_bin.tar.gz",
        "sha256": "f356a82c121963028c54f311fb5bfd6c70cb8fa1cd9d2c55845360ddd1da34b7",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.7_windows-x64_23.0.1": {
        # Oracle GraalVM 17.0.7 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.7_windows-x64_bin.zip",
        "sha256": "c08fe96bc1af1b500ccbe7225475896d6859f66aa45e7c86e69906161b8cbaca",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.8_linux-aarch64_23.0.1": {
        # Oracle GraalVM 17.0.8 (Java 17), Linux (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-aarch64_bin.tar.gz",
        "sha256": "cd24d7b21ec0791c5a77dfe0d9d7836c5b1a8b4b75db7d33d253d07caa243117",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.8_linux-x64_23.0.1": {
        # Oracle GraalVM 17.0.8 (Java 17), Linux (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.8_linux-x64_bin.tar.gz",
        "sha256": "74b528a33bb2dfa02b4d74a0d66c9aff52e4f52924ce23a62d7f9eb1a6744657",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.8_macos-aarch64_23.0.1": {
        # Oracle GraalVM 17.0.8 (Java 17), macOS (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.8_macos-aarch64_bin.tar.gz",
        "sha256": "89f26bda33262d70455e774b55678fc259ae4f29c0a99eb0377d570507be3d04",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.8_macos-x64_23.0.1": {
        # Oracle GraalVM 17.0.8 (Java 17), macOS (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.8_macos-x64_bin.tar.gz",
        "sha256": "ddc4928be11642f35b3cb1e6a56463032705fccb74e10ed5a67a73a5fc7b639f",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_17.0.8_windows-x64_23.0.1": {
        # Oracle GraalVM 17.0.8 (Java 17), Windows (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/17/archive/jdk-17.0.8_windows-x64_bin.zip",
        "sha256": "98385c1fd4db7ad3fd7ca2f33a1fadae0b15486cfde699138d47002d7068084a",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java17",
        ],
    },
    "oracle_20.0.1_linux-aarch64_23.0.1": {
        # Oracle GraalVM 20.0.1 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.1_linux-aarch64_bin.tar.gz",
        "sha256": "f2e5c7bb4fc09dda05c04dfedfdb04545695d1a605e16588c9fbc48b8df87b9a",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.1_linux-x64_23.0.1": {
        # Oracle GraalVM 20.0.1 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.1_linux-x64_bin.tar.gz",
        "sha256": "bb118683feb4d66476198c8176a9845a9125bf5b303089b56b4b59ff9a544ccf",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.1_macos-aarch64_23.0.1": {
        # Oracle GraalVM 20.0.1 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.1_macos-aarch64_bin.tar.gz",
        "sha256": "c264fd7452dd0aa86022b371b8abea3fa2a0b62b45ff7d189e7c519fe837bdb8",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.1_macos-x64_23.0.1": {
        # Oracle GraalVM 20.0.1 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.1_macos-x64_bin.tar.gz",
        "sha256": "3f8b53c63d1f821d5ff8875140428cbb679159ce0d91294ac349b1634fe994df",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.1_windows-x64_23.0.1": {
        # Oracle GraalVM 20.0.1 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.1_windows-x64_bin.zip",
        "sha256": "7f6e96a6f592d2a17c5c18b12d67c5aae859a2b422e9fa2f8ac8c9713ce09313",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.2_linux-aarch64_23.0.1": {
        # Oracle GraalVM 20.0.2 (Java 20), Linux (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-aarch64_bin.tar.gz",
        "sha256": "ee572da97526bd55c07181fc6f5b16130d45fbc7d1e2feda966d2588ea4ac708",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.2_linux-x64_23.0.1": {
        # Oracle GraalVM 20.0.2 (Java 20), Linux (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-x64_bin.tar.gz",
        "sha256": "499b59be8e3613c223e76f101598d7c28dc04b8e154d860edf2ed05980c67526",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:linux",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.2_macos-aarch64_23.0.1": {
        # Oracle GraalVM 20.0.2 (Java 20), macOS (arm64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.2_macos-aarch64_bin.tar.gz",
        "sha256": "e8718838c2011bab3ab00eb8097ddb20aa3b8fe0a8bb0b9e3c9d801c973477bc",
        "compatible_with": [
            "@platforms//cpu:aarch64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.2_macos-x64_23.0.1": {
        # Oracle GraalVM 20.0.2 (Java 20), macOS (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.2_macos-x64_bin.tar.gz",
        "sha256": "8a0484e95b40a95f65c0a498a5b299e80757343f0ff1cc1ec43fc5249468bedb",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:macos",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
    "oracle_20.0.2_windows-x64_23.0.1": {
        # Oracle GraalVM 20.0.2 (Java 20), Windows (amd64), Version 23.0.1
        "url": "https://download.oracle.com/java/20/archive/jdk-20.0.2_windows-x64_bin.zip",
        "sha256": "79a227ca670e5594560f6caeec26bf466143612d048e7f5b0ad2c3770d465ea6",
        "compatible_with": [
            "@platforms//cpu:x86_64",
            "@platforms//os:windows",
            "@rules_graalvm//platform/jvm:java20",
        ],
    },
}

# Exports.

# buildifier: disable=name-conventions
DistributionType = _DistributionType

# buildifier: disable=name-conventions
DistributionPlatform = _DistributionPlatform

# buildifier: disable=name-conventions
DistributionComponent = _DistributionComponent

# buildifier: disable=name-conventions
ComponentDependencies = _ComponentDependencies

# buildifier: disable=name-conventions
AlignedVersions = _AlignedVersions

# buildifier: disable=name-conventions
VmReleaseVersions = _VmReleaseVersions

generate_distribution_coordinate = _generate_distribution_coordinate
resolve_distribution_artifact = _resolve_distribution_artifact
