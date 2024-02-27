set -e
pushd /home/borazan/nixos-config/
alejandra . &>/dev/null
git diff -U0 *.nix
sudo nixos-rebuild switch --upgrade --flake /home/borazan/nixos-config#default &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
popd