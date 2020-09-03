with import <nixpkgs> {};

let
  rangehttpserver = python3Packages.buildPythonPackage {
    pname = "RangeHTTPServer";
    version = "1.2.0";
    src = fetchFromGitHub {
      owner = "danvk";
      repo = "RangeHTTPServer";
      rev = "1.2.0";
      sha256 = "1sy9j6y8kp5jiwv2vd652v94kspp1yd4dwxrfqfn6zwnfyv2mzv5";
    };
    doCheck = false;
    meta = with lib; {
      homepage = http://github.com/danvk/RangeHTTPServer;
      description = "SimpleHTTPServer with support for Range requests";
      license = licenses.asl20;
    };
  };
  fsmonitor = python3Packages.buildPythonPackage {
    pname = "fsmonitor";
    version = "0.1p";
    src = fetchFromGitHub {
      owner = "shaurz";
      repo = "fsmonitor";
      rev = "4d84d9817dce7b274cb4586b5c2091dea96982f9";
      sha256 = "1cp7par6pvm0d2m40wylm445l5yy7zngjdd8bc34xy5vwhvcmb27";
    };
    doCheck = false;
    meta = with lib; {
      homepage = http://github.com/shaurz/fsmonitor;
      description = "Filesystem monitoring library for Python";
      license = licenses.mit;
    };
  };
  backtrace = python3Packages.buildPythonPackage rec {
    pname = "backtrace";
    version = "0.2.1";
    src = fetchFromGitHub {
      owner = "nir0s";
      repo = "backtrace";
      rev = "d4ebd760f0fdb8410feae4d88b563f258f829bbd";
      sha256 = "1n4v0ihli5wmr5l75270qimv3ch2xzjj4hlrql2x2cawh39fxhnh";
    };
    meta = {
      homepage = "https://github.com/nir0s/backtrace";
      license = stdenv.lib.licenses.asl20;
      description = "Makes Python tracebacks human friendly";
    };
    prePatch = ''
      touch LICENSE
    '';
    propagatedBuildInputs = [ python3Packages.colorama ];
    buildInputs = [ python3Packages.pytest ];
  };
in
(python3.withPackages (ps: with ps; [
  GitPython
  ansible
  backtrace
  cachecontrol
  cloudpickle
  colorama
  fasteners
  #fsmonitor
  inotify-simple
  lockfile
  paramiko
  pexpect
  pyxdg
  rangehttpserver
  requests
  requests-mock
  ruamel_yaml
])).env
