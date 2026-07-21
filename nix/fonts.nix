{ config, pkgs, inputs, ... }:

{

fonts.packages = with pkgs; [
  font-awesome
  jetbrains-mono
  nerd-fonts.jetbrains-mono
  nerd-fonts.fira-code
];  

}
