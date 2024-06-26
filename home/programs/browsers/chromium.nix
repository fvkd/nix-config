{ lib }:

let
  ext = import ./extensions.nix;
in
{
  programs.chromium = {
    enable = true;
    extensions = lib.attrValues ext;
  };
}
