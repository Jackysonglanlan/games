#!/usr/bin/env bash

. "$DEVOPS_ROOT/scripts/libs/m-formatter.sh"
use_red_green_echo "$(basename "$0")"

# see https://gist.github.com/santaklouse/a137ee51692b74d4cf2cc1bb68ed64ef?permalink_comment_id=5705629

# CrossOver 教程: https://www.youtube.com/watch?v=KbJLOFBl42M
#
# Tips:
#   1. 显示 Metal HUD 看 FPS 帧率: 右键选择 bottle， 在 Environment Var 栏右侧 "+" 选择 Metal Performance HUD，然后重启 CrossOver

# crack() {
#   green "[reseting] date..."

#   # make the current date RFC3339-encoded string representation in UTC time zone
#   local now=$(date -u -v -3H  '+%Y-%m-%dT%TZ')

#   # modify time in order to reset trial
#   plutil -replace FirstRunDate -date "${now}" ~/Library/Preferences/com.codeweavers.CrossOver.plist
#   plutil -replace SULastCheckTime -date "${now}" ~/Library/Preferences/com.codeweavers.CrossOver.plist

#   # reset all bottles
#   for file in ~/Library/Application\ Support/CrossOver/Bottles/*/.{eval,update-timestamp}; do rm -rf "${file}";done

#   green "[done]"
# }

# reset CrossOver's deadline to 14 days
# see https://knowlet3389.blogspot.com/2025/03/crossover.html
crack() {
  green "🕒 Modifying trial timestamps..."

  DATETIME=$(date -u -v -3H '+%Y-%m-%dT%TZ')
  yellow "✅ New trial date set to: ${DATETIME}"
  defaults write com.codeweavers.CrossOver FirstRunDate -date "${DATETIME}"
  defaults write com.codeweavers.CrossOver SULastCheckTime -date "${DATETIME}"

  green "✅ Updated trial timestamps in preferences."
  echo "🧹 Resetting CrossOver bottles..."
  find ~/Library/Application\ Support/CrossOver/Bottles/ -type f \( -name ".eval" -o -name ".update-timestamp" \) -exec rm -f "{}" +
  # 删除整个 `[Software\\CodeWeavers\\CrossOver\\cxoffice]` 段
  find ~/Library/Application\ Support/CrossOver/Bottles/ -type f \( -name "system.reg" \) -exec sed -i '' '/cxoffice/{N;N;N;N;d;}' "{}" \;
  green "🎉 Script completed successfully! CrossOver trial extended."
}

# 链接游戏目录到指定的 bottle 下的 "drive_c/Program Files" 目录下
#
# $1: bottle name, like "win10-64"
# $2: games dir absolute path
link_games_to_bottle() {
  local bottle_name=${1:?\$1 missing: bottle_name}
  local game_path=${@:2}

  local bottle_dir="$HOME/Library/Application Support/CrossOver/Bottles/$bottle_name/drive_c/Program Files/"

  local full_game_path=$(realpath "$game_path")
  yellow "link game $(R $full_game_path) to $(R $bottle_dir)"
  local base_game_path=${game_path##*/}
  ln -s "$full_game_path" "$bottle_dir/$base_game_path"
  green "[done]"
}

$@
