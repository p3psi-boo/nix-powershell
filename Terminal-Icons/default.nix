{ pkgs }:

{
  terminal-icons = import ./../common/fetcher.nix {
    inherit pkgs;
    name = "Terminal-Icons";
    ver = "0.5.0";
    sha = "0zhvwx5b3vvl3vhffjc80b9iifdldjvf4wbp5mypmybkw2w09d64";
  };

}
