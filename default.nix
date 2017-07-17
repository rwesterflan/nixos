{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 
  networking.hostName = "nixos"; 
  networking.wireless.enable = true; 

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    git
    links
    vim
    firefox
    docker
  ];

  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  users.extraUsers.rene = {
    isNormalUser = true;
    group = "rene";
    name = "rene";
    extraGroups = [
	"users"
	"wheel"
	"networkmanager"
	"audio"
     ];
    uid = 1000;
    home = "/home/rene/";
    createHome = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
