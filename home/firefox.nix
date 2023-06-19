{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      "Default" = {
        bookmarks = [{
          name = "Roborio Setup";
          url = "https://docs.wpilib.org/en/stable/docs/zero-to-robot/step-3/imaging-your-roborio.html";
        }];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];
        search = {
          default = "Google";
          force = true;
        };
        settings = {
          "browser.compactmode.show" = true;
          "browser.newtabpage.enabled" = false;
          "browser.startup.homepage" = "https://google.com";
          "browser.uidensity" = 1;

          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionPolicyAcceptedVersion" =  2;
          "datareporting.policy.dataSubmissionPolicyNotifiedTime" = "1685901176127";

          "extensions.pocket.enabled" = false;
          "extensions.activeThemeID" = "default-theme@mozilla.org";
        };
      };
    };
  };
}
