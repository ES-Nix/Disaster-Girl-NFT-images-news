{ pkgs ? import <nixpkgs> { } }:
let
  grahamc = pkgs.fetchurl
    {
      url = "http://grahamc.com";
      sha256 = "sha256-lkRxE6FNoYE5Ze3ocPnYnVYcouf5FVBd9KQ5pBkFYVs=";
    };
in
grahamc
