#!/usr/bin/env bash

################
#
################

# WARNING: - 是打开，+ 是关闭
shopt -s expand_aliases # alias 在脚本中生效
set -euo pipefail       # e: 有错误及时退出 u: 使用未设置的变量时报警 o pipefail: pipeline 中出错时退出
# set +o posix          # 关闭 posix 的兼容检查，以便使用不兼容 posix 的语法，比如 <() 和 >()
# set -x                # 打印出所有实际执行的命令和参数
# set -f                # 禁止扩展 '*' 号(要恢复使用 +f)
trap "echo 'error: Script failed: see failed command above'" ERR

#exit_hook(){
#  echo "exit_hook"
#}
#trap exit_hook EXIT

BASH_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$BASH_DIR" ]]; then BASH_DIR="$PWD"; fi

# WARNING: 按需修改
_OPENEMU_SAVE_DIR="$HOME/Library/Application Support/OpenEmu/Save States"

# TODO: test this
backup_OpenEmu_save_files() {
  rm -rf "$BASH_DIR/Save States"
  cp -r "$_OPENEMU_SAVE_DIR" "$BASH_DIR"
}

backup_OpenEmu_save_files
