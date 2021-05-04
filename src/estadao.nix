{ pkgs ? import <nixpkgs> { } }:
let
  estadao = pkgs.fetchurl
    {
      url = "https://einvestidor.estadao.com.br/wp-content/uploads/sites/715/2021/04/whatsappimage20210428at163631_280420214958.jpeg";
      sha256 = "sha256-skDnEDeEUU50ylJbxtZcyJkxiwm+1QcDyPk6cukXPzg=";
    };
in
estadao
