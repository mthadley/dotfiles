{
  description = "mthadley's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zimilar-zort = {
      url = "github:mthadley/zimilar-zort";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils, zimilar-zort, ... }:
    {
      packages = flake-utils.lib.eachDefaultSystemMap (system:
        let
          mkHomeConfig = { username, name }: {
            ${name} = home-manager.lib.homeManagerConfiguration
              rec {
                pkgs = nixpkgs.legacyPackages.${system};
                modules = [
                  ./home.nix
                  {
                    home = {
                      inherit username;

                      homeDirectory =
                        if pkgs.stdenv.isDarwin
                        then "/Users/${username}"
                        else "/home/${username}";

                      sessionVariables = {
                        HOME_MANAGER_CONFIG = name;
                      };

                      # Update the state version as needed.
                      # See the changelog here:
                      # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
                      stateVersion = "23.11";
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
              {
                name = "mthadley-workos";
                username = "michael.hadley";
              } //

            mkHomeConfig {
              name = "mthadley-home";
              username = "mthadley";
            };
        }
      );
    };
}
