{ pkgs, ... }:
# Shared font configurations for both Darwin and NixOS
# Note: This returns font packages that should be added to home.packages
# and fontconfig settings for home-manager
{
  # Font packages to add to home.packages
  packages = with pkgs; [
    # Nerd Fonts (new format)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.sauce-code-pro
    
    # Programming fonts
    fira-code
    jetbrains-mono
    source-code-pro
    hack-font
    
    # System fonts
    inter
    roboto
    open-sans
    
    # Icon fonts
    font-awesome
    material-icons
  ];
  
  # Font configuration for home-manager
  fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "FiraCode Nerd Font" "JetBrains Mono" ];
      sansSerif = [ "Inter" "Roboto" ];
      serif = [ "Times New Roman" ];
    };
  };
}