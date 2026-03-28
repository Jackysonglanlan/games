#!/usr/bin/env bash

################
#
################

# WARNING: - 是打开，+ 是关闭
shopt -s expand_aliases # alias 在脚本中生效
set -euo pipefail       # e: 有错误及时退出 u: 使用未设置的变量时报警 o pipefail: pipeline 中出错时退出
# set +o posix          # 关闭 posix 的兼容检查，以便使用不兼容 posix 的语法，比如 <() 和 >()
# set -x                # 打印出所有实际执行的命令和参数
# set -v                # 当命令进行读取时显示输入
# set -f                # 禁止扩展 '*' 号(要恢复使用 +f)
trap "echo 'error: Script failed: see failed command above'" ERR

#exit_hook(){
#  echo "exit_hook"
#}
#trap exit_hook EXIT


################
##### Tips #####
################




####################
###### global ######
####################

#BASH_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
BASH_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$BASH_DIR" ]]; then BASH_DIR="$PWD"; fi

. "$DEVOPS_ROOT/scripts/libs/m-formatter.sh"
use_red_green_echo "$(basename "$0")"



################
### private ####
################




################
#### public ####
################

# 使用 7z 压缩游戏目录 $game_dir_path 到 $zip_file_path
#
# E.g:
#   archive '/Volumes/games/Ghost of Tsushima DIRECTORS CUT.7z' './Ghost of Tsushima DIRECTORS CUT'
#
# $1: zip_file_path
# $2: game_dir_path
archive() {
  local zip_file_path=${1:?\$1 missing: zip_file_path}
  local game_dir_path=${2:?\$2 missing: game_dir_path}
  7z a "$zip_file_path.7z" "$game_dir_path"
}


################
##### main #####
################

archive "$1" "$2"
