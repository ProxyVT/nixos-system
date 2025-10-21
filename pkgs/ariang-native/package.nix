{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:

buildNpmPackage rec {
  pname = "ariang-native";
  version = "1.3.11";

  src = fetchFromGitHub {
    owner = "mayswind";
    repo = "AriaNg-Native";
    rev = version;
    hash = "sha256-xbhvGkxFMCujW5D6yc4U+g8SEB97jiQhHHUhoD+t1Io=";
  };

  npmDepsHash = "sha256-E97WNheJkrvinTMln4skXXFdGw8sD1zexKjV08ZCG30=";

  makeCacheWritable = true;

  meta = {
    description = "A better aria2 desktop frontend than AriaNg, with all features of AriaNg and providing more features for desktop usage";
    homepage = "https://github.com/mayswind/AriaNg-Native";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "ariang-native";
    platforms = lib.platforms.all;
  };
}
