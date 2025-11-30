# === macOS Makefile (Accelerate + libomp, universal) ===
SHELL := /bin/bash

RM   := rm -f
COMP ?= clang++
APP  ?= NoSpherA2

# Build both architectures for universal binary
ARCHS := arm64 x86_64

# Source & include roots
SRC_DIR := ../Src

# Local static libs (adjust as needed)
EXTRA_LIBS := ../Lib/featomic_install/lib/libfeatomic.a \
			  ../Lib/featomic_install/lib/libmetatensor.a

# OCC library - all static libraries for arm64 (installed to occ_install)
OCC_INSTALL_DIR := ../Lib/occ_install
OCC_LIB_DIR := $(OCC_INSTALL_DIR)/lib
OCC_LIBS_arm64 := $(OCC_LIB_DIR)/libocc_main.a \
                  $(OCC_LIB_DIR)/libocc_driver.a \
                  $(OCC_LIB_DIR)/libocc_opt.a \
                  $(OCC_LIB_DIR)/libocc_io.a \
                  $(OCC_LIB_DIR)/libocc_qm.a \
                  $(OCC_LIB_DIR)/libocc_dft.a \
                  $(OCC_LIB_DIR)/libocc_gto.a \
                  $(OCC_LIB_DIR)/libocc_crystal.a \
                  $(OCC_LIB_DIR)/libocc_interaction.a \
                  $(OCC_LIB_DIR)/libocc_solvent.a \
                  $(OCC_LIB_DIR)/libocc_xdm.a \
                  $(OCC_LIB_DIR)/libocc_dma.a \
                  $(OCC_LIB_DIR)/libocc_disp.a \
                  $(OCC_LIB_DIR)/libocc_slater.a \
                  $(OCC_LIB_DIR)/libocc_geometry.a \
                  $(OCC_LIB_DIR)/libocc_isosurface.a \
                  $(OCC_LIB_DIR)/libocc_descriptors.a \
                  $(OCC_LIB_DIR)/libocc_sht.a \
                  $(OCC_LIB_DIR)/libocc_cg.a \
                  $(OCC_LIB_DIR)/libocc_elastic_fit.a \
                  $(OCC_LIB_DIR)/libocc_xtb.a \
                  $(OCC_LIB_DIR)/libocc_core.a \
                  $(OCC_LIB_DIR)/libcint.a \
                  $(OCC_LIB_DIR)/liblibecpint_static.a \
                  $(OCC_LIB_DIR)/libgau2grid_static.a \
                  $(OCC_LIB_DIR)/libfmt.a \
                  $(OCC_LIB_DIR)/libspdlog.a \
                  $(OCC_LIB_DIR)/libtbb.a \
                  $(OCC_LIB_DIR)/libtbbmalloc.a

# OCC library for x86_64 (installed to occ_install_x86)
OCC_INSTALL_DIR_X86 := ../Lib/occ_install_x86
OCC_LIB_DIR_X86 := $(OCC_INSTALL_DIR_X86)/lib
OCC_LIBS_x86_64 := $(OCC_LIB_DIR_X86)/libocc_main.a \
                   $(OCC_LIB_DIR_X86)/libocc_driver.a \
                   $(OCC_LIB_DIR_X86)/libocc_opt.a \
                   $(OCC_LIB_DIR_X86)/libocc_io.a \
                   $(OCC_LIB_DIR_X86)/libocc_qm.a \
                   $(OCC_LIB_DIR_X86)/libocc_dft.a \
                   $(OCC_LIB_DIR_X86)/libocc_gto.a \
                   $(OCC_LIB_DIR_X86)/libocc_crystal.a \
                   $(OCC_LIB_DIR_X86)/libocc_interaction.a \
                   $(OCC_LIB_DIR_X86)/libocc_solvent.a \
                   $(OCC_LIB_DIR_X86)/libocc_xdm.a \
                   $(OCC_LIB_DIR_X86)/libocc_dma.a \
                   $(OCC_LIB_DIR_X86)/libocc_disp.a \
                   $(OCC_LIB_DIR_X86)/libocc_slater.a \
                   $(OCC_LIB_DIR_X86)/libocc_geometry.a \
                   $(OCC_LIB_DIR_X86)/libocc_isosurface.a \
                   $(OCC_LIB_DIR_X86)/libocc_descriptors.a \
                   $(OCC_LIB_DIR_X86)/libocc_sht.a \
                   $(OCC_LIB_DIR_X86)/libocc_cg.a \
                   $(OCC_LIB_DIR_X86)/libocc_elastic_fit.a \
                   $(OCC_LIB_DIR_X86)/libocc_xtb.a \
                   $(OCC_LIB_DIR_X86)/libocc_core.a \
                   $(OCC_LIB_DIR_X86)/libcint.a \
                   $(OCC_LIB_DIR_X86)/liblibecpint_static.a \
                   $(OCC_LIB_DIR_X86)/libgau2grid_static.a \
                   $(OCC_LIB_DIR_X86)/libfmt.a \
                   $(OCC_LIB_DIR_X86)/libspdlog.a \
                   $(OCC_LIB_DIR_X86)/libtbb.a \
                   $(OCC_LIB_DIR_X86)/libtbbmalloc.a

