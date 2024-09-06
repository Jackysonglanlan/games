# How to use

## Dos

都是 `dosbox` 的游戏文件夹，可以在 macOS/linux 下使用，详情见 [run.dosbox.sh](../run.dosbox.sh)。

## Windows

| game name         | game dir              | how to (注意路径为 windows 路径)                                                        |
| ----------------- | --------------------- | --------------------------------------------------------------------------------------- |
| 暗黑破坏神 2      | Diable II             | put all to `$install_dir`                                                               |
| 最终幻想 8 重置版 | FF8 Remastered        | put all to `Documents\My Games\FINAL FANTASY VIII Remastered\Steam\_id_\game_data\user` |
| 三国志 10 加强版  | San10PK               | put all to `Documents\Koei`                                                             |
| 地下城守护者      | DK II                 | put all to `$install_dir\Data`                                                          |
| Tome 5            | 古墓丽影 5            | put all to `$install_dir`                                                               |
| DK4               | 大航海时代 4 加强版   | put all to `$install_dir`                                                               |
| Commando          | 盟军敢死队1: 使命召唤 | put all to `$install_dir`                                                               |

## Macos

macos 的游戏大部分为 [wine](https://gitlab.winehq.org/wine/wine/-/wikis/home) 包装的 windows 游戏，为了把 macos 上的游戏都归纳到一个目录，以实现自动化备份/同步，需要调整 `wine` 的磁盘映射。

大部分游戏存盘文件一般都在 windows 下的 `My Documents\My Games` 目录，但有些老游戏不是，这时就需要修改其 `wine` 映射(见下面第 2 步)。

有些游戏会自动创建，不需要指定。

同步游戏存档的方法如下:

```
1. Show Package Contents -> Info.plist
2. 找到 <key>Symlink My Documents</key>，把它对应的 <string></string> 值修改为 $HOME/Documents/My Games
3. 游玩游戏并存档，退出，在 $HOME/Documents/My Games 找到该游戏的存档目录，以 My Games 为 root，计算该目录相对路径
4. 在 saves/macOS 下，创建一个相对结构一样的目录，或者直接把该存档目录 copy 到 saves/macOS 下
```

当完成上述映射后，执行 `replace-save-dirs.sh` 完成存盘文件目录的 link，即可实现存档文件的 备份/恢复/同步。

现已保存的游戏:

| game name | game dir                  | 备注                                                                                                                                                               |
| --------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| S2        | 工人物语 II 10 周年纪念版 | NA                                                                                                                                                                 |
| Skyrim    | 上古卷轴5                 | NA                                                                                                                                                                 |
| Diablo II | 暗黑 II 资料片            | 需要在 `暗黑2：毁灭之王1.14D.app/Contents/Resources/user.reg` 中修改所有 `"Saved Games"` 路径为 `"My Documents"`，才能把存档文件存到 `$HOME/Documents/My Games` 下 |

## NES-FC

| game name | game dir            | how to                                                  |
| --------- | ------------------- | ------------------------------------------------------- |
| SanII     | 三国志II-霸王的大陆 | copy to `fceux` related dir or load it in the simulator |

## OpenEmu

1. 在 OpenEmu 中导入和游戏目录名称相同的 ROM
2. 从 `saves/OpenEmu` 找到对应的存档文件，拖入 OpenEmu，即可继续游戏
3. 完成游戏后，执行 `saves/OpenEmu/backup-save-files.sh` 备份存档文件到 `saves/OpenEmu`，进而可以保存到 git
