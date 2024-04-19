{ pkgs, lib, ... }:

let
  username = "vivivi";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    any-nix-shell        # fish support for nix shell
    arandr               # simple GUI for xrandr
    #asciinema           # record the terminal
    #audacious           # simple music player
    bitwarden-cli        # command-line client for the password manager
    btop                 # alternative to htop & ytop
    #calibre              # e-book reader
    #cobang               # qr-code scanner
    #cowsay               # cowsay fortune teller with random images
    #dig                  # dns command-line tool
    #docker-compose       # docker manager
    #dive                 # explore docker layers
    #drawio               # diagram design
    #duf                  # disk usage/free utility
    eza                  # a better `ls`
    fd                   # "find" for files
    #gimp                 # gnu image manipulation program
    #gnomecast            # chromecast local files
    #insomnia             # rest client with graphql support
    #jmtpfs               # mount mtp devices
    killall              # kill processes by name
    #libreoffice          # office suite
    #libnotify            # notify-send command
    lnav                 # log file navigator on the terminal
    #multilockscreen      # fast lockscreen based on i3lock
    ncdu                 # disk space info (a better du)
    nitch                # minimal system information fetch
    nix-index            # locate packages containing certain nixpkgs
    nix-output-monitor   # nom: monitor nix commands
    nyancat              # the famous rainbow cat!
    ouch                 # painless compression and decompression for your terminal
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    #pgcli                # modern postgres client
    #playerctl            # music player controller
    prettyping           # a nicer ping
    protonvpn-gui        # official proton vpn client
    pulsemixer           # pulseaudio mixer
    rage                 # encryption tool for secrets management
    ranger               # terminal file explorer
    ripgrep              # fast grep
    #screenkey            # shows keypresses on screen
    simplescreenrecorder # screen recorder gui
    tdesktop             # telegram messaging client
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    vlc                  # media player
    xsel                 # clipboard support (also for neovim)

    # haskell packages
    haskellPackages.nix-tree # visualize nix dependencies
  ];

  gnomePkgs = with pkgs.gnome; [
    eog      # image viewer
    evince   # pdf reader
    gnome-disk-utility
    nautilus # file manager
  ];
in
{
  programs.home-manager.enable = true;

  imports = lib.concatMap import [
    ./modules
    ./programs
    ./scripts
    ./services
    ./themes
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";

    packages = defaultPkgs ++ gnomePkgs;

    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.vivaldi}";
      DISPLAY = ":0";
      EDITOR = "nvim";
      # https://github.com/NixOS/nixpkgs/issues/24311#issuecomment-980477051
      GIT_ASKPASS = "";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
