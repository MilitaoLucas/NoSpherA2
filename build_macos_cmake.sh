#!/bin/bash
# Script to build NoSpherA2 on macOS with CMake
# This demonstrates the recommended configuration for macOS builds

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}NoSpherA2 macOS CMake Build Script${NC}"
echo "===================================="

# Check prerequisites
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

command -v cmake >/dev/null 2>&1 || {
    echo -e "${RED}Error: CMake is not installed. Install with: brew install cmake${NC}"
    exit 1
}
echo "✓ CMake found: $(cmake --version | head -n1)"

command -v ninja >/dev/null 2>&1 || {
    echo -e "${RED}Error: Ninja is not installed. Install with: brew install ninja${NC}"
    exit 1
}
echo "✓ Ninja found: $(ninja --version)"

command -v rustc >/dev/null 2>&1 || {
    echo -e "${RED}Error: Rust is not installed. Install with: brew install rustup-init && rustup-init${NC}"
    exit 1
}
echo "✓ Rust found: $(rustc --version)"

# Detect architecture and set OpenMP path
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    OPENMP_PATH="/opt/homebrew/opt/libomp"
    echo "✓ Detected Apple Silicon (arm64)"
else
    OPENMP_PATH="/usr/local/opt/libomp"
    echo "✓ Detected Intel Mac (x86_64)"
fi

# Check if libomp is installed
if [ ! -d "$OPENMP_PATH" ]; then
    echo -e "${RED}Error: libomp not found at $OPENMP_PATH. Install with: brew install libomp${NC}"
    exit 1
fi
echo "✓ OpenMP found at: $OPENMP_PATH"

# Build type (default to Release)
BUILD_TYPE="${BUILD_TYPE:-Release}"

# Prepare CMake arguments
CMAKE_ARGS=(
    -GNinja
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE"
    -DOpenMP_ROOT="$OPENMP_PATH"
    -DWITH_CLANG_TIDY=OFF
)

# Check ccache (optional)
if command -v ccache >/dev/null 2>&1; then
    echo "✓ ccache found: $(ccache --version | head -n1)"
    CMAKE_ARGS+=(
        -DUSE_CCACHE=YES
        "-DCCACHE_OPTIONS=CCACHE_CPP2=true;CCACHE_SLOPPINESS=clang_index_store"
    )
    USE_CCACHE_STATUS="YES"
else
    echo "  ccache not found (optional, install with: brew install ccache)"
    CMAKE_ARGS+=(-DUSE_CCACHE=NO)
    USE_CCACHE_STATUS="NO"
fi

# Display configuration
echo -e "\n${YELLOW}Build Configuration:${NC}"
echo "  Build Type: $BUILD_TYPE"
echo "  OpenMP Root: $OPENMP_PATH"
echo "  Generator: Ninja"
echo "  Clang-tidy: OFF"
echo "  ccache: $USE_CCACHE_STATUS"

# Create build directory
BUILD_DIR="build"
echo -e "\n${YELLOW}Creating build directory: $BUILD_DIR${NC}"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure with CMake
echo -e "\n${YELLOW}Configuring with CMake...${NC}"
cmake "${CMAKE_ARGS[@]}" ..

# Build
echo -e "\n${YELLOW}Building NoSpherA2...${NC}"
cmake --build . --target NoSpherA2 -j

# Check if build succeeded
if [ -f "Src/NoSpherA2" ]; then
    echo -e "\n${GREEN}✓ Build successful!${NC}"
    echo "Executable location: $(pwd)/Src/NoSpherA2"
    
    # Show binary info
    echo -e "\n${YELLOW}Binary information:${NC}"
    file Src/NoSpherA2
    
    if command -v otool >/dev/null 2>&1; then
        echo -e "\n${YELLOW}OpenMP library dependencies:${NC}"
        if otool -L Src/NoSpherA2 2>/dev/null | grep -i omp; then
            echo -e "${GREEN}✓ OpenMP library linked successfully${NC}"
        else
            echo "No OpenMP library found in binary (or otool failed)"
        fi
    fi
else
    echo -e "\n${RED}✗ Build failed - executable not found${NC}"
    exit 1
fi

echo -e "\n${GREEN}Done!${NC}"
