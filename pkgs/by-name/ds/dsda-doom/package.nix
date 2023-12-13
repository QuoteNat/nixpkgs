{ lib
, stdenv
, fetchFromGitHub
, cmake
, SDL2
, SDL2_mixer
, SDL2_image
, SDL2_net
, fluidsynth
, soundfont-fluid
, portmidi
, dumb
, libvorbis
, libmad
, pcre
, libzip
, alsa-lib
, libGLU
}:

stdenv.mkDerivation rec {
  pname = "dsda-doom";
  version = "0.27.5";

  src = fetchFromGitHub {
    owner = "kraflab";
    repo = "dsda-doom";
    rev = "v${version}";
    sha256 = "sha256-+rvRj6RbJ/RaKmlDZdB2oBm/U6SuHNxye8TdpEOZwQw=";
  };

  sourceRoot = "${src.name}/prboom2";

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    SDL2
    SDL2_mixer
    SDL2_image
    SDL2_net
    fluidsynth
    portmidi
    dumb
    libvorbis
    libmad
    pcre
    libzip
    alsa-lib
    libGLU
  ];

  # Fixes impure path to soundfont
  prePatch = ''
    substituteInPlace src/m_misc.c --replace \
      "/usr/share/sounds/sf3/default-GM.sf3" \
      "${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2"
  '';
  
  meta = with lib; {
    homepage = "https://github.com/kraflab/dsda-doom";
    description = "This is a successor of prboom+ with extra tooling for demo recording and playback, with a focus on speedrunning and quality of life.";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.QuoteNat ];
  };
}
