let fetchFromPSG = { pkgs, name, ver, sha }:

  pkgs.stdenv.mkDerivation rec {
    pname = name;
    version = ver;

    nuget = pkgs.fetchurl {
      url = "https://www.powershellgallery.com/api/v2/package/${pname}/${version}";
      executable = false;
      sha256 = sha;
    };
    buildInputs = [ pkgs.unzip ];
    src = nuget;
    unpackPhase = ''
      unzip ${nuget}
    '';
    installPhase = let p = "${pname}/${version}"; in
      ''
        mkdir -p $out/${p}
        cp -r * $out/${p}
      '';
    dontBuild = true;
    dontConfigure = true;
    doInstallCheck = false;
    dontStrip = true;
    dontFixup = true;
  };
in fetchFromPSG


