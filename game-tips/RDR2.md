## RDR2

### 交互式地图

- https://github.com/jeanropke/RDOMap
- https://github.com/jeanropke/RDR2CollectorsMap

下载后直接放到一个 http 服务器，然后访问 `http://localhost:xx/index.html` 即可。

### 存档修改器

下载 url: https://www.mediafire.com/file/gyrxh82m2vfcfno/Red_Dead_Redemption_Save_Editor_v0410.zip/file

crossover 无法运行，只能用 VMware + Win11 运行，然后选择你想修改的存档文件，打开修改。

### Rampage

游戏内修改器，进入游戏后 F5 开启。

WARNING: 游戏版本和 Rampage 版本需要匹配

CrossOver 运行:

1. 右下角 wine configuration
2. 选择 "Library" tab
3. 添加 `dinput8.dll` + `ScriptHookRDR2.dll` -> "Editing" 中的 `native` 代表使用游戏目录中的 dll，`buildin` 则使用 crossover 自带的

WARNING:

没有装载这个修改器时，进入游戏时间几乎是瞬时，但装载以后，进入时间会显著拉长(大概需要 5 分钟)，原因不明，所以最好的策略是短暂用来 cheating:

1. 修改 dll 为("buildin then native") 装载修改器
2. 修改需要的参数
3. 存档
4. 修改 dll 为("native then buildin") 卸载修改器
5. 正常游玩

Rampage 添加物品: Character Stats -> Items -> Add From Inventory

需要使用物品 name 添加，name 列表见(TODO: 尚未测试是否正确):

1. https://raw.githubusercontent.com/femga/rdr3_discoveries/refs/heads/master/objects/object_list.lua
2. 游戏根目录下: `$root/RampageFiles/Lists/ObjectList.txt`

### Mod
