{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nvf.url = "github:notashelf/nvf";

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     }; 
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     };
   };


  outputs = { self, nixpkgs, nixpkgs-unstable, mangowc, nvf, ... }@inputs:
  
  let
      system = "x86_64-linux";
  in

  {

  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { 
      	inherit inputs; 

      pkgs-unstable = import nixpkgs-unstable {
      	inherit system;
	config.allowUnfree = true;
      };
    };

      modules = [ 
	./configuration.nix 
	./mangowc.nix
	./noctalia.nix
	./spotify.nix
	./neovim.nix
      ];
    };
  };
}
