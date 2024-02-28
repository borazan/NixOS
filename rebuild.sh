set -e
pushd /home/borazan/nixos-config
git diff -U0 *.nix
sudo nixos-rebuild switch --flake /home/borazan/nixos-config#default &>nixos-switch.log || (
 cat nixos-switch.log | grep --color error && false)
echo "rebuild succesful"
popd