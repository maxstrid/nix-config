{ lib, config, pkgs, ...}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions =
      let
        createChromiumExtensionFor = browserVersion: { id, sha256, version }:
        {
          inherit id;
          crxPath = builtins.fetchurl {
            url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
            name = "${id}.crx";
            inherit sha256;
          };
          inherit version;
        };
      createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
    in
    [
      (createChromiumExtension {
        # ublock origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        sha256 = "sha256:0qfphf8abzvy9cng8112zzbs9vsnbdqwjwywigk8nrgh4pignvb1";
        version = "1.49.2";
      })
      (createChromiumExtension {
        # classlink 
        id = "jgfbgkjjlonelmpenhpfeeljjlcgnkpe";
        sha256 = "sha256:09w4383kac87g3im76pqfxsfddmscrrlh1nv4xdc1fml5sdjj41x";
        version = "10.8";
      })
    ];
  };
}
