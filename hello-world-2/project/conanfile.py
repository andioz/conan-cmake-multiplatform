import conans


class ProjectConan(conans.ConanFile):
    generators = "cmake", "virtualenv"

    requires = (
        "gtest/1.10.0"
    )

    default_options = (
        "gtest:shared=False"
    )