# Sources - automatically discover all .cpp files in SRC_DIR
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
ifneq ($(filter $(SRC_DIR)/auxiliary_basis.cpp,$(SRCS)), $(SRC_DIR)/auxiliary_basis.cpp)
  SRCS += $(SRC_DIR)/auxiliary_basis.cpp
endif

# Per-arch objects
OBJS_arm64  := $(patsubst $(SRC_DIR)/%.cpp, build/arm64/%.o,  $(SRCS))
OBJS_x86_64 := $(patsubst $(SRC_DIR)/%.cpp, build/x86_64/%.o, $(SRCS))

# Common compile settings
CXXSTD    := -std=c++20 -DACCELERATE_NEW_LAPACK
OPTFLAGS  := -O3 -fvisibility=hidden
WARNFLAGS := -fmessage-length=0

# Include directories (base without occ)
INC_DIRS_BASE := ../Src ../Lib ../Lib/featomic_install/include
INCLUDES_BASE := $(addprefix -I,$(INC_DIRS_BASE))

# Per-arch include directories (for occ)
INCLUDES_arm64  := $(INCLUDES_BASE) -I$(OCC_INSTALL_DIR)/include
INCLUDES_x86_64 := $(INCLUDES_BASE) -I$(OCC_INSTALL_DIR_X86)/include

# macOS SDK and deployment target
SDKROOT := $(shell xcrun --sdk macosx --show-sdk-path 2>/dev/null)
SYSROOT := $(if $(SDKROOT),-isysroot $(SDKROOT),)
# Set deployment target to 13.3 to match LAPACK requirements
DEPLOYMENT_TARGET := -mmacosx-version-min=13.3

# ---- OpenMP via libomp (Homebrew) ----
# Override these if your Homebrew lives elsewhere.
LIBOMP_PREFIX_arm64  ?= /opt/homebrew/opt/libomp
LIBOMP_PREFIX_x86_64 ?= /usr/local/opt/libomp

# Compile flags to enable OpenMP with Apple clang
OMPFLAGS_arm64  := -Xpreprocessor -fopenmp -I$(LIBOMP_PREFIX_arm64)/include
OMPFLAGS_x86_64 := -Xpreprocessor -fopenmp -I$(LIBOMP_PREFIX_x86_64)/include

# Linker flags for libomp (+rpath so users don't need DYLD_LIBRARY_PATH)
OMPLIBS_arm64   := -L$(LIBOMP_PREFIX_arm64)/lib   -Wl,-rpath,$(LIBOMP_PREFIX_arm64)/lib   -lomp
OMPLIBS_x86_64  := -L$(LIBOMP_PREFIX_x86_64)/lib  -Wl,-rpath,$(LIBOMP_PREFIX_x86_64)/lib  -lomp

# Common flags (excluding includes which are per-arch)
CXXFLAGS_BASE := $(CXXSTD) $(OPTFLAGS) $(WARNFLAGS) $(SYSROOT) $(DEPLOYMENT_TARGET)
LDFLAGS_COMMON  := $(SYSROOT) $(DEPLOYMENT_TARGET) -framework Accelerate

