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
        url = "https://objects.githubusercontent.com/github-production-release-asset-2e65be/868459808/dccf1faa-1833-4bd8-bece-a034cd582eec?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241006%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241006T164944Z&X-Amz-Expires=300&X-Amz-Signature=7b5592787a82d4ce7753560db420904f75622e2d1d7fb052d09fd839288d536f&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dtauri-media-player_0.1.0_amd64.deb&response-content-type=application%2Foctet-stream";
        sha256 = "sha256-3TTOXVzykkXn58+wV/0t+Wv7Clpw2swfQKwVFcYnJps=";
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
