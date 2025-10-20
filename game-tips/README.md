## RDR2

### 存档修改器

下载 url: https://www.mediafire.com/file/gyrxh82m2vfcfno/Red_Dead_Redemption_Save_Editor_v0410.zip/file

crossover 无法运行，只能用 VMware + Win11 运行，然后选择你想修改的存档文件，打开修改。

### Rampage

游戏内修改器，进入游戏后 F5 开启。

WARNING: 游戏版本和 Rampage 版本需要匹配，目前是 `RDR2 v1436.28` + `Rampage v1.61`(已内置在游戏根目录)

CrossOver 运行:

1. 右下角 wine configuration
2. 选择 "Library" tab
3. 添加 `dinput8.dll` + `ScriptHookRDR2.dll` -> "Editing" 中 native 代表使用游戏目录中的 dll，buildin 则使用 crossover 自带的

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

#### 大表哥最新MOD合集.7z

下载 url: https://mod.3dmgame.com/mod/189949

兼容 game version `1436.28 - 1436.31`

> 本 MOD 包含：
>
> Rampage v1.61
>
> 线上物品线下也可以买就是海军左轮那种线上才有的商品，（线上衣服会穿模，比如披风哪些）
>
> 1000件NPC所穿的衣服（捕兽人处购买），
>
> 转枪MOD，双击TAB使用
>
> 弹钢琴MOD，走到钢琴旁按E
>
> 一枪打到要害必流血MOD就是喷血那种，就是身体发红光的部位
>
> 女牛仔MOD 游戏里出现女性牛仔（已更新最新的版本，可以肉搏了）
>
> 按6可以推到NPC在按F打他（就是亚瑟去草莓镇那边收窄哪里，和唐斯那样打他） 在按E可以把他拖走（尾声约翰拖克里特哪样，但是会有颗粒感）
> 使用方法：将下载下来的文件解压后直接全部覆盖到游戏根目录，然后打开ModManager文件夹打开MOD管理器就是红色向下箭头的图标，在选择你游戏的根目录，在点一下房子下面的图片看下是否MOD有打钩，安装好后启动游戏就OK了（如无效，可以先检查下自己的根目录是否有社区脚本钩文件（ScriptHookRDRNetAPI.dll，ScriptHookRDRDotNet，ScriptHookRDRDotNet.asi，scripts（文件夹），FOR ERRORS（文件夹），EXAMPLES（文件夹）这些文件学习版MOD装了是进不去的，都要删掉，如果还是无效麻烦把游戏全部删掉，重新下载纯净版的没有任何脚本修改器的那种，在把我的MOD全部覆盖进去）
