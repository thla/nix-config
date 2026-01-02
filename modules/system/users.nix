{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thomas = {
    isNormalUser = true;
    description = "Thomas Lamparter";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #kdePackages.kate
      #  thunderbird
    ];
  };
}
