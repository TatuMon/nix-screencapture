{
  description = "Flake that exposes the tools I use for screen capture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { ... }: {
    homeModules.screencapture = import ./modules/screencapture-home.nix;
  };
}
