{ lib, pkgs, packageProfiles ? { ai = true; services = { colima = true; ollama = true; }; }, ... }:
let
  services = packageProfiles.services or { };
in
{
  launchd = {
    user = {
      agents =
        lib.optionalAttrs ((packageProfiles.ai or false) && (services.ollama or false))
          {
            ollama-serve = {
              command = "${pkgs.ollama}/bin/ollama serve";
              environment = {
                OLLAMA_ORIGINS = "chrome-extension://*";
              };
              serviceConfig = {
                KeepAlive = true;
                RunAtLoad = true;
                StandardOutPath = "/tmp/ollama-serve.out";
                StandardErrorPath = "/tmp/ollama-serve.err";
              };
            };
          }
        // lib.optionalAttrs (services.colima or false) {
          colima-restart = {
            command = "${pkgs.colima}/bin/colima restart";
            serviceConfig = {
              RunAtLoad = true;
            };
          };
        };
    };
  };
}
