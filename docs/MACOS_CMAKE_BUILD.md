# macOS CMake Build Configuration Guide

This document describes the new CMake build configuration options for macOS that were added to support the requested build flags.

## Quick Start

### Using the Automated Build Script

The easiest way to build NoSpherA2 on macOS with CMake is to use the provided build script:

```bash
./build_macos_cmake.sh
```

This script will:
- Check all prerequisites (cmake, ninja, rust, libomp, ccache)
- Auto-detect your Mac architecture (Intel or Apple Silicon)
- Configure OpenMP paths automatically
- Build NoSpherA2 with optimal settings

### Manual CMake Configuration

If you prefer to configure CMake manually, use:

```bash
mkdir -p build && cd build

# For Apple Silicon (M1/M2/M3)
cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DOpenMP_ROOT=/opt/homebrew/opt/libomp \
  -DWITH_CLANG_TIDY=OFF \
  -DUSE_CCACHE=YES \
  -DCCACHE_OPTIONS="CCACHE_CPP2=true;CCACHE_SLOPPINESS=clang_index_store" \
  ..

# For Intel Macs
cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DOpenMP_ROOT=/usr/local/opt/libomp \
  -DWITH_CLANG_TIDY=OFF \
  -DUSE_CCACHE=YES \
  -DCCACHE_OPTIONS="CCACHE_CPP2=true;CCACHE_SLOPPINESS=clang_index_store" \
  ..

# Build
cmake --build . --target NoSpherA2 -j
```

## Prerequisites

Install required dependencies via Homebrew:

```bash
# Essential tools
brew install cmake ninja libomp

# Rust toolchain (if not already installed)
brew install rustup-init && rustup-init

# Optional: ccache for faster rebuilds
brew install ccache
```

## CMake Options Reference

### USE_CCACHE
- **Type:** Boolean (ON/OFF or YES/NO)
- **Default:** ON
- **Description:** Enable or disable ccache for faster rebuilds
- **Example:** `-DUSE_CCACHE=YES`

### CCACHE_OPTIONS
- **Type:** String (semicolon-separated list)
- **Default:** Empty
- **Description:** Set ccache environment variables
- **Format:** `"VAR1=value1;VAR2=value2"`
- **Example:** `-DCCACHE_OPTIONS="CCACHE_CPP2=true;CCACHE_SLOPPINESS=clang_index_store"`

### OpenMP_ROOT
- **Type:** Path
- **Default:** Auto-detected
- **Description:** Path to OpenMP installation
- **Apple Silicon:** `/opt/homebrew/opt/libomp`
- **Intel Mac:** `/usr/local/opt/libomp`
- **Example:** `-DOpenMP_ROOT=/opt/homebrew/opt/libomp`

### WITH_CLANG_TIDY
- **Type:** Boolean (ON/OFF)
- **Default:** OFF
- **Description:** Enable clang-tidy static analysis
- **Example:** `-DWITH_CLANG_TIDY=OFF`

### CMAKE_BUILD_TYPE
- **Type:** String
- **Default:** None (use Release)
- **Options:** Release, Debug, RelWithDebInfo
- **Example:** `-DCMAKE_BUILD_TYPE=Release`

## OpenMP Auto-Detection

The build system automatically detects OpenMP installation:

1. If `OpenMP_ROOT` is explicitly set, it uses that path
2. Otherwise, it checks for:
   - `/opt/homebrew/opt/libomp` (Apple Silicon)
   - `/usr/local/opt/libomp` (Intel Mac)
3. Sets appropriate compiler flags and library paths
4. Displays detected location during configuration

## ccache Configuration

The ccache integration supports:

- Conditional enabling via `USE_CCACHE`
- Custom environment variables via `CCACHE_OPTIONS`
- Format: `VARIABLE_NAME=value` (semicolon-separated)
- Variable names are validated (alphanumeric and underscores only)
- Invalid options generate warnings but don't stop the build

### Common ccache Options

```bash
# Enable C++ preprocessing (recommended)
CCACHE_CPP2=true

# Ignore clang index store for better cache hits
CCACHE_SLOPPINESS=clang_index_store

# Set cache directory
CCACHE_DIR=/path/to/cache

# Set cache size
CCACHE_MAXSIZE=5G
```

## Troubleshooting

### OpenMP Not Found

If CMake can't find OpenMP:

1. Verify libomp is installed: `brew list libomp`
2. Check installation path: `brew --prefix libomp`
3. Explicitly set path: `-DOpenMP_ROOT=$(brew --prefix libomp)`

### ccache Not Working

1. Verify ccache is installed: `which ccache`
2. Check ccache is enabled: Look for "Using Ccache" in CMake output
3. Disable if causing issues: `-DUSE_CCACHE=NO`

### Build Fails on Universal Binary

If building a universal binary (both arm64 and x86_64):

1. Build each architecture separately first
2. Ensure rust targets are installed:
   ```bash
   rustup target add aarch64-apple-darwin
   rustup target add x86_64-apple-darwin
   ```

## Architecture-Specific Builds

### Native Architecture Only

```bash
cmake -GNinja -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --target NoSpherA2 -j
```

### Universal Binary (Both Architectures)

```bash
cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
  ..
cmake --build . --target NoSpherA2 -j
```

### Specific Architecture

```bash
# ARM64 only
cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  ..

# x86_64 only
cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=x86_64 \
  ..
```

## CI/CD Integration

The `.github/workflows/build_cmake.yml` workflow demonstrates CI usage:

```yaml
- name: Build NoSpherA2 with CMake
  run: |
    mkdir -p build
    cd build
    cmake -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CLANG_TIDY=OFF \
      -DUSE_CCACHE=YES \
      ..
    cmake --build . --target NoSpherA2 -j
```

## Additional Resources

- [CMake Documentation](https://cmake.org/documentation/)
- [Ninja Build System](https://ninja-build.org/)
- [ccache Manual](https://ccache.dev/manual/latest.html)
- [OpenMP Support in Clang](https://openmp.llvm.org/)

## Support

For issues or questions:
1. Check this guide first
2. Review the README.md for general build instructions
3. Check existing GitHub issues
4. Open a new issue with detailed information about your setup
