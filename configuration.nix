{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop-q32hoam"; 
  networking.wireless.enable = true; 

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    wget
    git
    links
    vim
    firefox
    docker
    python
    thunderbird
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

  system.stateVersion = "17.03";

}


