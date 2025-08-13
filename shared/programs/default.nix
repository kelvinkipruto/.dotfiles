{ pkgs, ... }:
# Shared program configurations for both Darwin and NixOS
{
  home-manager = {
    enable = true;
  };
  
  # Terminal tools
  alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "full";
        opacity = 0.95;
      };
      font = {
        normal.family = "FiraCode Nerd Font";
        size = 14;
      };
    };
  };
  
  bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -FR";
    };
  };
  
  eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = true;
  };
  
  fd = {
    enable = true;
  };
  
  fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
  };
  
  htop = {
    enable = true;
    settings = {
      show_cpu_frequency = true;
      show_cpu_temperature = true;
    };
  };
  
  jq = {
    enable = true;
  };
  
  lazygit = {
    enable = true;
  };
  
  # Development tools
  git = {
    enable = true;
    userName = "Kelvin Kipruto";
    userEmail = "kelvin@example.com"; # Update with your actual email
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = true;
    };
  };
  
  gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };
  
  gpg = {
    enable = true;
    settings = {
      default-key = "your-key-id"; # Update with your actual GPG key ID
    };
  };
  
  # Editors
  neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  
  # Shell integration
  direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  
  ripgrep = {
    enable = true;
  };
  
  tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = ''
      # Set prefix to Ctrl-a
      set -g prefix C-a
      unbind C-b
      bind C-a send-prefix
      
      # Enable mouse support
      set -g mouse on
      
      # Start windows and panes at 1
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };
  
  zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  
  # Shell configuration
  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Shell aliases are imported from shared environment
    shellAliases = (import ../environment.nix { inherit pkgs; }).shellAliases;
    
    initExtra = ''
      # Load p10k configuration if it exists
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

}