let
  holonixPath = builtins.fetchTarball { # main as of Mar 15, 2022
    url = "https://github.com/holochain/holonix/archive/391557dc5b3065b0d357ea9f9a2bc77e7347be8e.tar.gz";
    sha256 = "10dnbd3s8gm4bl7my7c168vyvi3358s1lb5yjnw3fwnp9z62vy09";
  };
  holonix = import (holonixPath) {
    include = {
      holochainBinaries = true;
      node = false;
      scaffolding = false;
      happs = false;
    };

    holochainVersionId = "custom";
    holochainVersion = {
      url = "https://github.com/holochain/holochain";
      rev = "holochain-0.0.139"; # May 11, 2022 - 9356749f7fecf2414d2d388f74037514f65571ef
      sha256 = "0xy7hxyaliwms8p083lqn9qqpgk62f56zsl6zrgw7v0lrrd2lcfd";
      cargoLock = {
        outputHashes = {
        };
      };

      binsFilter = [
        "holochain"
        "hc"
        "kitsune-p2p-tx2-proxy"
      ];

      rustVersion = "1.58.1";

      lair = {
        url = "https://github.com/holochain/lair";
        rev = "lair_keystore-v0.1.3"; # May 5, 2022 - 27e3a4e305e2a5d48ba625aa3bfac9516d2583ed
        sha256 = "0xisp3rqdnjsypxpjcin94qwsgvb99vwisq49jjl6x7qxl2s3afm";

        binsFilter = [
          "lair-keystore"
        ];

        rustVersion = "1.58.1";

        cargoLock = {
          outputHashes = {
          };
        };
      };
    };
  };
  nixpkgs = holonix.pkgs;
in nixpkgs.mkShell {
  inputsFrom = [ holonix.main ];
}
