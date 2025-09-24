# My emulator games

## project structure

```
- saves # game saves, see saves/README.md
- ROMs # simulator roms, macOS only
  - NES # for NES game
  - DOS # for DOS game
```

## Tips and Tricks

### CrossOver 老版本下载

CrossOver 隐藏了历史老版本的下载地址，只能通过修改 url 中的版本号下载老版本:

```bash
curl -O -L 'https://cpv2.mairuan.com/crossoverchina.com/trial/Mac/crossover-25.1.1.zip' # 按需修改版本号，即可下载老版本
```

### CrossOver + Games matrix

不是每个版本的 CrossOver 都向后兼容，所以有这个游戏和对应的 CrossOver 对照表:

| Title                                                  | CrossOver                           | Tips                                                  |
| ------------------------------------------------------ | ----------------------------------- | ----------------------------------------------------- |
| Ghost of Tsushima DIRECTORS CUT `v1053.7.0809.1937`    | `25.1.1`                            | Graphic: D3DMetal 完美运行                            |
| Skyrim 5 AE(`ENB` 使用 D3D API 拦截实现，所以不能使用) | `25.0.1` + 不能放到 `/Applications` | Graphic: DXMT 完美运行                                |
| RDR2                                                   | `25.1.1` + `crossover.sh link` 目录 | Graphic: D3DMetal + 关闭 "树木曲面"，否则画面阴影闪烁 |
