{ config, ...}:

{ 
  security = {
    polkit.enable = true;
    audit.enable = true;
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [
     { 
       users = [ "neo" ];
       keepEnv = true;
       persist = true;
     }
    ]; 
  };
}  
