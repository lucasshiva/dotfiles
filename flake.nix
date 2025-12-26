{
  description = "Home Manager configuration of lucas";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      user = "lucas";
      homeDir = "/home/lucas";

      # We need a hardcoded absolute path for `mkOutOfStoreSymlink` to function like I want it to.
      # With this, I can edit files in the system and the changes will be reflected by files in the repo.
      # Putting this into its own option just makes it simpler to reuse.
      configDir = "${homeDir}/.config/home-manager";
    in
    {
      homeConfigurations."lucas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
            home.username = user;
            home.homeDirectory = homeDir;
            my.configDir = configDir;
          }

          ./home.nix
        ];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
