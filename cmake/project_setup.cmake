# --------------------------------------------------
# Try to avoid in-source builds
# --------------------------------------------------
if ("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_SOURCE_DIR}")
  message(FATAL_ERROR "In-source builds are disabled.
    Please create a subfolder and use `cmake ..` inside it.
    NOTE: cmake will now create CMakeCache.txt and CMakeFiles/*.
          You must delete them, or cmake will refuse to work.")
endif()

set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
# --------------------------------------------------

# --------------------------------------------------
# Import Toolchain settings
# --------------------------------------------------
include("${CMAKE_SOURCE_DIR}/cmake/toolchain_setup.cmake")
if (NOT DEFINED SOC)
	message(FATAL_ERROR "Not SOC defined")
endif()
include("${riscv-toolchain_SOURCE_DIR}/settings-${SOC}xx.cmake")
# --------------------------------------------------
