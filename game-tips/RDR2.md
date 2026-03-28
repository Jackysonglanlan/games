## 交互式地图

- https://github.com/jeanropke/RDOMap
- https://github.com/jeanropke/RDR2CollectorsMap

下载后直接放到一个 http 服务器，然后访问 `http://localhost:xx/index.html` 即可。

## 存档修改器

下载 url: https://www.mediafire.com/file/gyrxh82m2vfcfno/Red_Dead_Redemption_Save_Editor_v0410.zip/file

crossover v26 无法运行，只能用 VMware + Win11 运行，然后选择你想修改的存档文件，打开修改。

## 安装 [Script Hook](http://dev-c.com/rdr2/scripthookrdr2)(Mod 依赖)

> WARNING: 只测试了 `RDR2 v1491.50` + `CrossOver v26` 环境，比这个低的环境就不要装了(也就不能玩 mod 了)，会有各种奇怪问题

Most mods in RDR2 require [Script Hook](http://dev-c.com/rdr2/scripthookrdr2/) in order to operate.

Script Hook in RDR2 is a library that allows native script functions inside of custom `*.asi` plugins. Please note that it doesn't work in multiplayer and Script Hook will forcefully close the game if the player attempts to launch multiplayer.

### Copy Files From `bin` Folder

After downloading and extracting Script Hook, you will want to copy all files from the `bin` folder to your **game root directory**:

- `ScriptHookRDR2.dll`
- `dinput8.dll`

### DLL Override

**If you skip this, the mods will not work.** You have to tell CrossOver to use your modded `dinput8.dll` instead of the default Windows one.

1.  In your CrossOver bottle sidebar, click **Wine Configuration**.
2.  Go to the **Libraries** tab.
3.  In the "New override for library" box, type exactly: `dinput8`.
4.  Click **Add**. It should appear in the list as `dinput8 (native, builtin)`.
5.  Click **Apply** and **OK**.

## [Rampage](https://www.nexusmods.com/reddeadredemption2/mods/233) + [Lenny Mod Loader](https://www.rdr2mods.com/downloads/rdr2/tools/76-lennys-mod-loader-rdr/)(LML)

> 两个都是游戏内修改器，都使用了 hook，所以有冲突。最好只用其中一个，如果两个都要，需要注意不能在游戏内同时开启，否则游戏会崩

They are **fully compatible**, but with a big "Mac Warning": using both at once can be overkill and might actually cause your CrossOver bottle to crash because they both try to "hook" the same game functions at the same time.

In the modding community, **Rampage Trainer** is widely considered the superior, modern choice. However, many people keep **Lenny's Simple Trainer (LST)** files around for one specific reason: **Online Content**.

> 有了 Rampage 后，LST 最大的价值在于可以在 offline 开启 online 专属的内容

### The "Version.dll" Situation

The main reason people use Lenny's tools today isn't for the trainer menu itself, but for a file called `version.dll`.

- **What it does:** It unlocks "Red Dead Online" items (like the Navy Revolver, specific horses, and clothing) so you can use them in the Single Player story
- **The Conflict:** If you use `version.dll` (from Lenny) and `dinput8.dll` (from Script Hook/Rampage) together, the game might get confused

### How to use both

1.  **Don't open both menus at once:** Rampage is usually `F5`, and Lenny's is usually `F3`. Opening both will likely freeze your game.
2.  **Check your Keybinds:** If you find that pressing a key triggers both trainers, you'll need to open the `.ini` config files for the mods in your RDR2 folder and change the "MenuKey" value.

## Rampage

游戏内实时修改器，可以代替存档修改器，进入游戏后 F5 开启。

WARNING: 游戏版本和 Rampage 版本需要匹配

Rampage 添加物品: Character Stats -> Items -> Add From Inventory

需要使用物品 name 添加，name 列表见(TODO: 尚未测试是否正确):

1. https://raw.githubusercontent.com/femga/rdr3_discoveries/refs/heads/master/objects/object_list.lua
2. 游戏根目录下: `$root/RampageFiles/Lists/ObjectList.txt`

## 哪些 mod 好

- https://www.nexusmods.com/games/reddeadredemption2/collections/

## How to make "ASMR" scenes

> ASMR 类似游戏电影，Youtube 上有很多，比如这个: https://www.youtube.com/watch?v=5SLpaG7ooHo

With Rampage working, here is how to use it like the video:

- **Weather:** Go to `World > Weather` and select "Thunderstorm" or "Misty". You can also lock the weather so it never changes.
- **Time:** Go to `World > Time` and use the slider to get that "Golden Hour" sunset light.
- **Arthur's Actions:** Go to `Player > Scenarios`. You can force Arthur to sit on the ground, wash his face, or smoke a cigarette indefinitely.
- **Hide HUD:** Don't forget to go into the game's **Display Settings** and turn the **HUD to OFF** for that clean cinematic look.

> **Note on D3DMetal:** If the game crashes on startup after adding the mods, go to the CrossOver bottle settings and ensure **MSync** is **ON** and **ESync** is **OFF**. Tahoe v26.3 handles MSync much better for modded bottles.

## mods 的安装顺序

每个 mod 都有前置条件，因为不想用 Mod Mananger(windows 程序)，所以打算都手动安装。

大部分都在 mod zip 包中包含了安装说明。这里记录已验证可以用的 mod，同时加上了安装顺序和方法，提高效率: 不需要一个个 readme 打开看怎样安装。

以下的 `$root` 代表 RDR2 安装的根目录。

### RDR2 Story Mode Online Outfits Immersion Pack

https://www.nexusmods.com/reddeadredemption2/mods/8380?tab=files&file_id=25685

### Red Dead Offline

1. https://www.rdr2mods.com/downloads/rdr2/scripts/7-lennys-simple-trainer/ 放在 `$root`
2. https://www.rdr2mods.com/downloads/rdr2/scripts/12-rdr-2-outfit-changer/ 放在 `$root`
3. https://www.rdr2mods.com/downloads/rdr2/weapons/103-red-dead-offline/ 放在 `$root/lml/red_dead_offline`
