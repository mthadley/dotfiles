{
  description = "mthadley's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }:
    let
      systems = flake-utils.lib.system;

      # Update the state version as needed.
      # See the changelog here:
      # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
      stateVersion = "21.11";

      configuration = import ./home.nix;
    in
    {
      homeConfigurations = {
        mthadley-workos = home-manager.lib.homeManagerConfiguration rec {
          inherit configuration stateVersion;

          username = "michael.hadley";
          homeDirectory = "/home/${username}";
          system = systems.aarch64-darwin;
        };


        ci = home-manager.lib.homeManagerConfiguration rec {
          inherit configuration stateVersion;

          username = "runner";
          homeDirectory = "/home/runner";
          system = systems.x86_64-linux;
        };
      };
    };
}
