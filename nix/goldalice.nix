# Gaming account for my sister. Was created via KDE; now declared here.
# uid pinned to 1001 to match the pre-existing account so her /home is preserved.
{ pkgs, ... }:

{
  users.users.goldalice = {
    isNormalUser = true;
    uid = 1001;
    description = "goldAlice";
    # No 'wheel' on purpose -> no sudo/admin. networkmanager lets her join wifi.
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [
      firefox
      discord
      prismlauncher
    ];
  };
}
