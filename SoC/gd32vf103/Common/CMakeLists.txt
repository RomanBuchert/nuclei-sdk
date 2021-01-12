cmake_minimum_required(VERSION 3.14)
# --------------------------------------------------
# Global project settings
# --------------------------------------------------
set(SOC "gd32vf103cb")

include(GNUInstallDirs)
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/project_setup.cmake")


message("*********************")
message("* Project beginning *")
message("*********************")

project(gd32vf103lib C ASM)
# --------------------------------------------------
# Set include directories
# --------------------------------------------------
include_directories(
  "${CMAKE_CURRENT_SOURCE_DIR}/Include"
  "${CMAKE_CURRENT_SOURCE_DIR}/../../../NMSIS/Core/Include"
)
# --------------------------------------------------


# --------------------------------------------------
# Collect startup files
# --------------------------------------------------
file(GLOB
  STARTUP_FILES
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS
  "Source/GCC/*.S"
)
# --------------------------------------------------

# --------------------------------------------------
# Collect driver files
# --------------------------------------------------
file(GLOB
  DRIVER_FILES
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS
  "Source/Drivers/*.c"
)
# --------------------------------------------------

# --------------------------------------------------
# Collect stub files
# --------------------------------------------------
file(GLOB
  STUB_FILES
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS
  "Source/Stubs/*.c"
)
list(REMOVE_ITEM
  STUB_FILES
  "Source/Stubs/read.c"
  "Source/Stubs/unlink.c"
  "Source/Stubs/write.c"
)
# --------------------------------------------------


# --------------------------------------------------
# Collect header files
# --------------------------------------------------
set(NMSIS_BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
file(GLOB
  NMSIS_HEADER_FILES
  LIST_DIRECTORIES false
  RELATIVE ${NMSIS_BASE_DIR}
  CONFIGURE_DEPENDS
  "../../../NMSIS/Core/Include/*.h"
)
file(GLOB
  STD_HEADER_FILES
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS
  "Include/*.h"
)
file(GLOB
  USB_HEADER_FILES
  LIST_DIRECTORIES false
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  CONFIGURE_DEPENDS
  "Include/USB/*.h"
)
set(HEADER_FILES
  ${STD_HEADER_FILES}
)
# --------------------------------------------------


# --------------------------------------------------
# Build library
# --------------------------------------------------
add_library(${PROJECT_NAME} STATIC
  "Source/gd32vf103_soc.c"
  "Source/system_gd32vf103.c"
  ${STARTUP_FILES}
  ${DRIVER_FILES}
  ${STUB_FILES}
)
#target_link_libraries(${PROJECT_NAME} INTERFACE nmsislib)
# --------------------------------------------------

# --------------------------------------------------
# Install and export library
# --------------------------------------------------
set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR})

set_target_properties(${PROJECT_NAME} PROPERTIES
  PUBLIC_HEADER "${HEADER_FILES}"
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Include>"
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../../../NMSIS/Core/Include>"
  "$<INSTALL_INTERFACE:include>"
)

set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
install(
  TARGETS ${PROJECT_NAME}
  EXPORT "${PROJECT_NAME}Target"
  LIBRARY
  ARCHIVE
  RUNTIME
)


# --------------------------------------------------
# Install linker script
# --------------------------------------------------
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/gcc_link.ld
    TYPE LIB
)

# --------------------------------------------------
# Install NMSIS Headers
# --------------------------------------------------
install(
  FILES ${NMSIS_HEADER_FILES}
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/NMSIS"
)

# --------------------------------------------------
# Install GD32VF103 Headers
# --------------------------------------------------
#install(
#  FILES ${HEADER_FILES}
#    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/gd32vf103"
#)

# --------------------------------------------------
# Install USB Headers
# --------------------------------------------------
install(
  FILES ${USB_HEADER_FILES}
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/usb"
)

export(TARGETS ${PROJECT_NAME}
  FILE "${PROJECT_NAME}.cmake"
)
# --------------------------------------------------
