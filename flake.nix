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

      mkHomeConfig = { system, username, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
              home = {
                inherit username homeDirectory;

                # Update the state version as needed.
                # See the changelog here:
                # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
                stateVersion = "21.11";
              };
            }
          ];
        };
    in
    {
      homeConfigurations = {
        mthadley-workos = mkHomeConfig rec {
          system = systems.aarch64-darwin;
          username = "michael.hadley";
          homeDirectory = "/Users/${username}";
        };

        mthadley-intel = mkHomeConfig rec {
          username = "mthadley";
          homeDirectory = "/Users/${username}";
          system = systems.x86_64-darwin;
        };

        ci = mkHomeConfig rec {
          username = "runner";
          homeDirectory = "/home/${username}";
          system = systems.x86_64-linux;
        };
      };
    };
}
