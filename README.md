# Disaster-Girl-NFT-images-news


Bare minimum state working.

Usefull to copy/paste:
```bash
git add .
nix develop
nixpkgs-fmt **/*.nix *.nix
nix build .#network-fetchurl
```


Note: requires `nix` + `flakes` working.
```bash
nix build github:ES-Nix/Disaster-Girl-NFT-images-news/02e11519bfb3e0b91df7265eea2452f01fafa18a#network-fetchurl
cat result
```
