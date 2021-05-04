{ pkgs ? import <nixpkgs> { } }:
let
  ny_times_90 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=90";
      sha256 = "sha256-qS1hcwWRSSzvO8BQpp4B+C7XtszJYrpvXEUjiF3C5t8=";
    };
in
ny_times_90
