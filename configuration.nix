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
        device = "/dev/disk/by-uuid/E3CB-73A9";
      }];
    };

    kernelModules = [ "kvm-intel" "fbcon" ];

    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "sakuya"; 
  networking.hostId = "8425e349";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  environment.systemPackages = with pkgs; [
    bash 
    binutils
    chromium
    cryptsetup
    discord
    docker
    file
    freerdp
    gimp
    git
    gnupg
    i3 i3lock i3status
    inkscape
    kdeconnect
    keepass
    keepassx2
    libreoffice
    links
    lsof
    mkpasswd
    networkmanagerapplet networkmanager networkmanager_openvpn
    neofetch
    nfsUtils
    nmap
    openvpn
    packer
    psmisc
    python
    pypy
    pythonPackages.virtualenv
    screen
    seafile-client
    steam
    tigervnc
    thunderbird
    tlp
    unzip
    vagrant
    vim
    virtualbox
    wget
    xfce.exo
    xfce.terminal
    xfce.thunar
    xfce.xfce4-hardware-monitor-plugin
    xfce.xfce4icontheme
    xfce.xfce4settings
    xfce.xfce4_whiskermenu_plugin
    xfontsel
    zip
  ];

  hardware.opengl.driSupport32Bit = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

  system.autoUpgrade.enable = true;

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
    passwordAuthentication = true;
    permitRootLogin = "no";
  };
  
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  #programs.zsh.enable = true;
  services.zfs.autoSnapshot.enable = true;
  
  networking.firewall = {
     allowedTCPPorts = [ 22 ];
     allowedUDPPorts = [ 27036 27037 ];
  };

  programs.adb.enable = true;

#  powerManagement.cpuFreqGovernor = null;
  services.tlp.enable = true;   
  services.printing.enable = true;
  services.pcscd.enable = true;
  services.xserver = {  
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
    synaptics = {
        enable = true;
        twoFingerScroll = true;
    };
  };

  users.extraUsers.rene = {
    isNormalUser = true;
    group = "rene";
    name = "rene";
    extraGroups = [
	"users"
	"wheel"
	"networkmanager"
	"audio"
        "docker"
	"dialout"
        "adbusers"
     ];
    uid = 1000;
    home = "/home/rene/";
    createHome = true;
    shell = "/run/current-system/sw/bin/bash";
  };

  users.extraGroups.rene= {
    gid = 1000;
  };

  system.stateVersion = "17.09";
}