# Per-arch final flags
CXXFLAGS_arm64  := $(CXXFLAGS_BASE) $(INCLUDES_arm64)  -arch arm64  $(OMPFLAGS_arm64)
CXXFLAGS_x86_64 := $(CXXFLAGS_BASE) $(INCLUDES_x86_64) -arch x86_64 $(OMPFLAGS_x86_64)
LDFLAGS_arm64   := $(LDFLAGS_COMMON)   -arch arm64  $(OMPLIBS_arm64)
LDFLAGS_x86_64  := $(LDFLAGS_COMMON)   -arch x86_64 $(OMPLIBS_x86_64)

# --------------------------------------------------------------------
# Targets
# --------------------------------------------------------------------

# Default target is universal binary
all: NoSpherA2

# Universal binary (both architectures)
NoSpherA2: NoSpherA2_arm64 NoSpherA2_x86_64
	@echo "Building MAC executable"
	@echo "Start making Mac executable"
	@echo "Lipo → $@"
	@lipo -create -output $@ NoSpherA2_arm64 NoSpherA2_x86_64
	@cp $@ ../
	@echo "Done."

# Single architecture builds
NoSpherA2_arm64: $(OBJS_arm64)
	@echo "Building MAC executable for arm64"
	@echo "Link (arm64)…"
	@$(COMP) $^ $(OCC_LIBS_arm64) $(EXTRA_LIBS) $(LDFLAGS_arm64) -o $@

NoSpherA2_x86_64: $(OBJS_x86_64)
	@echo "Building MAC executable for x86_64"
	@echo "Link (x86_64)…"
	@$(COMP) $^ $(OCC_LIBS_x86_64) $(EXTRA_LIBS) $(LDFLAGS_x86_64) -o $@

# Architecture-specific basis set converter
basis_set_converter:
	@echo "Building basis set converter for current architecture: $(shell uname -m)"
	@$(MAKE) -f makefile_basis_set_converter $(shell uname -m)

# Generate auxiliary_basis.cpp when needed
$(SRC_DIR)/auxiliary_basis.cpp: basis_set_converter
	@echo "auxiliary_basis.cpp generated"

# Special rule for auxiliary_basis.o - fix the source file reference
build/arm64/auxiliary_basis.o: $(SRC_DIR)/auxiliary_basis.cpp | build/arm64
	@echo "Compiling auxiliary_basis.o (arm64) after BasisSetConverter finishes"
	@$(COMP) $(CXXFLAGS_arm64) -c $< -o $@
	@echo "Finished building: auxiliary_basis.cpp (arm64)"

build/x86_64/auxiliary_basis.o: $(SRC_DIR)/auxiliary_basis.cpp | build/x86_64
	@echo "Compiling auxiliary_basis.o (x86_64) after BasisSetConverter finishes"
	@$(COMP) $(CXXFLAGS_x86_64) -c $< -o $@
	@echo "Finished building: auxiliary_basis.cpp (x86_64)"

# Pattern rules
build/arm64/%.o: $(SRC_DIR)/%.cpp | build/arm64
	@echo "Compiling (arm64): $<"
	@$(COMP) $(CXXFLAGS_arm64) -c $< -o $@

build/x86_64/%.o: $(SRC_DIR)/%.cpp | build/x86_64
	@echo "Compiling (x86_64): $<"
	@$(COMP) $(CXXFLAGS_x86_64) -c $< -o $@

build/arm64  build/x86_64:
	@mkdir -p $@

# Debug variant
debug: CXXFLAGS_BASE := -std=c++20 -O0 -g $(WARNFLAGS) $(SYSROOT) $(DEPLOYMENT_TARGET)
debug: LDFLAGS_COMMON  := $(SYSROOT) $(DEPLOYMENT_TARGET) -framework Accelerate
debug: clean NoSpherA2_arm64

clean:
	-$(RM) -r build NoSpherA2 NoSpherA2_arm64 NoSpherA2_x86_64 ../NoSpherA2 BasisSetConverter
	@echo "Cleaned."

.PHONY: all clean debug basis_set_converter NoSpherA2 NoSpherA2_arm64 NoSpherA2_x86_64
