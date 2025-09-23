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
    printf "$(tput bold)$(tput setaf 1)[%s] $*$(tput sgr0)\n" "$prefix";
  }

  green() {
    printf "$(tput bold)$(tput setaf 2)[%s] $*$(tput sgr0)\n" "$prefix";
  }

  yellow() {
    printf "$(tput bold)$(tput setaf 178)[%s] $*$(tput sgr0)\n" "$prefix";
  }
}
use_red_green_echo "${BASH_SOURCE##*/}"

##### global #####

TARGET_LINK_DIR="$HOME/Documents/My Games"

realpath() {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

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

    # Settlers II: 在 macOS 15.7 中，窗口模式失效，所幸 S2/users/default01.cfg 中配置的是窗口模式，所以可以使用
    #              但是其直接把用户数据目录放在了 Documents/S2 目录下，所以需要把 target 改成 Documents
    if [[ $relative =~ S2/.* ]]; then
      target="$TARGET_LINK_DIR/../$relative"
    fi

    if [[ -h $target ]]; then
      yellow "[already exist] dir is an symlink: $target"
      yellow "pass..."
      continue
    fi

    if [[ -e $target ]]; then
      yellow "[already exist] $target"
      yellow "pass..."
      continue
    fi

    yellow "[link] to target: $TARGET_LINK_DIR/$relative"
    ln -sf "$src" "$TARGET_LINK_DIR/$relative" || echo 'something wrong...continue...'
  done

  green "[done]"
}

link_save_dirs
