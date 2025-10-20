# My emulator games

## project structure

```
- saves # game saves, see saves/README.md
- ROMs # simulator roms, macOS only
  - NES # for NES game
  - DOS # for DOS game
```

## NexusMods

url: https://www.nexusmods.com

用户名: spark19912 | 密码: @@@@ + LL84125b

## CrossOver

### 老版本下载

CrossOver 隐藏了历史老版本的下载地址，只能通过修改 url 中的版本号下载老版本:

```bash
curl -O -L 'https://cpv2.mairuan.com/crossoverchina.com/trial/Mac/crossover-25.1.1.zip' # 按需修改版本号，即可下载老版本
```

### version matrix

一般下载的 mac 游戏都是和 wine 一起封装在一个 mac App 中，形成自包含的 wine 应用，伪装为一个 mac 游戏，这种方法有几个缺点:

1. 这个内置的 wine 封装有 2G 大，每个游戏都有一个，严重占用磁盘空间
2. wine 版本和游戏绑定，不能升级，意味着可能有某些 bug(比如 Ghost of Tsushima 音效有爆音问题)

解决方法: 把游戏目录单独拿出来，然后用 `crossover.sh link_games_to_bottle` 把游戏目录放到一个 bottle 中来跑。

但不是每个游戏都可以用这种办法，所以有这个游戏和对应的 CrossOver 对照表:

| Title                                                  | CrossOver                           | Tips                                                                                                                                       |
| ------------------------------------------------------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Ghost of Tsushima DIRECTORS CUT `v1053.7.0809.1937`    | `25.1.1`                            | Graphic: D3DMetal 完美运行                                                                                                                 |
| Skyrim 5 AE(`ENB` 使用 D3D API 拦截实现，所以不能使用) | `25.1.1` + 不能放到 `/Applications` | Graphic: DXMT 完美运行                                                                                                                     |
| Red Dead Redemption 2                                  | `25.1.1` + `crossover.sh link` 目录 | Graphic: D3DMetal + 关闭 "树木曲面"，否则画面阴影闪烁                                                                                      |
| S2 - 工人物语 II 10 周年纪念版                         | `25.1.1` + `crossover.sh link` 目录 |
| Diablo II                                              | NA / app 执行                       | 需要在 `app/Contents/Resources/user.reg` 中查找 `"Saved Games"` 改 value 为 `"My Documents"`，把存档文件存到 `$HOME/Documents/My Games` 下 |
