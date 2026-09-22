cmake_minimum_required(VERSION 4.4)

project(Graphics LANGUAGES C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

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
  cglm
  GIT_REPOSITORY https://github.com/recp/cglm.git
  GIT_TAG main
)
set(CGLM_SHARED OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
  stb
  GIT_REPOSITORY https://github.com/nothings/stb.git
  GIT_TAG master
)

FetchContent_Declare(
  flecs
  GIT_REPOSITORY https://github.com/SanderMertens/flecs.git
  GIT_TAG master
)
set(FLECS_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(FLECS_STATIC ON CACHE BOOL "" FORCE)
set(FLECS_SHARED_LIB OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(glfw cglm stb flecs)

add_library(stb INTERFACE)
target_include_directories(stb INTERFACE ${stb_SOURCE_DIR})

set(DAWN_DIR "" CACHE PATH "Path to Dawn installation")

if(NOT DAWN_DIR)
  message(FATAL_ERROR "DAWN_DIR is required")
endif()

list(PREPEND CMAKE_PREFIX_PATH "${DAWN_DIR}")
find_package(Dawn CONFIG REQUIRED)

add_executable(${PROJECT_NAME} src/main.c)
target_include_directories(${PROJECT_NAME}
  PRIVATE
    ${DAWN_DIR}/include
    ${cglm_SOURCE_DIR}/include
)

target_link_libraries(${PROJECT_NAME}
  PRIVATE
    dawn::webgpu_dawn
    glfw
    cglm
    stb
    flecs
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE SHADER_DIR="${CMAKE_CURRENT_SOURCE_DIR}/src/shaders"
)

# Copy folder on build (uncomment when needed)
# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#    COMMAND ${CMAKE_COMMAND} -E copy_directory
#      ${CMAKE_SOURCE_DIR}/src/assets
#      $/assets
# )

if(APPLE)
  find_package(Threads REQUIRED)

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
