ffmpeg = (pkgs.ffmpeg.override {
            withVulkan = true;
            withNvdec = false;
            withNvenc = false;
          }).overrideAttrs (oldAttrs: rec {
            pname = "ffmpeg";
            version = "git";
              src = prev.fetchgit {
                url = "https://git.ffmpeg.org/ffmpeg.git";
                rev = "c258623c0a635d98e7e21123215446ebd2201b1e";
                hash = "sha256-AovLOR7L9eMWY2qdxdmsImOLWD0ZcrkavQOaeLJ8c88=";
              };
            patches = [];
            postPatch = '''';
          });
