{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./options.nix
    ./niri
    ./kitty
  ];
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

    # Fonts
    nerd-fonts.monaspace # Coding font
    inter # Interface font
    merriweather # Document font

    # Formatter for Nix files.
    nixfmt-rfc-style

    # A command-line benchmarking tool.
    hyperfine
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

  programs.git = {
    enable = true;
    settings = {
      user.name = "Lucas Silva";
      user.email = "silva.lucasdev@gmail.com";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3"; # For `delta`.
    };
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
  home.sessionVariables = {
    EDITOR = "code --wait";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
  };

  home.sessionPath = [
    # Add custom paths to the $PATH environment variable.
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin"
    "$HOME/fvm/bin"
    "$HOME/.pub-cache/bin"
  ];

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

  # NOTE: Don't remove system bash.
  # Bash is the default login shell, but we run `fish` when possible.
  programs.bash = {
    enable = true;
    initExtra = ''
      		if command -v fish >/dev/null; then
      		  exec fish
      		fi
      	'';
  };

  # Fish as the login shell is not ideal because it's not POSIX compliant.
  # So we use bash/zsh as the login shell and spawn fish from there.
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = ''
      set -g fish_greeting
    '';
  };

  # These aliases apply to all shells managed by Home Manager.
  home.shellAliases = {
    cat = "bat --paging=never";
    bat = "bat --color=always";
    hms = "home-manager switch";

    # To colorize help messages.
    # Example: delta --help | bathelp
    #
    # We could define a shell function instead. Then, we could use it without piping like so:
    # help delta
    bathelp = "bat -plhelp";
  };

  # Shell prompt.
  # Maybe we could move this into a starship.nix file.
  # That way, starship.nix and starship.toml would live together in the same folder.
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = lib.importTOML ./starship/starship.toml;
  };

  # A modern alternative for ls.
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    extraOptions = [
      "--header"
      "--group-directories-first"
    ];
    icons = "auto"; # This requires a nerd font.
    git = true;
    colors = "always";
  };

  # `cat` clone with syntax highlighting and git integration.
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman # To colorize man pages.
      batgrep # Uses bat as printer for `ripgrep` search results.
    ];
  };

  # Fast text searcher. Can be used as a faster `grep` alternative.
  programs.ripgrep = {
    enable = true;
  };

  # Syntax highlighting for git diffs.
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "Catppuccin Mocha";
    };
  };

  # Fuzzy finder.
  # Automatically adds Ctrl+T for file search and Ctrl+R for command history search.
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # Password manager.
  # We could also manage the settings from here, but I don't mind doing it from the GUI.
  programs.keepassxc.enable = true;

  # Manage XDG base directories, like XDG_DATA_HOME, XDG_CACHE_HOME, etc.
  xdg.enable = true;

  # Helps with OpenGL, EGL, and other graphical issues when using Nix programs outside of NixOS.
  # See https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-sudo
  # NOTE: Don't forget to run `sudo /nix/store/pgmv59l0v8kfx9zsw431amm18cl7s3av-non-nixos-gpu/bin/non-nixos-gpu-setup` after activation.
  # NOTE2: This isn't perfect. We might need NixGL, configure NVIDIA drivers manually, or install graphical applications via `pacman`.
  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
