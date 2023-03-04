{
  description = "mthadley's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zimilar-zort.url = "github:mthadley/zimilar-zort";
  };

  outputs = { nixpkgs, home-manager, flake-utils, zimilar-zort, ... }:
    let
      systems = flake-utils.lib.system;

      mkHomeConfig = { system, username, homeDirectory, name }: {
        ${name} = home-manager.lib.homeManagerConfiguration
          {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [
              ./home.nix
              {
                home = {
                  inherit username homeDirectory;

                  sessionVariables = {
                    HOME_MANAGER_CONFIG = name;
                  };

                  # Update the state version as needed.
                  # See the changelog here:
                  # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
                  stateVersion = "23.05";
                };

                nixpkgs.overlays = [ zimilar-zort.overlays.${system}.default ];
              }
            ];
          };
      };
    in
    {
      homeConfigurations =
        mkHomeConfig
          rec {
            homeDirectory = "/Users/${username}";
            name = "mthadley-workos";
            system = systems.aarch64-darwin;
            username = "michael.hadley";
          } //

        mkHomeConfig rec {
          homeDirectory = "/Users/${username}";
          name = "mthadley-home";
          system = systems.aarch64-darwin;
          username = "mthadley";
        } //

        mkHomeConfig rec {
          homeDirectory = "/home/${username}";
          name = "ci";
          system = systems.x86_64-linux;
          username = "runner";
        };
    };
}
