{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells."${system}".default = pkgs.mkShell {
        hardeningDisable = [ "fortify" ];

        nativeBuildInputs = [
          pkgs.meson
          pkgs.pkg-config
          pkgs.python313
          pkgs.python313Packages.packaging
          pkgs.python313Packages.mako
          pkgs.python313Packages.pyyaml
          pkgs.byacc
          pkgs.flex
          pkgs.bison
          pkgs.wayland-scanner
          pkgs.ninja
          pkgs.clang-tools
        ];

        buildInputs = [
          pkgs.llvmPackages_21.libclc
          pkgs.llvmPackages_21.clang
          pkgs.llvmPackages_21.clang-unwrapped
          pkgs.llvmPackages_21.libllvm
          pkgs.libz
          pkgs.libdrm
          pkgs.mesa
          pkgs.spirv-llvm-translator
          pkgs.spirv-tools
          pkgs.wayland.dev
          # pkgs.libglvnd
          pkgs.libxml2
          pkgs.libx11
          pkgs.libxcb
          pkgs.libxext
          pkgs.libxfixes
          pkgs.libxrandr
          pkgs.libxshmfence
          pkgs.libxxf86vm
        ];

        packages = [
          pkgs.mesa-demos
        ];

        LLVM_LIBRARY_DIR = "${pkgs.lib.getLib pkgs.llvmPackages.clang-unwrapped}/lib";
      };
    };
}
