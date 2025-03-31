#!/bin/fish

set -q XDG_CONFIG_HOME && set -l config $XDG_CONFIG_HOME || set -l config $HOME/.config
set -q XDG_STATE_HOME && set -l state $XDG_STATE_HOME || set -l state $HOME/.local/state
set -l scheme_path $state/caelestia/scheme/current.txt
set -l schemes (dirname (status filename))/../schemes

# Update theme colours
cp $schemes/template.conf $schemes/current.conf
cat $scheme_path | while read line
    set -l colour (string split ' ' $line)
    sed -i "s/\$$colour[1]/#$colour[2]/g" $schemes/current.conf
end
test "$(cat $state/caelestia/scheme/current-mode.txt)" = light && set -l def 000000 || set -l def ffffff
sed -i "s/\$default/#$def/g" $schemes/current.conf

mkdir -p $config/qt5ct/colors
mkdir -p $config/qt6ct/colors
cp $schemes/current.conf $config/qt5ct/colors/caelestia.conf
cp $schemes/current.conf $config/qt6ct/colors/caelestia.conf
