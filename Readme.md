Forked from https://gitlab.com/ShrykeWindgrace/powershell-modules.git

# How to instantiate this stuff

```console
$ nix-build -E 'let pkgs = import <nixpkgs>{}; in pkgs.callPackage ./default.nix {inherit pkgs;}'
```

## Usage in config

```nix
{ pkgs, ... }:
let
  pwmods = import
    (builtins.fetchGit {
      url = ''git@gitlab.com:ShrykeWindgrace/powershell-modules.git'';
      ref = "master";
      rev = "85788940c2f16c7525830d0d91ce2876cbfcd9cf"; # or whatever current master revision is right now
    })
    { inherit pkgs; };

  cc = builtins.foldl' (l: r: l + ":${r.outPath}") "$env:PSModulePath += \"" (builtins.attrValues (pkgs.lib.attrsets.filterAttrs (n: v: pkgs.lib.attrsets.hasAttrByPath [ "pname" ] v) pwmods));
in
{
  xdg.configFile."config_file.ps1".text = cc;
}
```

# TODO

- [ ] Flake Support 
