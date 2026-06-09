{
  description = "C/C++ development environment for x86_64-linux";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };
      rustToolchain = pkgs.rust-bin.stable."1.88.0".default;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          gcc
          cmake
          gnumake
          pkg-config
          python3
          python3Packages.pytest
          jupyter
          doxygen
        ];
        buildInputs = with pkgs; [
          boost
          catch2
          rustToolchain
          llvmPackages.openmp
        ];
        shellHook = ''
          export CMAKE_MODULE_PATH="$PWD/.venv/share/Pytest/cmake:$CMAKE_MODULE_PATH"
          export CMAKE_PREFIX_PATH="$PWD/.venv"
          ln -sfn ${pkgs.micromamba}/bin/micromamba micromamba
          ln -sfn build-linux-gcc/compile_commands.json .
        '';
      };
    };
}
