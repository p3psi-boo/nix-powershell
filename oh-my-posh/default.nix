{ pkgs }:
{
  oh-my-posh = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "oh-my-posh";
    version = "3.150.2";
    exec = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
      sha256 = "0ax0f7a3i4lrmll203n71939g9i401i59hl2nlhi1vcmbnn566ng";
      executable = true;
    };

    themes = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
      sha256 = "1l0dkr6nha1bsdrg6wa286rscqlpwyq7famkpi5dr8zx9447yfqb";
    };
    src = pkgs.fetchFromGitHub
      {
        owner = "JanDeDobbeleer";
        repo = "oh-my-posh";
        rev = "v${version}";
        sha256 = "0pi0aswhva797sj617jd5w21clw0z5lybb25rrx1qfiiizmvwisz";
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
