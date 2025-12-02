{
  description = "Mon environnement Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.python313
          pkgs.python313Packages.opencv4
          pkgs.python313Packages.numpy
          pkgs.python313Packages.pyserial
          pkgs.neovim
          pkgs.git
        ];
        
        shellHook = ''
          echo "🐍 Environnement Python 3.13 activé"
          echo "Python: $(python --version)"
        '';
      };
    };
}
