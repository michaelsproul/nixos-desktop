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

  # XFCE.
  services.xserver.desktopManager.xfce.enable = true;
  services.udisks2.enable = true;

  # Installed software.
  environment.systemPackages = with pkgs; [
    git
    vim
    atom
    gnome3.gnome_terminal
    coq
    ghc.ghc784
    clang
    python
    python3
    jdk
    chromium
    firefox
    gimp
    vlc
    gnome3.eog
    evince
    networkmanagerapplet
    wget
  ];
}
