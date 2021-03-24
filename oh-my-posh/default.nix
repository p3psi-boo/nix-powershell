{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "oh-my-posh";
  version = "3.120.0";
  exec = pkgs.fetchurl {
    url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
    sha256 = "0didwpy99p8wzjm9aj99cfaf77knf858cq7nqhmg2q336l7ccmyw";
    executable = true;
  };

  themes = pkgs.fetchurl {
    url =  "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
    sha256 = "0p77z8via3y6m873v89hqyr7h5g9kss6qamd1045d8cb7np6r349";
  };
  src = pkgs.fetchFromGitHub{
    owner = "JanDeDobbeleer";
    repo = "oh-my-posh";
    rev = "v${version}";
    sha256= "1ivdbs1m4kgqc7sj8js0xlihgpgv7ncmymp6mpd1f3wr0iapadqw";
  } + "/packages/powershell/oh-my-posh/";


  installPhase = let p =  "${pname}/${version}"; in ''
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
  fixupPhase =  let p =  "${pname}/${version}"; in ''sd  "0.0.0.1" "${version}" $out/${p}/oh-my-posh.psd1'';

  buildInputs = [pkgs.unzip pkgs.sd];
}
