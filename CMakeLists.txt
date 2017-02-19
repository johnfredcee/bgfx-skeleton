# Set the minimum version of CMake that can be used
# To find the cmake version run
# $ cmake --version
cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")


# Set the project name
project (hello_bgfx)

include(FindBX)
include(FindBGFX)

# List project sources
file(GLOB PROJECT_SOURCES src/*.cpp)
file(GLOB BGFX_COMMON_SOURCES ${BGFX_ROOT_DIR}/examples/common/*.cpp)

################################################################################
# Compilation flags
if(MSVC)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
    add_definitions(-D_ITERATOR_DEBUG_LEVEL=0)
    add_definitions(-D_HAS_EXCEPTIONS=0)
    add_definitions(-D_HAS_ITERATOR_DEBUGGING=0)
    add_definitions(-D_SCL_SECURE=0)
    add_definitions(-D_SECURE_SCL=0)
    add_definitions(-DBX_CONFIG_ENABLE_MSVC_LEVEL4_WARNINGS=1)
    add_definitions(-D__STDC_LIMIT_MACROS)
    add_definitions(-D__STDC_FORMAT_MACROS)
    add_definitions(-D__STDC_CONSTANT_MACROS)
    add_definitions(-D_SCL_SECURE_NO_WARNINGS)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    add_compile_options(/GR-)
else()
    add_compile_options(-std=c++11 -fPIC -Wno-switch -fno-rtti -fno-exceptions)
endif()

set(DEBUG_COMPILE_OPTIONS "-DBX_CONFIG_ALLOCATOR_DEBUG")
add_compile_options("$<$<CONFIG:Debug>:${DEBUG_COMPILE_OPTIONS}>")

# Add an executable with the above sources
add_executable(hello_bgfx ${PROJECT_SOURCES})

# Set the direcoties that should be included in the build command for this target
# when running g++ these will be included as -I/directory/path/
target_include_directories(hello_bgfx
    PRIVATE ${PROJECT_SOURCE_DIR}/inc
    PRIVATE ${BX_INCLUDE_DIR}/compat/msvc
    PRIVATE ${BX_INCLUDE_DIR}
    PRIVATE ${BGFX_INCLUDE_DIR}
    PRIVATE ${BGFX_ROOT_DIR}/3rdparty
    PRIVATE ${BGFX_ROOT_DIR}/examples/common
)

target_link_libraries(hello_bgfx PRIVATE ${BGFX_COMMON_LIBRARY})
target_link_libraries(hello_bgfx PRIVATE ${BGFX_LIBRARY})