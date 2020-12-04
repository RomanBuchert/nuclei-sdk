cmake_minimum_required(VERSION 3.14)
# --------------------------------------------------
# Global project settings
# --------------------------------------------------
set(SOC "gd32vf103cb")
set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/SoC/gd32vf103/Board/gd32vf103c_longan_nano/Source/GCC/gcc_gd32vf103_flashxip.ld")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/project_setup.cmake")


message("*********************")
message("* Project beginning *")
message("*********************")

project(Test)

add_subdirectory("SoC/gd32vf103/Common")

add_executable(${PROJECT_NAME} main.c)

target_link_libraries(${PROJECT_NAME} gd32vf103lib)

