{ pkgs, lib, config, ... }: {

  options = {
    firefox.enable =
      lib.mkEnableOption "enables firefox";
};

config = lib.mkIf config.firefox.enable {
  programs.firefox = {
    enable = true;
    profiles = {
      mustlane = {
	        isDefault = true;
        name = "mustlane";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "signon.showAutoCompleteFooter" = false;
        };
        userChrome = ''
          #back-button,
          #forward-button
          {
            display: none !important;
          }

          .tabbrowser-tab .tab-close-button {
            display: none;
          }

          .titlebar-buttonbox-container {
            display: none;
          }
        '';
      };
    };
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        "addon@darkreader.org" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        "ATBC@EasonWong" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adaptive-tab-bar-colour/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        "sponsorBlocker@ajay.app" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          };
        };
      };
    };
  };
}
