
cmake_minimum_required(VERSION 3.25)

project(WebGPU_Engine LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

include(FetchContent)

FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.4
)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    flecs
    GIT_REPOSITORY https://github.com/SanderMertens/flecs.git
    GIT_TAG v4.1.4
)
set(FLECS_BUILD_TESTS OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    cglm
    GIT_REPOSITORY https://github.com/recp/cglm.git
    GIT_TAG v0.9.6
)

FetchContent_MakeAvailable(glfw flecs cglm)

set(DAWN_DIR "" CACHE PATH "Path to Dawn installation")
if(NOT DAWN_DIR)
    message(FATAL_ERROR "DAWN_DIR is required. Pass -DDAWN_DIR=/path/to/dawn")
endif()

list(PREPEND CMAKE_PREFIX_PATH "${DAWN_DIR}")
find_package(Dawn CONFIG REQUIRED)

add_executable(${PROJECT_NAME} src/main.c)

target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${cglm_SOURCE_DIR}/include
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        dawn::webgpu_dawn
        webgpu_glfw
        glfw
        flecs::flecs
        cglm
)

if(APPLE)
    find_library(METAL_LIB Metal REQUIRED)
    find_library(FOUNDATION_LIB Foundation REQUIRED)
    find_library(QUARTZCORE_LIB QuartzCore REQUIRED)
    find_library(IOKIT_LIB IOKit REQUIRED)
    find_library(COCOA_LIB Cocoa REQUIRED)

    target_link_libraries(${PROJECT_NAME}
        PRIVATE
            ${METAL_LIB}
            ${FOUNDATION_LIB}
            ${QUARTZCORE_LIB}
            ${IOKIT_LIB}
            ${COCOA_LIB}
    )
elseif(WIN32)
    target_link_libraries(${PROJECT_NAME}
        PRIVATE
            d3d12
            dxgi
            dxguid
    )
endif()
