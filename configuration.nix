{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "ahci" ];
      kernelModules = [ "fbcon" ];
      luks.devices = [{
        name = "cypher";
        device = "/dev/disk/by-uuid/73ef5df7-d331-473e-ac6e-42f0176d37da";
      }];
    };

    kernelModules = [ "kvm-intel" "fbcon" ];

    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];

    tmpOnTmpfs = true;
  };

  fileSystems."/" = {
    device = "tank/nixos";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "tank/nix";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "tank/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/a9669530-a697-4656-98e6-326b5099639b";
    fsType = "vfat";
  };

  networking.hostName = "sakuya"; 
  networking.wireless.enable = true; 

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    cryptsetup
    wget
    git
    links
    vim
    firefox
    docker
    python
    thunderbird
    nmap
    keepass
    libreoffice
    chromium
    binutils
    screen
    networkmanagerapplet
    gnupg
    steam
    tahoelafs
    openvpn
    nfsUtils
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  services.redshift = {
    enable = true;
    latitude = "52.7";
    longitude = "6.22";
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  programs.zsh.enable = true;

  networking.firewall = {
     allowedTCPPorts = [ "22" ];
  };

  services.printing.enable = true;

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
    shell = "/run/current-system/sw/bin/zsh";
  };

  system.stateVersion = "18.03";
}