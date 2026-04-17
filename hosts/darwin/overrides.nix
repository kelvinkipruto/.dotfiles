{ ... }:
{
  # Host-specific overrides go here.
  nixpkgs.overlays = [
    (_final: prev: {
      nushell = prev.nushell.overrideAttrs (_old: {
        doCheck = false;
        checkPhase = "";
      });
    })
  ];
}
