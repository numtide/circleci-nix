let
  pkgs = import <nixpkgs> {};
  inherit (pkgs.lib) fileContents;
  # Get the version of nixpkgs
  version = fileContents (pkgs.path + "/.version");
  versionSuffix = fileContents (pkgs.path + "/.version-suffix");

in
pkgs.dockerTools.buildImage {
  name = "circleci-nix";
  # TODO: tag = "${version}${versionSuffix}";
  tag = "latest";

  contents = with pkgs; [ busybox nix git cacert ];
  config = {
    Cmd = [ "/bin/sh" ];
    Env = [
      "PATH=/bin"
      "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"
    ];
    WorkDir = "/";
  };
}
