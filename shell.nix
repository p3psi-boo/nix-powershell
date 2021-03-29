with import <nixpkgs> { };

(mkShell.override { stdenv = stdenvNoCC; }) {
  buildInputs = [
    nix-linter
    nixpkgs-fmt
  ];
}
