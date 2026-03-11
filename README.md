# My Games

## project structure

```
- game-tips # game walkthrough
- saves # game saves, see saves/README.md
- ROMs # simulator roms, macOS only
  - NES # for NES game
  - DOS # for DOS game
```

## NexusMods

url: https://www.nexusmods.com

用户名: spark19912 | 密码: @@@@ + LL84125b

## CrossOver

### WARNING

CrossOver 是一个 translation-layer，不是 windows kernel，这对于破解版的游戏有重大影响: 有些游戏的反盗版机制就是利用和 kernel 复杂的交互实现的，所以对于用这些方法破解的游戏，是不可能用 CrossOver 来玩的。即便游戏本身支持 CrossOver，它的破解文件也会导致崩溃。

目前搜集到的信息如下:

| 破解团队 | 能否用 CrossOver 玩 | 对应的反盗版机制 | Why                                                                                                                                                     |
| -------- | ------------------- | ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| EMPRESS  | NO                  | Denuvo           | Denuvo is the most aggressive anti-tamper tech in the industry. To bypass it, the crack has to perform deep, low-level "hooks" into the Windows kernel. |
| RUNE     | YES                 | Steam/Epic/GOG   | use a Steam Emulator (like Goldberg), this is just a tiny .dll file replacement                                                                         |

唯一解决方案是在 stream 中买正版。

所以，如果想用 CrossOver 玩盗版游戏: If a game has its Denuvo protection removed (either by the developers or by a cleaner bypass like a RUNE release), it will likely run beautifully on macOS.

寻找 RUNE 版本的盗版游戏，比如搜这个: `PCGAME-Resident.Evil.4.Gold.Edition-RUNE.torrent`

> Denuvo tech overview:
>
> Denuvo isn't just a file, it's a layer of obfuscation and triggers that run while the game is running:
>
> - periodically checks the CPU's integrity
> - requiring periodic online "phone-home" checks
>
> Technically, Denuvo isn't even "DRM"—it’s Anti-Tamper:
>
> - Steamworks (DRM): The lock on the door.
> - Denuvo (Anti-Tamper): A 10-ton steel shell built around the lock so nobody can get a screwdriver near it.
>
> _The "Boring" Truth_:
>
> Valve’s philosophy is usually **"make the legal version better than the pirated version."** They focus on fast downloads, community features, and easy updates. They view heavy DRM as a "failure of service." They allow Denuvo because they have to (to keep big publishers on the platform), but they’ll never embrace it because it fundamentally makes the user experience worse.
>
> 参考: [The Real Truth About Denuvo](https://www.youtube.com/watch?v=yTZaTcURLVY)

### 老版本下载

CrossOver 隐藏了历史老版本的下载地址，只能通过修改 url 中的版本号下载老版本:

```bash
curl -O -L 'https://cpv2.mairuan.com/crossoverchina.com/trial/Mac/crossover-25.1.1.zip' # 按需修改版本号，即可下载老版本
```

### 设置 bottle

1. 在 bottle 中安装 [DirectX 2010](https://files.holarse-linuxgaming.de/mirrors/microsoft/directx_Jun2010_redist.exe)

2. bottle 的 `Control panels -> Wine configuration -> "Libraries"`. 添加 `x3daudio_1_6`, `x3daudio_1_7`, `xaudio_2_6`, `xaudio_2_7` librares，防止某些游戏没有声音。

### DeBug 方法

1. 如果在已有的 bottle 上不能运行，可以在新版本下重新创建 bottle 并运行

2. 随着 Cross-over 的升级，某些应用会崩溃，比如 [MO2](https://github.com/ModOrganizer2/modorganizer/releases)，可以尝试重新安装，并根据崩溃日志调整安装项目，有可能解决问题。

   > 比如 cross-over v26 安装 MO2，如果是常规安装，启动就会崩溃，报告 `qtwebenginecore int3 error`，所以在安装时选择自定义安装，uncheck 所有非必要安装项，即可正常运行。推测在这些非必要选项中，有人调用了 qt web engine。究竟是哪个，可以迭代尝试。

### version matrix

一般下载的 mac 游戏都是和 wine 一起封装在一个 mac App 中，形成自包含的 wine 应用，伪装为一个 mac 游戏，这种方法有几个缺点:

1. 这个内置的 wine 封装有 2G 大，每个游戏都有一个，严重占用磁盘空间
2. wine 版本和游戏绑定，导致不能使用新版本的 wine 运行游戏，意味着无法享受 wine 不断的改进(比如 Ghost of Tsushima 音效有爆音问题)
3. 游戏不能打 Mod 或者做其他 Fix(比如使用 MO2 引用游戏目录，但因为游戏目录在 `.app` 中，可能因为权限问题引用失败)

解决方法: 把游戏目录单独拿出来，然后用 `crossover.sh link_games_to_bottle` 把游戏目录放到一个 bottle 中来跑。

但不是每个游戏都可以用这种办法，所以有这个游戏和对应的 CrossOver 对照表:

| Title                                                  | CrossOver version                   | Tips                                                                                                                                       |
| ------------------------------------------------------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Ghost of Tsushima DIRECTORS CUT `v1053.7.0809.1937`    | `26`                                | D3DMetal 完美运行                                                                                                                          |
| Skyrim 5 AE(`ENB` 使用 D3D API 拦截实现，所以不能使用) | `26` + 不能放到 `/Applications`     | D3DMetal 完美运行                                                                                                                          |
| Red Dead Redemption 2                                  | `26` + `crossover.sh link` 目录     | D3DMetal 完美运行                                                                                                                          |
| The Witcher 3                                          | `26` + `crossover.sh link` 目录     | D3DMetal 完美运行，目录 `bin/x64_dx12` 改名 `bin/x64` 然后执行 `witcher3.exe`                                                              |
| S2 - 工人物语 II 10 周年纪念版                         | `25.1.1` + `crossover.sh link` 目录 | 后续版本未测试                                                                                                                             |
| Diablo II                                              | NA / app 执行                       | 需要在 `app/Contents/Resources/user.reg` 中查找 `"Saved Games"` 改 value 为 `"My Documents"`，把存档文件存到 `$HOME/Documents/My Games` 下 |
