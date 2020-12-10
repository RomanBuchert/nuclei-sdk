cmake_minimum_required(VERSION 3.13)
# --------------------------------------------------
# Global project settings
# --------------------------------------------------
set(SOC "gd32vf103cb")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/project_setup.cmake")


message("*********************")
message("* Project beginning *")
message("*********************")

project(Test)


add_subdirectory("SoC/gd32vf103/Common")


add_executable(${PROJECT_NAME} main.c)

target_link_libraries(${PROJECT_NAME}
  gd32vf103lib
)

