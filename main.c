#include <GLFW/glfw3.h>
#include <webgpu/webgpu.h>
#include <webgpu/webgpu_glfw.h>
#include <flecs.h>
#include <cglm/cglm.h>

#include <stdio.h>
#include <stdlib.h>

int main(void) {
  printf("Starting WebGPU...\n");
  
  if (!glfwInit()) {
      fprintf(stderr, "Failed to initialize GLFW\n");
      return EXIT_FAILURE;
  }

  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);

  GLFWwindow* window = glfwCreateWindow(1280, 720, "WebGPU + Dawn", NULL, NULL);

  if (!window) {
      fprintf(stderr, "Failed to create GLFW window\n");
      glfwTerminate();
      return EXIT_FAILURE;
  }
  
  printf("GLFW initialized.\n");

  while (!glfwWindowShouldClose(window)) {
      glfwPollEvents();
  }
  
  glfwDestroyWindow(window);
  glfwTerminate();
  
  return EXIT_SUCCESS;
}
