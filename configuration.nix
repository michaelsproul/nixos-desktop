{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Networking.
  networking.hostName = "michael-desktop";
  networking.hostId = "986c75a7";
  networking.networkmanager.enable = true;

  # Users.
  users.extraUsers.michael = {
    isNormalUser = true;
    home = "/home/michael";
    description = "Michael Sproul";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "password";
  };

  # Language.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_AU.UTF-8";
  };

  # Date and Time.
  time.timeZone = "Australia/Sydney";
  services.ntp = {
    enable = true;
    servers = [ "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
  };

  # SSH.
  services.openssh.enable = true;

  # CUPS for printing.
  services.printing.enable = true;

  # X11.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Login Manager.
  services.xserver.displayManager.lightdm.enable = true;

  # XFCE.
  services.xserver.desktopManager.xfce.enable = true;
  services.udisks2.enable = true;

  # Allow proprietary software, including browser plugins.
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGoogleTalkPlugin = true;
      # enableAdobeFlash = true;
    };

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };

  # Installed software.
  environment.systemPackages = with pkgs; [
    # Core.
    lightdm
    polkit_gnome
    networkmanagerapplet

    # XFCE visuals.
    hicolor_icon_theme
    gtk-engine-murrine
    gdk_pixbuf
    cairo
    librsvg

    # Development.
    git
    vim
    gnome3.gnome_terminal
    cloc

    # Languages.
    coq
    ghc.ghc784
    haskellPackages.cabalInstall
    clang
    python
    python3
    jdk

    # Applications.
    firefoxWrapper
    chromium
    gimp
    vlc
    gnome3.eog
    evince
    transmission_gtk

    # System.
    gparted

    # Misc.
    gnupg
    wget
    file
  ];
}
