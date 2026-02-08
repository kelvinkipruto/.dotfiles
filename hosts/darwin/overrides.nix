{ ... }:
{
  # Host-specific overrides go here.
  nixpkgs.overlays = [
    (final: prev: {
      nushell = prev.nushell.overrideAttrs (old: {
        doCheck = false;
        checkPhase = "";
      });
    })
  ];
}
