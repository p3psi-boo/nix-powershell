{ pkgs }:
{
  oh-my-posh = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "oh-my-posh";
    version = "3.151.0";
    exec = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
      sha256 = "1mq5arx8q395dj701lz2795dxgjfjxghr7y5gyw1h2l5ss4phlc4";
      executable = true;
    };

    themes = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
      sha256 = "00kr111zymi429ays2vqdiwcskpb4wj4hvlw527bbyi789np6vc6";
    };
    src = pkgs.fetchFromGitHub
      {
        owner = "JanDeDobbeleer";
        repo = "oh-my-posh";
        rev = "v${version}";
        sha256 = "1q3zl405ibicf3s8qyw8w55as3awl2k25j1sf3m84jrc33axhdg4";
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
  };
}
