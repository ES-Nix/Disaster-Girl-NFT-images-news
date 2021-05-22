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

        show_images_files = pkgsAllowUnfree.writeShellScriptBin "show_images_files" ''
          for image in result/images/*; do
            timeout 5 okular $image --presentation
          done
        '';
      in
      {

        packages.all_images = import ./src/all_images.nix {
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
            show_images_files
          ];

          shellHook = ''
            export TMPDIR=/tmp
          '';
        };
      });
}


