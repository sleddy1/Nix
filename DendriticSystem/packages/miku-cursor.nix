{ lib, fetchFromGitHub, stdenv, gtk3, makeWrapper, xorg }:

stdenv.mkDerivation rec {
  pname = "hatsune-miku-cursors";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "supermariofps";
    repo = "hatsune-miku-windows-linux-cursors";
    rev = "master";
    sha256 = lib.fakeSha256;  # Replace this with the actual sha256 hash after you build the package once
  };

  nativeBuildInputs = [ makeWrapper ];

  meta = with lib; {
    description = "Hatsune Miku Windows/Linux cursors";
    license = licenses.mit;
    platforms = platforms.linux;
  };

  # Install the cursors to the right place
  installPhase = ''
    mkdir -p $out/share/icons
    cp -r ${src}/cursor-theme/* $out/share/icons/
  '';
}