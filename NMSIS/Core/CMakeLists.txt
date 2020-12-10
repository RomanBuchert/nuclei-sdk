cmake_minimum_required(VERSION 3.14)

project(nmsislib)

add_library(${PROJECT_NAME} INTERFACE)

target_include_directories(${PROJECT_NAME} INTERFACE "Include/")

export(TARGETS ${PROJECT_NAME}
  FILE "${PROJECT_NAME}.cmake"
)
