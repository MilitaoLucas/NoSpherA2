{
  description = "NoSpherA2 shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          llvm
          gcc
          gdb
          ninja
          ccache
          clang-tools
          lld
          micromamba
        ];

        shellHook =
          let
            deps = [
            ];
            runtimeLibs = with pkgs; [
              stdenv.cc.cc.lib
              zlib
              glib
            ];
            buildInputs = with pkgs; [
            ];
          in
          ''
            # Construct CMAKE_PREFIX_PATH by joining the store paths with semicolons
            export CMAKE_PREFIX_PATH="${
              pkgs.lib.makeSearchPathOutput "dev" "" deps
            }:${pkgs.lib.makeBinPath deps}"

            # Also export PKG_CONFIG_PATH just in case some libs don't have CMake configs
            export PKG_CONFIG_PATH="${pkgs.lib.makeSearchPathOutput "dev" "lib/pkgconfig" deps}:./cmake"

            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath runtimeLibs}"
            ln -sfn ${pkgs.micromamba}/bin/micromamba micromamba
          '';
      };
    };
}
