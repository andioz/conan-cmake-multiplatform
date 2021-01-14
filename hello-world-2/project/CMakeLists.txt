cmake_minimum_required(VERSION 3.16)

# Find conan executable
find_program (
        CONAN_EXECUTABLE conan
        REQUIRED
        PATHS "${CMAKE_SOURCE_DIR}/venv/bin"
        PATHS "${CMAKE_SOURCE_DIR}/../venv/bin"
        PATHS "${CMAKE_SOURCE_DIR}/../../venv/bin"
)
if("${CONAN_EXECUTABLE}" STREQUAL "CONAN_EXECUTABLE-NOTFOUND")  # TODO shorter
    message(FATAL_ERROR "Cannot find conan executable")
endif()

# Run "conan install"
set(_options "${CMAKE_SOURCE_DIR}" --install-folder "${CMAKE_BINARY_DIR}" --build outdated)
if(NOT "${CONAN_PROFILE}" STREQUAL "")
    list(APPEND _options --profile ${CONAN_PROFILE})
endif()
if(NOT "${CONAN_BUILD_PROFILE}" STREQUAL "")
    list(APPEND _options --profile:build ${CONAN_BUILD_PROFILE})
endif()
if(NOT "${CONAN_HOST_PROFILE}" STREQUAL "")
    list(APPEND _options --profile:host ${CONAN_HOST_PROFILE})
endif()
execute_process(COMMAND ${CONAN_EXECUTABLE} install ${_options})
unset(_options)

# Set conan environment variables
if(EXISTS "${CMAKE_BINARY_DIR}/environment.sh.env")
    FILE(READ "${CMAKE_BINARY_DIR}/environment.sh.env" _contents)
    STRING(REGEX REPLACE "\n" ";" _contents "${_contents}")
    foreach(_line ${_contents})
        string(REGEX MATCH "([^=]+)=(.*)" _match ${_line})
        if(NOT "${_match}" STREQUAL "")
            set(_key "${CMAKE_MATCH_1}")
            set(_value "${CMAKE_MATCH_2}")
            # TODO need improvement to be more general
            string(REGEX MATCHALL "^(.*)\\$\\{([^+]+)\\+([^$]*)\\$([^}]+)\\}$" _match ${_value})
            if(NOT "${_match}" STREQUAL "")
                set(_prefix "${CMAKE_MATCH_1}")
                set(_left "${CMAKE_MATCH_2}")
                set(_separator "${CMAKE_MATCH_3}")
                set(_right "${CMAKE_MATCH_4}")
                if("${_left}" STREQUAL "${_right}")
                    if("$ENV{${_left}}" STREQUAL "")
                        set(ENV{${_key}} "${_prefix}")
                    else()
                        set(ENV{${_key}} "${_prefix}${_separator}$ENV{${_right}}")
                    endif()
                else()
                    message(FATAL_ERROR "Unhandled advanced setting for [${_match}]")
                endif()
            else()
                set(ENV{${_key}} "${_value}")
            endif()
            # message(STATUS "*** ENV{${_key}} = [$ENV{${_key}}]")
        endif()
    endforeach()
    unset(_contents)
    unset(_line)
    unset(_match)
    unset(_key)
    unset(_value)
    unset(_prefix)
    unset(_left)
    unset(_separator)
    unset(_right)
endif()

project(hello-world-2 CXX)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

add_executable(${PROJECT_NAME} src/main.cpp)
target_link_libraries(${PROJECT_NAME} CONAN_PKG::gtest)
