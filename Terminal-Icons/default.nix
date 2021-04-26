{ pkgs }:

{
  terminal-icons =
    pkgs.stdenv.mkDerivation rec {
      pname = "Terminal-Icons";
      version = "0.5.0";

      nuget = pkgs.fetchurl {
        url = "https://www.powershellgallery.com/api/v2/package/${pname}/${version}";
        executable = false;
        sha256 = "0zhvwx5b3vvl3vhffjc80b9iifdldjvf4wbp5mypmybkw2w09d64";
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
}
