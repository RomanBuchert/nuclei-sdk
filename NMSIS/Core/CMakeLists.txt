cmake_minimum_required(VERSION 3.14)

project(nmsislib)

add_library(${PROJECT_NAME} INTERFACE)

target_include_directories(${PROJECT_NAME}
  INTERFACE
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Include>"
  #"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../../../NMSIS/Core/Include>"
  #"$<INSTALL_INTERFACE:${CMAKE_CURRENT_BUILD_DIR}/Include>"
)

export(TARGETS ${PROJECT_NAME}
  FILE "${PROJECT_NAME}.cmake"
)
