{ pkgs }:
{
  oh-my-posh = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "oh-my-posh";
    version = "3.163.0";
    exec = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
      sha256 = "1jijx3qji4vwby9y7yv56p8sya6rjfpx2ibfz4i7c03a705irxxp";
      executable = true;
    };

    themes = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
      sha256 = "0wqyq6asvk5zbsgmszbk321z3pivb91qwa4kpvp1p2lh0p60a0r7";
    };
    src = pkgs.fetchFromGitHub
      {
        owner = "JanDeDobbeleer";
        repo = "oh-my-posh";
        rev = "v${version}";
        sha256 = "1h4s4afv601xl9ispavk5ifzyivgxs5cxhcph21s9gijliazr38f";
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
