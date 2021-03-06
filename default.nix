{ pkgs ? import <nixpkgs> {} }:

let
  oh-my-posh = import ./oh-my-posh { inherit pkgs; };
  posh-git = import ./posh-git/default.nix { inherit pkgs; };
  terminal-icons = import ./Terminal-Icons/default.nix { inherit pkgs; };
  unix-completers = import ./unix-completers/default.nix { inherit pkgs; };
in
oh-my-posh // posh-git // terminal-icons // unix-completers


# //
# pkgs.lib.attrsets.filterAttrs (n: v: pkgs.lib.attrsets.hasAttrByPath [ "pname" ] v) pw

#builtins.concatMap (d: [d.pname]) (builtins.attrValues (pkgs.lib.attrsets.filterAttrs (n: v: pkgs.lib.attrsets.hasAttrByPath [ "pname" ] v) pw))
