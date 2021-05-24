{ pkgs }:

{
  terminal-icons = import ./../common/fetcher.nix {
    inherit pkgs;
    name = "Terminal-Icons";
    ver = "0.5.1";
    sha = "0g0llcfldzyrf3pgga86fc6532270wlg53w6ji5fxzx1ws28n70d";
  };

}
