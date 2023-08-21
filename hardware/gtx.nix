{ inputs, outputs, lib, config, pkgs, ... }:

services.xserver.videoDrivers = [ "nvidiaLegacy490" ];
