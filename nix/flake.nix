{
  description = "stellaaa.sh's NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # home-manager, for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # Inherit from nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord for Vencord sources
    nixcord.url = "github:FlameFlag/nixcord";

    # Helix from master: LSP pull-diagnostics support (needed by the eslint
    # language server from nixpkgs 26.05) is not in any release yet.
    # No nixpkgs.follows on purpose: keeping helix's pinned nixpkgs lets the
    # helix.cachix.org binary cache hit instead of rebuilding from source.
    helix.url = "github:helix-editor/helix";
  };

  outputs = { nixpkgs, home-manager,... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.himalayan-blue-poppy = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

        # Add home-manager as a module of NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          
          home-manager.users.stellaaash = import ./home.nix;
        }

      ];
    };
  };
}
