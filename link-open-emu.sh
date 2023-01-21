# !/bin/sh
#

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR


link_OpenEmu_save_dir(){
  ln -sf $PWD/OpenEmu "$HOME/Library/Application Support/OpenEmu/Save States"
}


# dyna invoke method in console
$@
