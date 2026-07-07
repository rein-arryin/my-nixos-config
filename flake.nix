{
  description = "Nixos Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    qylock.url = "github:Darkkal44/qylock";

    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     }; 
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     }; 
      
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
     };
    
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };  
   };

  outputs = { self, nixpkgs, nixpkgs-unstable, mangowc, nvf, qylock, ... }@inputs:
  
  let
      system = "x86_64-linux";

    nvim = (nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./nvf-configuration.nix ];
    }).neovim;
  in

  {

  packages.${system}.default = nvim;

  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { 
      	inherit inputs nvim; 

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
        ./sddm.nix
        nvf.nixosModules.default
      ];
    };
  };
}
