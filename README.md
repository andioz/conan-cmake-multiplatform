# conan-cmake-multiplatform

Playground to show different ways to build projects in C++ for different 
platforms (Linux and Android for the beginning).

## Environment

Sourcing the environment file: `. environment` does:
* create a new python virtual environment (if not exist)
* activate this virtual environment
* install/update primary python packages
* install/update other packages
* set `CONAN_USER_HOME` for a separated sandbox
* create a default conan profile (always overwritten)

