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
          nix build .#ny_times_75
          nix build .#ny_times_90
          nix build .#ny_times_100000
          nix build .#estadao
        '';
      in
      {
        packages.network-fetchurl = import ./src/network-fetchurl.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        packages.ny_times_75 = import ./src/ny_times_75.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        packages.ny_times_90 = import ./src/ny_times_90.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        packages.ny_times_100000 = import ./src/ny_times_100000.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        packages.estadao = import ./src/estadao.nix {
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
            hook
          '';
        };
      });
}
