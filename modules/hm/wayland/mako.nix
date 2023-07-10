{ config, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#${config.colorScheme.colors.base00}";
    borderColor = "#${config.colorScheme.colors.base04}";
    width = 300;
    height = 110;
    borderSize = 2;
    defaultTimeout = 15000;
    icons = false;
    ignoreTimeout = true;
  };
}
