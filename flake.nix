{
  description = "";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        hook = pkgsAllowUnfree.writeShellScriptBin "hook" ''
          export TMPDIR=/tmp
          ${wrapp}/bin/wrapp
        '';

        wrapp = pkgsAllowUnfree.writeShellScriptBin "wrapp" ''
            '';
      in
      {
        packages.network-fetchurl = import ./src/network-fetchurl.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        devShell = pkgsAllowUnfree.mkShell {
          buildInputs = with pkgsAllowUnfree; [
            bashInteractive
            coreutils
            file
            which
            git
            nixpkgs-fmt
            python3Minimal
            hook
          ];

          shellHook = ''
            export TMPDIR=/tmp
          '';
        };
      });
}
