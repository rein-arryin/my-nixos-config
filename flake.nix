{
  description = "Nixos Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

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
    
    # SDDM THEME
    qylock.url = "github:Darkkal44/qylock";
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   };

  outputs = { self, nixpkgs, nixpkgs-unstable, mangowc, nvf, qylock, nix-cachyos-kernel, ... }@inputs: 

  let
      system = "x86_64-linux";
      

      nvim = (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./nix/nvf.nix];
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
	./nix/mangowc.nix
	./nix/noctalia.nix
	./nix/spotify.nix
        ./nix/sddm.nix
      ];
    };
  };
}
