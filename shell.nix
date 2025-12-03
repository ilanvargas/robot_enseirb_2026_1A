{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python313
    pkgs.python313Packages.opencv4
    pkgs.python313Packages.numpy
    pkgs.python313Packages.pyserial
    pkgs.arduino-cli
    (import ./neovim-standalone.nix { inherit pkgs; })
  ];
}

