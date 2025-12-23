{ lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    nerd-fonts.monaspace  # Coding font
    inter  # Interface font
    merriweather  # Document font
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #  /etc/profiles/per-user/lucas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lucas Silva";
      user.email = "silva.lucasdev@gmail.com";
      init.defaultBranch = "main";
    };
  };

  # Though we can set the default shell directly in home-manager,
  # it would require activation scripts and root access on activation.
  #
  # Therefore, we spawn the default shell (zsh or fish) through bash.
  # For example, add the following in .bashrc to enable fish:
  #
  # # If not running interactively, don't do anything
  # [[ $- != *i* ]] && return
  #
  # if command -v fish >/dev/null; then
  #   exec fish
  # fi

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 20000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = ''
      set -g fish_greeting
    '';
  };

  # Maybe we could move this into a starship.nix file.
  # That way, starship.nix and starship.toml would live together in the same folder.
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = lib.importTOML ./starship/starship.toml;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    extraOptions = [
      "--header"
      "--group-directories-first"
    ];
    icons = "auto";  # This requires a nerd font.
    git = true;
    colors = "always";
  };

  # Maybe we could also manage the settings from here.
  programs.keepassxc.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
