{ pkgs ? import <nixpkgs> { } }:
let
  ny_times_90 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=75";
      sha256 = "sha256-D0P+7XfLZJhLm0sdm9sIe6/YkWSSu+piOrPt32n34Oo=";
    };
in
ny_times_90
