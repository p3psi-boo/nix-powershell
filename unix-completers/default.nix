{ pkgs }:

{
  unix-completers = import ./../common/fetcher.nix {
    inherit pkgs;
    name = "Microsoft.PowerShell.UnixCompleters";
    ver = "0.1.1";
    sha = "0x09x9pyrqgk9d2vdq6glxigk0mjwgqwyk26dmdravxp0a955zr7";
  };
}
