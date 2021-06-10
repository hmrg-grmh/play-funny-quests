# 鸡兔同笼的通用解法

## 为什么会想到这回事儿？

看 Porlog 的[这个教程](https://zhuanlan.zhihu.com/p/41908829)，里面介绍了逻辑式语言可以帮你推导出未知数：

> 文件名：chicken-and-rabbits.prolog
> 
> ```prolog
> % 首先，我们引入一个 clpq 的库来帮助我们进行运算符描述
> :- use_module(library(clpq)).
> 
> % 然后，我们定义事实：脑袋的总数量(H) 应当等于 鸡的总数量(C) 加上 兔子的总数量(R)
head(C,R,H) :- {H = C + R}.
> 
> % 然后，我们定义事实：脚的总数量(F) 应当等于 鸡的总数量(C)乘以二 加上 兔子的总数量(R)乘以四
foot(C,R,F) :- {F = C*2 + R*4}.
> 
> ```
> 
> 我们定义好了事实，那么接下来让我们去询问 Prolog 答案：
> 
> > 载入既定事实
> 
> ```bash
> swipl chicken-and-rabbits.prolog
> ```
> 
> > 执行询问语句
> 
> ```prolog
> ?- head(C,R,35),foot(C,R,94).
> C = 23,
> R = 12.
> 
> ```
> 
> 答：鸡有 23 只！兔有 12 只！
> 
> 哈哈哈哈，没错！再也不需要去绞尽脑汁思考怎么告诉计算机去计算啦！只需要告诉 Prolog 既定事实，剩下的，就是提出正确的问题啦！
> 

我在想什么呢？我在想如果我指定算法要怎么写。

## 穷举法

这里不会给出穷举法示例，因为我猜这个到处都是，思路就是，确保兔加一个鸡就是头减去兔，但后遍历到脚合乎题目条件就退出。

## 公式

有没有可能，保留一些参数，然后推一推公式，用公式去算呢？

我试了试，挺简单的，解方程嘛，注意不要把数给算了，最好命名为一些参数名。

### 抽象

但这个过程中，我有了个想法：

> 人类在外星球发现了一种生物：
> 
> - 每个个体都有 `头` 和 `脚` 的结构，用 `头` 进食用 `脚` 走路。
> - 每个 `头` 都有着完全一样的外观，每只 `脚` 也是。
> - 每个个体拥有 `头` 的个数和 `脚` 的个数具有一定的随机性，目前暂时还没总结出可靠的规律。
> 
> 它们会进行*有性繁殖*，有**两种不同性别**参与**即可完成**。
> 但在这里，似乎只要 `头` 的个数或 `脚` 的个数存在**不一致**，就会在*繁殖活动*中表现为**两种不同的*性别***。
> 
> *繁殖*的具体表现有：
> 
> - *性别*不同的个体会把身体贴合并形成一个公用的 `壳` ，只有 `头` 和 `脚` 会暴露在外；
> - 头和脚可按需要收进 `壳` 内，但**每个 `头` 和 `脚` 一定都会有可见的对应 `孔洞` 、且一个 `头` 或 `脚` 总会只用自己的那个**；
> - 在 `壳` 上，可以法轻松分辨一个 `孔洞` 是 `头` 的还是 `脚` 的；
> - *繁殖*是有周期的，繁殖的结果就是壳内个体增加并随之发生孔洞增加，并且，被繁殖出的个体在*破壳*之前**头脚数目必然与形成 `壳` 的两个个体的其中一个相同**；
> - 这个 `壳` 会在一段时间后破掉，之后其中的每个个体的 `头` 和 `脚` 的数目都会**程序性地**发生**随机的**变化，并就地再次两两结合或者钻地洞躲藏起来；
> - 由于这样的活动习性，在得到足够的认识前，这种生物群曾被人类误认为是一个带 `壳` 的独立个体，并把这种生物命名为 `外型乌龟` ；直到观察到它们繁衍过程中的*破壳*阶段，但这个命名已经沿用至今。
> 

总之：

> 现在，人类已经实现了这种生物的实验室养殖。
> 
> 但在养殖中，需要研究 `壳` 内个体数跟环境和时间的关系。
> 
> 可以知道的参数有：
> 
> - 一个 `壳` 在形成的时候，参与形成的俩个体**分别**的 `头` 和 `脚` 的数目；
> - 这个 `壳` 在当前，总共的 `头` 和 `脚` 的数目；
> 
> 想要求得的是：
> 
> - 在当前 `壳` 内的已有个体数。
> 
> (已经确定在当前的一定时间内壳内个体数不会有变化)
> 

另外：

> > **不能手动破坏壳，否则你只会得到孩子们的尸体。这将会使你受到一定的惩罚。**
> > 
> > **已知，这种生物的排泄物可以制成高轻度强度且高耐腐蚀性的多用途材料。但必须尽快保存，否则会迅速同周围气体反应而失效。因此大量养殖有重大意义。**
> > 
> 
> ---- 地球星际统一战略部 宣
> 



### 解题

那么，先不急着写代码，现在来解一下题。

首先搞一下*输入参数的命名*。代词是*描述事物*的开端。

这里的命名是我乱来的，**仅供参考**：

- 当前 `壳` 的 `头` 总数目: `all_a`
- 当前 `壳` 的 `脚` 总数目: `all_z`

- 当初参与形成 `壳` 的第一种个体的 `头` 数目: `webi_a`
- 当初参与形成 `壳` 的第一种个体的 `脚` 数目: `webi_z`

- 当初参与形成 `壳` 的第二种个体的 `头` 数目: `babo_a`
- 当初参与形成 `壳` 的第二种个体的 `脚` 数目: `babo_z`

代词是*描述事物*的开端。所以*要输出的值的命名*也最好做一下。

命名依然是乱来的，仅供参考：

- 第一种个体的总 `身体` 数: `webi_hoo`
- 第二种个体的总 `身体` 数: `babo_hoo`

那么，接下来，

**根据题目**即可知有以下关系：

```elixir
webi_a * webi_hoo + babo_a * babo_hoo = all_a
webi_z * webi_hoo + babo_z * babo_hoo = all_z
```

可以有两个化简的方向：

- 先求 `webi_hoo` 再求 `babo_hoo`
- 先求 `babo_hoo` 再求 `webi_hoo`

这里都列出来，大家可以都找找规律。

> *下面每个代码块里都会有一个 'or' 路线 ---- 这会出现一种奇妙的对比！*
> 
> *之所以特地强调一下就是说那些个 `## or:` 的上下的两条计算路线里头**只需要挑上或者下其中一个**来看就行了！*
> 
> *下面的 `#` 是注释！从它往后直到行末可看也可忽略！自己按需！*
> 



#### 先求 `webi_hoo` 再求 `babo_hoo`

即把式子转为 `webi_hoo = xxx` 的形式

已知有

```elixir
webi_a * webi_hoo + babo_a * babo_hoo = all_a # 头的关系
webi_z * webi_hoo + babo_z * babo_hoo = all_z # 脚的关系
```

这需要先转一个式子为 `babo_hoo = xxxx webi_hoo xxxx` 的形式

```elixir
babo_hoo = all_a / babo_a - webi_hoo * webi_a / babo_a # 上路线
## or: 
babo_hoo = all_z / babo_z - webi_hoo * webi_z / babo_z # 下路线
```

代入另一个式子就会有

```elixir
webi_z * webi_hoo + babo_z * all_a / babo_a - babo_z * webi_hoo * webi_a / babo_a = all_z # 上路线
## or:
webi_a * webi_hoo + babo_a * all_z / babo_z - babo_a * webi_hoo * webi_z / babo_z = all_a # 下路线
```

合并移项（注意这里最终需要 `webi_hoo = xxx` 形式的式子）

```elixir
(webi_z - babo_z * webi_a / babo_a) * webi_hoo = all_z - babo_z * all_a / babo_a # 上路线
## or:
(webi_a - babo_a * webi_z / babo_z) * webi_hoo = all_a - babo_a * all_z / babo_z # 下路线
```

除一下就能得到想要的了

```elixir
webi_hoo = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a) # 上路线
## or:
webi_hoo = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z) # 下路线
```

完整公式就是：

```elixir
## 上路线:
webi_hoo_up = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a)
babo_hoo_up_then = all_a / babo_a - webi_hoo * webi_a / babo_a
## 下路线:
webi_hoo_dn = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z)
babo_hoo_dn_then = all_z / babo_z - webi_hoo * webi_z / babo_z
```



#### 先求 `babo_hoo` 再求 `webi_hoo`

即把式子转为 `babo_hoo = xxx` 的形式

已知有

```elixir
webi_a * webi_hoo + babo_a * babo_hoo = all_a # 头的关系
webi_z * webi_hoo + babo_z * babo_hoo = all_z # 脚的关系
```

这需要先转一个式子为 `webi_hoo = xxxx babo_hoo xxxx` 的形式

```elixir
webi_hoo = all_a / webi_a - babo_hoo * babo_a / webi_a # 上路线
## or:
webi_hoo = all_z / webi_z - babo_hoo * babo_z / webi_z # 下路线
```

代入另一个式子就会有

```elixir
webi_z * all_a / webi_a - webi_z * babo_hoo * babo_a / webi_a + babo_z * babo_hoo = all_z # 上路线
## or:
webi_a * all_z / webi_z - webi_a * babo_hoo * babo_z / webi_z + babo_a * babo_hoo = all_a # 下路线
```

合并移项（注意这里最终需要 `babo_hoo = xxx` 形式的式子）

```elixir
(babo_z - webi_z * babo_a / webi_a) * babo_hoo = all_z - webi_z * all_a / webi_a # 上路线
## or:
(babo_a - webi_a * babo_z / webi_z) * babo_hoo = all_a - webi_a * all_z / webi_z # 下路线
```

除一下就能得到想要的了

```elixir
babo_hoo = (all_z - webi_z * all_a / webi_a) / (babo_z - webi_z * babo_a / webi_a) # 上路线
## or:
babo_hoo = (all_a - webi_a * all_z / webi_z) / (babo_a - webi_a * babo_z / webi_z) # 下路线
```



### 变成代码

我会用多种语言的语法来写。感兴趣也可以对比一下不同的语法的相同的地方。


#### 四个解法

上面得到了这么四套解法：

```elixir
## 先求 webi 再求 babo , 用头的式子代入脚的式子
webi_hoo_az = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a)
then_babo_hoo_az = all_a / babo_a - webi_hoo_az * webi_a / babo_a

## 先求 webi 再求 babo , 用脚的式子代入头的式子
webi_hoo_za = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z)
then_babo_hoo_za = all_z / babo_z - webi_hoo_za * webi_z / babo_z

## 先求 babo 再求 webi , 用头的式子代入脚的式子
babo_hoo_az = (all_z - webi_z * all_a / webi_a) / (babo_z - webi_z * babo_a / webi_a)
then_webi_hoo_az = all_a / webi_a - babo_hoo_az * babo_a / webi_a

## 先求 babo 再求 webi , 用脚的式子代入头的式子
babo_hoo_za = (all_a - webi_a * all_z / webi_z) / (babo_a - webi_a * babo_z / webi_z)
then_webi_hoo_za = all_z / webi_z - babo_hoo_za * babo_z / webi_z

```


#### erlang

因为这个语言语法可以轻易地直观表示丰富的含义。所以先用它搞一个。

把所有四套都试一下，看看是不是一样的结果。

```erlang
- module (playfuns) .
- export ([wbbazza/3]) .

wbbazza 
    ( {AllA, AllZ}
    , {WebiA, WebiZ}
    , {BaboA, BaboZ} )
-> 
    WebiHooAz = (AllZ - BaboZ * AllA / BaboA) / (WebiZ - BaboZ * WebiA / BaboA) , 
    ThenBaboHooAz = AllA / BaboA - WebiHooAz * WebiA / BaboA , 
    
    WebiHooZa = (AllA - BaboA * AllZ / BaboZ) / (WebiA - BaboA * WebiZ / BaboZ) , 
    ThenBaboHooZa = AllZ / BaboZ - WebiHooZa * WebiZ / BaboZ , 
    
    BaboHooAz = (AllZ - WebiZ * AllA / WebiA) / (BaboZ - WebiZ * BaboA / WebiA) , 
    ThenWebiHooAz = AllA / WebiA - BaboHooAz * BaboA / WebiA , 
    
    BaboHooZa = (AllA - WebiA * AllZ / WebiZ) / (BaboA - WebiA * BaboZ / WebiZ) , 
    ThenWebiHooZa = AllZ / WebiZ - BaboHooZa * BaboZ / WebiZ , 
    
    [ {webi_then_babo_az, {WebiHooAz, ThenBaboHooAz} }
    , {webi_then_babo_za, {WebiHooZa, ThenBaboHooZa} }
    , {babo_then_webi_az, {ThenWebiHooAz, BaboHooAz} }
    , {babo_then_webi_za, {ThenWebiHooZa, BaboHooZa} } ] .

%%%%%%%%%%%%%%%%

%% 现在假设有: 
%% - 3头 6足 算作webi 一共 21只
%% - 7头 1足 算作babo 一共 78只
%% 那么: 
%% - 头一共: 3 * 21 + 7 * 78 = 609
%% - 足一共: 6 * 21 + 1 * 78 = 204
%% 
%% 那么, 测试 playfuns:wbbazza/3 : 
%% c(playfuns). playfuns:wbbazza({609, 204}, {3,6}, {7,1}). 
%% 
%% 就应该得到结果: 
%% [{webi_then_babo_az,{21.0,78.0}},
%%  {webi_then_babo_za,{21.0,78.0}},
%%  {babo_then_webi_az,{21.0,78.0}},
%%  {babo_then_webi_za,{21.0,78.0}}]
%% 
%% 试了一下是这结果
%% ----: 1次随机测试成功!!

%%%%%%%%%%%%%%%%

```


#### elixir

上面的那些公式其实就是在 elixir 的代码块里。



#### python

最先写好的是 python (不过最先写好的代码是固定 `头` 为一个的) 。

并不是因为我会 python 或者什么 python 简单。只是因为 python 的 REPL 好用并且服机子上就有不用装罢了。。。

```python

```








# 分享请遵循

分享请注明作者或来源： `xxx`

可以商用或演绎，特别是上面那个 `外星乌龟` 的 IP ，总觉得似乎挺有意思的，但貌似一般也就是做一做是故事里的过场素材这个样子。。。。
