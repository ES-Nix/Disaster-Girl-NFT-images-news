{ pkgs ? import <nixpkgs> { } }:
let
  # https://einvestidor.estadao.com.br/comportamento/nft-meme-zoe-roth
  estadao = pkgs.fetchurl
    {
      url = "https://einvestidor.estadao.com.br/wp-content/uploads/sites/715/2021/04/whatsappimage20210428at163631_280420214958.jpeg";
      sha256 = "sha256-skDnEDeEUU50ylJbxtZcyJkxiwm+1QcDyPk6cukXPzg=";
    };

  # https://www.nytimes.com/2021/04/29/arts/disaster-girl-meme-nft.html
  ny_times_75 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=75";
      sha256 = "sha256-D0P+7XfLZJhLm0sdm9sIe6/YkWSSu+piOrPt32n34Oo=";
    };

  ny_times_90 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=90";
      sha256 = "sha256-qS1hcwWRSSzvO8BQpp4B+C7XtszJYrpvXEUjiF3C5t8=";
    };

  ny_times_100000 = pkgs.fetchurl
    {
      url = "https://static01.nyt.com/images/2021/04/30/multimedia/30xp-meme/29xp-meme-superJumbo-v3.jpg?quality=100000";
      sha256 = "sha256-OlsmnHPNgPCACaiDHKhl+dkxJUTUpt7Km1u1P3zLYNU=";
    };

  # https://www.uol.com.br/tilt/noticias/redacao/2021/04/28/disaster-girl-meme-de-crianca-no-incendio-e-vendido-como-nft-por-r-25-mi.htm
  uol = pkgs.fetchurl
    {
      url = "https://conteudo.imguol.com.br/c/noticias/75/2021/04/28/meme-disaster-girl-vendido-como-nft-por-us-473-mil-1619627179173_v2_900x506.jpg";
      sha256 = "sha256-oboEMwXoaoQVeBHr+zF9xAv/rpJK8mpPUjclFmMcUIs=";
    };

  # https://brasil.elpais.com/cultura/2021-04-30/disaster-girl-vende-a-imagem-por-500000-dolares.html
  elpais_1 = pkgs.fetchurl
    {
      url = "https://imagens.brasil.elpais.com/resizer/6cLb_W5_rFjt_ys66dCl_g4rXPk=/414x0/cloudfront-eu-central-1.images.arcpublishing.com/prisa/GLK77QHJ4JAY3KAFM5FV6YV5OM.webp";
      sha256 = "sha256-nKa0uh4g6znPxe1/QlEytNDq1fTAZHDkWkAgfebdBOE=";
    };

  elpais_2 = pkgs.fetchurl
    {
      url = "https://imagens.brasil.elpais.com/resizer/cHY7DlFndhvOjQgywTeFDP2q5RY=/828x0/cloudfront-eu-central-1.images.arcpublishing.com/prisa/GLK77QHJ4JAY3KAFM5FV6YV5OM.webp";
      sha256 = "sha256-oSZTarJjAMIKkUh/oKcDvVyUkjnZFj7AE9wBBiYlGFQ=";
    };

  # https://gadgets.ndtv.com/internet/news/disaster-girl-meme-nft-sold-usd-500000-zoe-roth-2425087
  gadgets = pkgs.fetchurl
    {
      url = "https://i.gadgets360cdn.com/large/disaster_girl_nyt_1619763942851.jpg";
      sha256 = "sha256-1k6EVyCdpuEiyWUiGcGr/hUNpsPrDN9/PXnmYDWc7jM=";
    };

  # https://revistacrescer.globo.com/Educacao-Comportamento/noticia/2021/05/veja-como-esta-garota-do-meme-do-incendio-vendido-por-r-26-milhoes-16-anos-depois.html
  revistacrescer = pkgs.fetchurl
    {
      url = "https://s2.glbimg.com/4OlPAZMT_8oBvoru_dJ-Y0YlG04=/e.glbimg.com/og/ed/f/original/2021/05/01/0_disaster-meme.jpg";
      sha256 = "sha256-DXAks96DiTn2Kelz5BXxzserAGCxjUcX4PzdzZK9AaM=";
    };

  # https://www.bbc.com/news/world-us-canada-56948514
  bbc = pkgs.fetchurl
    {
      url = "https://ichef.bbci.co.uk/news/976/cpsprodpb/F1F2/production/_118283916_b19c5a1f-162b-410b-8169-f58f0d153752.jpg";
      sha256 = "sha256-2ipwasqXVedhatgdOL6RUF3YKbZrrivtFB7MptrL1wA=";
    };

in
rec {

  images = pkgs.runCommand "images"
    { buildInputs = with pkgs; [ coreutils ]; }
    ''
    mkdir --parent $out/images

    ln --force --symbolic ${estadao} $out/images/estadao
    ln --force --symbolic ${ny_times_75} $out/images/ny_times_75
    ln --force --symbolic ${ny_times_90} $out/images/ny_times_90
    ln --force --symbolic ${ny_times_100000} $out/images/ny_times_100000

    ln --force --symbolic ${uol} $out/images/uol

    ln --force --symbolic ${elpais_1} $out/images/elpais_1
    ln --force --symbolic ${elpais_2} $out/images/elpais_2

    ln --force --symbolic ${gadgets} $out/images/gadgets
    ln --force --symbolic ${revistacrescer} $out/images/revistacrescer
    ln --force --symbolic ${bbc} $out/images/bbc

    for image in $out/images/*; do
      sha256sum $image >> $out/sha256sums.txt
    done

    '';

}
