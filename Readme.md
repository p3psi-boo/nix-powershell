# How to instantiate this stuff

```console
$ nix-build -E 'let pkgs = import <nixpkgs>{}; in pkgs.callPackage ./default.nix {inherit pkgs;}'
```
