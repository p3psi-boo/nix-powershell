{ pkgs ? import <nixpkgs> {} }:


pkgs.stdenv.mkDerivation rec {
  pname = "posh-git";
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "dahlbyk";
    repo = "posh-git";
    rev = "v1.0.0";
    sha256 = "1fdlim8hab7svm7g58k1n23p7la9dsfv6z4jjrw4x14s1fxsq1kr";

  };
  #buildInputs = [pkgs.gitFull.git];
  installPhase = let p =  "${pname}/${version}"; in ''
    echo ${p}
    mkdir -p $out/${p}
    cp -r src/* $out/${p}
  '';
  dontBuild = true;
  dontConfigure = true;
  doInstallCheck = false;
  dontStrip = true;
  dontFixup = true;
}
