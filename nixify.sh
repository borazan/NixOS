#!/bin/bash
set -e
pushd /home/borazan/nixos-config/
code --wait your-workspace-name.code-workspace
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake /home/borazan/nixos-config#default &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd