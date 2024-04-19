let
  more = {
    services = {
      flameshot.enable = false;

      #gnome-keyring = {
        #enable = true;
        #components = [ "pkcs11" "secrets" "ssh" ];
      };
    };
  };
in
[
  #./dunst
  #./gpg-agent
  #./networkmanager
  #./picom
  #./polybar
  #./screenlocker
  #./udiskie
  more
]
