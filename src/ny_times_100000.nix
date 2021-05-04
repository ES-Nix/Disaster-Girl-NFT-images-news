{ pkgs ? import <nixpkgs> { } }:
let
  ny_times_100000 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=100000";
      sha256 = "sha256-OlsmnHPNgPCACaiDHKhl+dkxJUTUpt7Km1u1P3zLYNU=";
    };
in
ny_times_100000
