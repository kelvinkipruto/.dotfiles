{ pkgs, ... }:
{
  ai = [
    pkgs.ollama
  ];

  androidSecurity = [
    pkgs.apktool
    pkgs.dex2jar
    pkgs.frida-tools
    pkgs.jadx
  ];
}
