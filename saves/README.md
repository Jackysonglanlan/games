# How to use

## Dos

都是 `dosbox` 的游戏文件夹，可以在 macOS/linux 下使用，详情见 [run.dosbox.sh](../run.dosbox.sh)。

## Windows

| game CH name      | game dir              | how to                                                                                  |
| ----------------- | --------------------- | --------------------------------------------------------------------------------------- |
| 暗黑破坏神 2      | Diable II             | put all to `$install_dir`                                                               |
| 最终幻想 8 重置版 | FF8 Remastered        | put all to `Documents\My Games\FINAL FANTASY VIII Remastered\Steam\_id_\game_data\user` |
| 三国志 10 加强版  | San10PK               | put all to `Documents\Koei`                                                             |
| 地下城守护者      | DK II                 | put all to `$install_dir\Data`                                                          |
| Tome 5            | 古墓丽影 5            | put all to `$install_dir`                                                               |
| DK4               | 大航海时代 4 加强版   | put all to `$install_dir`                                                               |
| Commando          | 盟军敢死队1: 使命召唤 | put all to `$install_dir`                                                               |

## NES-FC

| game CH name | game dir            | how to                                                  |
| ------------ | ------------------- | ------------------------------------------------------- |
| SanII        | 三国志II-霸王的大陆 | copy to `fceux` related dir or load it in the simulator |

## OpenEmu

1. 在 OpenEmu 中导入和游戏目录名称相同的 ROM
2. 从 `saves/OpenEmu` 找到对应的存档文件，拖入 OpenEmu，即可继续游戏
3. 完成游戏后，执行 `saves/OpenEmu/backup-save-files.sh` 备份存档文件到 `saves/OpenEmu`，进而可以保存到 git
