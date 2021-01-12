import conans


class ProjectConan(conans.ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake"

    requires = (
        "gtest/1.10.0"
    )

    default_options = (
        "gtest:shared=False"
    )
