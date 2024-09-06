#!/usr/bin/env bash

################
# 把 macOS 目录下的存档文件目录 link 到对应的游戏目录，实现存档文件的 备份/恢复/同步
#
# WARNING: 只需执行一次即可
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

##### utils #####

use_red_green_echo() {
  prefix="$1"
  red() {
    printf "$(tput bold)$(tput setaf 1)[$prefix] $*$(tput sgr0)\n";
  }

  green() {
    printf "$(tput bold)$(tput setaf 2)[$prefix] $*$(tput sgr0)\n";
  }

  yellow() {
    printf "$(tput bold)$(tput setaf 178)[$prefix] $*$(tput sgr0)\n";
  }
}
use_red_green_echo "${BASH_SOURCE##*/}"

##### global #####

TARGET_LINK_DIR="$HOME/Documents/My Games"

SOURCE_DIR="$(realpath $(dirname $0))"

##### private #####



##### public #####

# 把 macOS 目录下的存档文件目录 link 到对应的游戏目录，实现存档文件的 备份/恢复/同步
link_save_dirs() {
  longest_pathes=()
  while read -r game_dir; do
    echo "$game_dir"
    if [[ ${#longest_pathes} == 0 ]]; then
      green "[find] longest game save dir: $game_dir"
      longest_pathes+=("$game_dir")
      continue
    fi

    # game_dir 由长到短遍历，发现某个 path 是 longest_pathes 的 prefix，就过滤不要
    need=true
    for path in "${longest_pathes[@]}"; do
      local is_prefix="${path/#$game_dir/1}" # 如果是 prefix，path 替换为 1 开头
      # echo ${is_prefix:0:1} $game_dir -> $path
      if [[ "${is_prefix:0:1}" == 1 ]]; then
        need=false
      fi
    done

    if [[ $need == 'true' ]]; then
      green "[find] longest game save dir: $game_dir"
      longest_pathes+=("$game_dir")
    fi
    # 下面的 @@ 作为 awk 的 FS，防止目录名称中有空格导致解析错误
  done <<< "$(find "$SOURCE_DIR" -type d | awk '{ printf "%d@@%s\n", length ($0), $0 }' | sort -n -r | awk -F '@@' '{print $2}')" # path 由长到短遍历

  for src in "${longest_pathes[@]}"; do
    relative=${src##"$SOURCE_DIR/"}
    target="$TARGET_LINK_DIR/$relative"
    # echo $target

    if [[ -h $target ]]; then
      yellow "[already exist] dir is an symlink: $target"
      continue
    fi

    yellow "[link] to target: $TARGET_LINK_DIR/$relative"
    ln -sf "$src" "$TARGET_LINK_DIR/$relative"
  done

  green "[done]"
}

link_save_dirs
