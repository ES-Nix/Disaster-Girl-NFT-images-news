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
          nix build .#ny_times_75 --out-link ny_times_75
          nix build .#ny_times_90 --out-link ny_times_90
          nix build .#ny_times_100000 --out-link ny_times_100000
          nix build .#estadao --out-link estadao

          echo
          echo "Printing sha256sums:"
          sha256sum ny_times_75
          sha256sum ny_times_90
          sha256sum ny_times_100000
          sha256sum estadao

          echo
          echo "Printing file command outputs:"
          file $(readlink ny_times_75)
          file $(readlink ny_times_90)
          file $(readlink ny_times_100000)
          file $(readlink estadao)

          echo
          echo "Printing file command outputs:"
          file $(readlink ny_times_75)
          file $(readlink ny_times_90)
          file $(readlink ny_times_100000)
          file $(readlink estadao)
        '';

        show_images_files = pkgsAllowUnfree.writeShellScriptBin "show_images_files" ''
          timeout 5 okular ny_times_75 --presentation
          timeout 5 okular ny_times_90 --presentation
          timeout 5 okular ny_times_100000 --presentation
          timeout 5 okular estadao --presentation
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
            okular
            python3Minimal
            hook
            show_images_files
          ];

          shellHook = ''
            hook
          '';
        };
      });
}
