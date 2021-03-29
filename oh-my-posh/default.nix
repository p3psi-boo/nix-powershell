{ pkgs ? import <nixpkgs> { } }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "oh-my-posh";
  version = "3.129.0";
  exec = pkgs.fetchurl {
    url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
    sha256 = "1mqrgcx2pmnxj4xw282ldc0z1ia1jq9j9133cb5dwz29pfdy8sxp";
    executable = true;
  };

  themes = pkgs.fetchurl {
    url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
    sha256 = "1gfkns4byb4y30fjkr62yddjx7mmlscqvblqzk4gddb5f87qwmwl";
  };
  src = pkgs.fetchFromGitHub
    {
      owner = "JanDeDobbeleer";
      repo = "oh-my-posh";
      rev = "v${version}";
      sha256 = "0djvm3h5hpf2xa0l7x0sf6jk2kyzai5l3kfhwzbpcdr0amigkpr1";
    } + "/packages/powershell/oh-my-posh/";


  installPhase = let p = "${pname}/${version}"; in
    ''
      mkdir -p $out/${p}/themes
      mkdir -p $out/${p}/bin
      cp ${exec} $out/${p}/bin/$(stripHash ${exec})
      unzip ${themes} -d $out/${p}/themes
      cp -r * $out/${p}
    '';


  dontBuild = true;
  dontConfigure = true;
  doInstallCheck = false;
  dontStrip = true;
  dontFixup = false;
  fixupPhase = let p = "${pname}/${version}"; in ''sd  "0.0.0.1" "${version}" $out/${p}/oh-my-posh.psd1'';

  buildInputs = [ pkgs.unzip pkgs.sd ];
}
