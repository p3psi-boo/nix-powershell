{ pkgs }:
{
  oh-my-posh = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "oh-my-posh";
    version = "3.166.1";

    exec = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/posh-linux-amd64";
      sha256 = "16zlaxf91fgxfx5n43zc5lzjn7i8vn00p628gd561i17yx976vwg";
      executable = true;
    };

    themes = pkgs.fetchurl {
      url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v${version}/themes.zip";
      sha256 = "17f074yfh2axzdszwf35hxd0q4h5f0c83navnpj6v8ah06v6fddq";
    };

    src = pkgs.fetchFromGitHub
      {
        owner = "JanDeDobbeleer";
        repo = "oh-my-posh";
        rev = "v${version}";
        sha256 = "0cdxkwc7wly325daj5ycmghyxnibqwy3njq9yxspg296701z3mqz";
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
    preFixup = let p = "${pname}/${version}"; in 
      ''
        sd  "0.0.0.1" "${version}" $out/${p}/oh-my-posh.psd1
        patchelf --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 $out/${p}/bin/$(stripHash ${exec})
      '';

    buildInputs = [ pkgs.unzip pkgs.sd pkgs.glibc pkgs.gcc-unwrapped ];
  };
}
