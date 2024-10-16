#!/bin/bash

# TODO: add linux support

#### 启动 macos 版本的 dosbox-x

shopt -s expand_aliases
set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

ROM_PATH=$HOME/dev/workspace/my/games/ROMs/DOS/work-dir
SAVES_DIR=saves/DOS

### WARNING
#
# 因为不想把 git repo 弄得很大，所以 git 只保存存档文件(saves 目录)，所以玩 DOS 游戏的步骤如下:
#
# 1. 把游戏 ROM 目录 copy 到 ROMs/DOS/work-dir
# 2. 执行 run_game/run_game_with_cdrom 启动游戏
#
# 执行方法前，会自动从 SAVES_DIR 对应的游戏目录 copy 存档文件到执行游戏的目录，实现自动恢复存档
# 退出 dosbox 后，_backup_saves 会把游戏存档文件 copy 回 SAVES_DIR，实现自动备份

# 按需修改
# game_dir_name@save_file_regex
declare -a _GAME_SAVE_FILE_MAP
_GAME_SAVE_FILE_MAP[0]='SANGO3@\.SAV$'
_GAME_SAVE_FILE_MAP[1]='WarCraft.2.Tides.of.Darkness@\.SAV$'
_GAME_SAVE_FILE_MAP[2]='SWD2@SAVE\.DA.+'
_GAME_SAVE_FILE_MAP[2]='SWDA/SAVE@.+'
_GAME_SAVE_FILE_MAP[3]='PAL@RPG$'
_GAME_SAVE_FILE_MAP[4]='FD2@.SAV$'
_GAME_SAVE_FILE_MAP[5]='EKD1@ESAVE.+R3S$'
_GAME_SAVE_FILE_MAP[5]='BOOK1@\.SAV$'

# @return 'mac' or 'linux'
get_os_name() {
  [[ $(uname -a) == *Darwin* ]] && echo 'mac' || echo 'linux'
}

# run dosbox according to OS
# $1+: dosbox arguments
_dosbox() {
  # 默认 mac, 按需修改: dosbox-x 文件的路径
  local bin="$HOME/Games/dosbox-x/dosbox-x.app/Contents/MacOS/dosbox-x"

  if [[ $(get_os_name) == 'linux' ]]; then
    bin=dosbox-staging
  fi

  $bin "$@"
}

_game_dir_name() {
  local entry=$1
  echo "${entry%%@*}"
}

_save_file_regex() {
  local entry=$1
  echo "${entry#*@}"
}

# 拷贝游戏存档文件到 saves 文件夹
# $1: game dir name
_backup_saves() {
  local game_dir_name=$1
  for entry in "${_GAME_SAVE_FILE_MAP[@]}" ; do
    local pure_dir_name=${entry%%@*}

    if [[ ! $pure_dir_name =~ ^"$game_dir_name" ]]; then
      continue
    fi

    # make "same name dir" in saves
    local save_dir="$SAVES_DIR/$pure_dir_name"
    mkdir -p "$save_dir"

    # copy save file to dir
    local save_file_regex=${entry#*@}
    while read -r file; do
      if [[ $file =~ $save_file_regex ]]; then
        echo "[in $pure_dir_name] found save file ${file##*/}, saving to $SAVES_DIR"
        cp "$file" "$save_dir"
      fi
    done <<< "$(find "$ROM_PATH/$pure_dir_name" -maxdepth 1)"

  done
  echo "[done] all saves are copied to saves dir"
}

# 恢复存档文件到游戏目录
# $1: game dir name
_recover_saves() {
  local game_dir_name=$1
  local from_dir="$SAVES_DIR/$game_dir_name"
  local to_dir="$ROM_PATH/$game_dir_name"
  while read -r save_file; do
    echo "[recover] save file ${save_file##*/} to $to_dir"
    if [[ -e $save_file ]]; then
      cp "$save_file" "$to_dir"
    fi
  done <<< "$(find "$from_dir" -type f)"
}

# $1: dir to mount
# $2: dos-box conf file in dir
# $3+: dos command to run
run_dos() {
  local mount_dir=$1
  local conf=$2
  _dosbox -conf $conf \
    -c "mount c $mount_dir" \
    -c 'c:' \
    ${@:3}
}

# $1: ROM dir
# $2: game dir in ROM dir
# $3: game start file
run_game() {
  local rom_dir=$1
  local game_dir=$(echo "$2" | tr '[:lower:]' '[:upper:]') # DOS 游戏目录都是大写
  local start_file=$3

  local game_conf=$rom_dir/$game_dir/${game_dir}.conf # 游戏对应的配置文件为 游戏目录名.conf

  _recover_saves "$game_dir"
  run_dos "$rom_dir/$game_dir" "$game_conf" -c "$start_file"
  _backup_saves "$game_dir"
}

# $1: ROM dir
# $2: game dir in ROM dir
# $3: cdrom cue file
# $4: start file
run_game_with_cdrom() {
  local rom_dir=$1
  local game_dir=$2
  local cdrom_file=$3
  local start_file=$4

  _recover_saves "$game_dir"
  run_dos "$rom_dir" "$game_dir" -c "imgmount d $cdrom_file -t iso" -c "$start_file"
  _backup_saves "$game_dir"
}

#### main ####

# enter dos
#
# run_dos '~/Games/Games/ROMs/DOS'

# run the game you like
#
run_game "$ROM_PATH" 'SWDA' 'play.bat'
# run_game "$ROM_PATH" 'SANGO3' 'play.bat'
# run_game "$ROM_PATH" 'pal' 'pal.exe'

# 工人物语 II，进入游戏后选择 main -> capture mouse 才能激活鼠标
# run_game "$ROM_PATH" 'settler2gold' 'PLAY.BAT'
