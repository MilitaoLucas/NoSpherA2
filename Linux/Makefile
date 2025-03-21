#THIS IS THE LINUX MAKEFILE#
RM := rm -rf

BUILD_DIR := ../build
DEBUG_DIR := ../build_debug
COMP := g++
C_COMP := gcc

LIBS := -static-libgcc -Wl,-Bstatic -static-libstdc++ -Wl,-Bstatic
ver := $(shell expr `${COMP} -dumpversion`)
LIBOMP := ../llvm-project/openmp/build/runtime/src/libgomp.a
LIBRASCALINE := ../Lib/librascaline.a ../Lib/libmetatensor.a
LIBOPENBLAS := ../OpenBLAS/installation/lib/libopenblas.a
LIBOPENBLAS_I := -I../OpenBLAS/installation/include

# List of object file names without extensions
OBJ_NAMES := wfn_class atoms properties spherical_density AtomGrid basis_set convenience sphere_lebedev_rule scattering_factors cube fchk JKFit NoSpherA2 SALTED_utilities constants ECPs_corrections libCintMain nos_math SALTED_io SALTED_predictor SALTED_equicomb isosurface cart2sph int_g2e int_optimizer integration_params integrator rys_roots

# Define object files with the correct paths
OBJS := $(addprefix $(BUILD_DIR)/, $(OBJ_NAMES:=.o))
OBJS_d := $(addprefix $(DEBUG_DIR)/, $(OBJ_NAMES:=.o_d))

GCC_OPTS := -std=c++2b -O3 -c -fmessage-length=0 -fopenmp -static -MMD -MP
GCC_OPTS_DEBUG := -std=c++2b -Og -g -c -fmessage-length=0 -static -MMD -MP

# Main targets
all: $(BUILD_DIR)/NoSpherA2
debug: $(DEBUG_DIR)/NoSpherA2_Debug

# Create build directories
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(DEBUG_DIR):
	mkdir -p $(DEBUG_DIR)

# OpenMP library
omp:
	@if [ ! -f $(LIBOMP) ]; then \
		echo 'Building OpenMP, since $(LIBOMP) doesnt exist'; \
		cd ../llvm-project/openmp && mkdir -p build && cd build && cmake .. -DCMAKE_C_COMPILER=${C_COMP} -DCMAKE_CXX_COMPILER=${COMP} -DCMAKE_BUILD_TYPE=Release -DLIBOMP_ENABLE_SHARED=OFF && make -j; \
	else \
		echo 'Skipping OpenMP build, $(LIBOMP) already exists'; \
	fi

# OpenBLAS library
OpenBLAS:
	@if [ ! -f $(LIBOPENBLAS) ]; then \
		echo 'Building OpenBLAS, since $(LIBOPENBLAS) doesnt exist'; \
		cd ../OpenBLAS && make -j && ${RM} installation && make install PREFIX=installation; \
	else \
		echo 'Skipping OpenBLAS build, $(LIBOPENBLAS) already exists'; \
	fi

# Precompiled header
$(BUILD_DIR)/pch.h.gch: ../Src/pch.h omp OpenBLAS | $(BUILD_DIR)
	$(COMP) -std=c++23 -x c++-header $(LIBOPENBLAS_I) -I../Lib/ -o "$@" "$<"

$(DEBUG_DIR)/pch.h.gch: ../Src/pch.h omp OpenBLAS | $(DEBUG_DIR)
	$(COMP) -std=c++23 -g -x c++-header $(LIBOPENBLAS_I) -I../Lib/ -o "$@" "$<"

# Pattern rule to compile all .cpp files for release
$(BUILD_DIR)/%.o: ../Src/%.cpp $(BUILD_DIR)/pch.h.gch | $(BUILD_DIR)
	@echo 'Building file: $<'
	@$(COMP) $(GCC_OPTS) $(LIBOPENBLAS_I) -I../Lib/ -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'

# Pattern rule to compile all .cpp files for debug
$(DEBUG_DIR)/%.o_d: ../Src/%.cpp $(DEBUG_DIR)/pch.h.gch | $(DEBUG_DIR)
	@echo 'Building file: $<'
	@$(COMP) $(GCC_OPTS_DEBUG) $(LIBOPENBLAS_I) -I../Lib/ -MF"$(@:%.o_d=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'

# Final linking for release executable
$(BUILD_DIR)/NoSpherA2: $(OBJS) omp OpenBLAS | $(BUILD_DIR)
	@echo 'Building target: $@'
	@$(COMP) -o "$@" $(OBJS) $(LIBOMP) $(LIBRASCALINE) $(LIBS) $(LIBOPENBLAS)
	@cp "$@" ..
	@echo 'Done building NoSpherA2'

# Final linking for debug executable
$(DEBUG_DIR)/NoSpherA2_Debug: $(OBJS_d) omp OpenBLAS | $(DEBUG_DIR)
	@echo 'Building target: $@'
	@$(COMP) -o "$@" $(OBJS_d) $(LIBOMP) $(LIBRASCALINE) $(LIBS) $(LIBOPENBLAS)
	@cp "$@" ..
	@echo 'Done building Debug version of NoSpherA2'

clean:
	-$(RM) $(BUILD_DIR) $(DEBUG_DIR)
	-@echo 'Clean completed'

.PHONY: all debug clean omp OpenBLAS
.SECONDARY: