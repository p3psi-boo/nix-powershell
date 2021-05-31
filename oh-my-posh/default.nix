{ pkgs }:
{
  oh-my-posh = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "oh-my-posh";
    version = "3.159.0";
    exec = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
      sha256 = "1ypr84hgpc84d5whyafhanyryixv6wf1zrspxa0yypk4221s28dw";
      executable = true;
    };

    themes = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
      sha256 = "0844w81afwva95r96v3qpzid9yzy6rpwnnxar1lmr485wjzz1gj8";
    };
    src = pkgs.fetchFromGitHub
      {
        owner = "JanDeDobbeleer";
        repo = "oh-my-posh";
        rev = "v${version}";
        sha256 = "1i2aajqd5ga02hfm352zycaxy5dsv5d9v9mshba9sj3ya4wd7z6r";
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
