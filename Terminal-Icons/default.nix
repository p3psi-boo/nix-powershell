{ pkgs }:

{
  terminal-icons = import ./../common/fetcher.nix {
    inherit pkgs;
    name = "Terminal-Icons";
    ver = "0.5.2";
    sha = "1s1nx6pvi4lk809mx35nalwgciyjrlxmc2zbp9vl2rjw687izfaf";
  };

}
