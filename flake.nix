{
  description = "rawrlyn";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "media-player";
      version = "1.0";

      src = pkgs.fetchurl {
        url = "https://objects.githubusercontent.com/github-production-release-asset-2e65be/868459808/b6c3d24d-7819-4c03-bf3c-66f0de0333fd?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241007%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241007T121050Z&X-Amz-Expires=300&X-Amz-Signature=6cbe427c37b2517bd6484024049ca9605697b7e109d7b3299d6aa1516abce3a3&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dtauri-media-player_0.1.0_amd64.deb&response-content-type=application%2Foctet-stream";
        sha256 = "sha256-/n0LFQaKbyLzzH5iy8XzG/3JEiCbEqUMvz6pKFiENDc=";
      };

      nativeBuildInputs = with pkgs; [
        autoPatchelfHook
        dpkg
      ];

      buildInputs = with pkgs; [
        glib-networking
        openssl
        webkitgtk
        wrapGAppsHook
        pkg-config
        alsa-lib
      ];

      unpackCmd = "dpkg-deb -x $curSrc source";

      installPhase = "mv usr $out";

      meta = with pkgs.lib; {
        sourceProvenance = with sourceTypes; [
          binaryNativeCode
        ];

        description = "media app thingy";

        license = licenses.mit;

        platforms = platforms.linux;
        mainProgram = "tauri-media-player";
      };
    };
  };
}
