{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python313
    pkgs.python313Packages.opencv4
    pkgs.python313Packages.numpy
    pkgs.neovim
    pkgs.git
  ];
}

