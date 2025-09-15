{ pkgs, ... }:
{
  launchd = {
    user = {
      agents = {
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
        colima-restart = {
          command = "${pkgs.colima}/bin/colima restart";
        };
      };
    };
  };
}
