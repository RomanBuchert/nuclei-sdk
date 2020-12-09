# --------------------------------------------------
# Get toolchain settings from GitHub
# --------------------------------------------------
message(CHECK_START "Try to get Toolchain file from github")

include(FetchContent)

FetchContent_Declare(
	riscv-toolchain
	GIT_REPOSITORY https://github.com/RomanBuchert/cmake-riscv-embedded.git
)
FetchContent_GetProperties(riscv-toolchain)
if(NOT riscv-toolchain_POPULATED)
	FetchContent_Populate(riscv-toolchain)
endif()

FetchContent_MakeAvailable(riscv-toolchain)

if (riscv-toolchain_POPULATED)
	message(CHECK_PASS "OK")
else()
	message(CHECK_FAIL "Failed")
endif()
# --------------------------------------------------

# --------------------------------------------------
# Setup toolchain for cross-compiling
# --------------------------------------------------
message(CHECK_START "Setup toolchain for cross_compiling")
set(CMAKE_TOOLCHAIN_FILE "${riscv-toolchain_SOURCE_DIR}/toolchain-riscv-none-embed.cmake")
message(CHECK_PASS "OK")
# --------------------------------------------------
