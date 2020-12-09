cmake_minimum_required(VERSION 3.14)
# --------------------------------------------------
# Global project settings
# --------------------------------------------------
set(SOC "gd32vf103cb")

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
foreach( ITM IN LISTS DRIVER_FILES)
  message("${ITM}")
endforeach()
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
set(HEADER_FILES ${STD_HEADER_FILES})

foreach(HDR IN LISTS HEADER_FILES)
  message("${HDR}")
endforeach()
# --------------------------------------------------


# --------------------------------------------------
# Build library
# --------------------------------------------------
add_library(${PROJECT_NAME} STATIC
  "Source/gd32vf103_soc.c"
  ${STARTUP_FILES}
  ${DRIVER_FILES}
  ${STUB_FILES}
)
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
  INCLUDES
)

export(TARGETS ${PROJECT_NAME}
  FILE "${PROJECT_NAME}.cmake"
)
# --------------------------------------------------
