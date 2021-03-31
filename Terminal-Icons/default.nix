{ pkgs }:

{
  terminal-icons =
    pkgs.stdenv.mkDerivation rec {
      pname = "Terminal-Icons";
      version = "0.2.2";
      src = pkgs.fetchFromGitHub {
        owner = "devblackops";
        repo = "Terminal-Icons";
        rev = "4f92245966fc17af106af9f85182551830eb0c1c";
        sha256 = "1wsdmpbzkhhjgs725malsiyadmshq32ndba2marv5xsb2zgva4li";

      };
      installPhase = let p = "${pname}/${version}"; in
        ''
          mkdir -p $out/${p}
          cp -r Terminal-Icons/* $out/${p}
          cp -r docs/en-US $out/${p}
        '';
      dontBuild = true;
      dontConfigure = true;
      doInstallCheck = false;
      dontStrip = true;
      dontFixup = true;
    };
}
