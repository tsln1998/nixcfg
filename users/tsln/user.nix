{ pkgs, ... }:
{
  users.mutableUsers = false;
  users.users.tsln = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
    extraGroups = [
      "wheel"
    ];

    isNormalUser = true;
    hashedPassword = "$6$l3YXqJS1tc9F0wTK$ZbbbiVMos.hwW6h1kIv8HHpkL8dMhtFGFpop/4E/vZGSRVXClxToiWeZlLW38q4WTzH5ePn3FZx1/i6bgmWHl/";
  };
}
