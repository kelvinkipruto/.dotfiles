{ self,pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-nerdfont
      fira-code-symbols
      material-design-icons
      font-awesome

      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];
  };
}
