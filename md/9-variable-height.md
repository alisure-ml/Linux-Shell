---
title: Shell 内部变量
date: 2018-02-26
categories: ["shell"]
tags:
---

### 内部变量

* BASH:bash Shell的路径

* BASH_SUBSHELL:shell的层次

* BASH_VERSINFO:shell的版本信息

* BASH_VERSION:bash Shell的版本

* DIRSTACK:显示目录栈的栈顶值
```bash
# 目录栈用于存放工作目录，便于程序员手动控制目录的切换，pushed和popd用来维护目录栈。
# pushed命令：用于将某目录压入目录栈，同时将当前工作目录切换到入栈的目录。
# popd命令：用于将栈顶目录弹出，下一个元素变为栈顶元素，同时将当前工作目录切换到栈弹出的目录。

pushed 目录名  # 将目录名压入目录栈，同时当前工作目录切换到目录，并输出栈的内容
popd  # 将栈顶目录弹出，同时当前目录切换到栈弹出的目录，并输出栈的内容
dirs  # 用于显示目录栈的所有内容
```

```bash
pushd /home  # /home
pushd nihao  # /home /home/nihao
pushd /usr   # /home /home/nihao /usr
pushd wohao  # /home /home/nihao /usr /usr/wohao
```

* GLOBIGNORE:由冒号分隔的模式列表，表示通配时忽略的文件名集合
```bash
# 一旦GLOBIGNORE非空，Shell会将通配得到的结果中符合GLOBIGNORE模式中的目录去掉。
```

* GROUPS:当前用户所属的组群

* HOSTNAME:记录了主机名

* HOSTTYPE和MACHTYPE:记录系统的硬件架构

* OSTYPE:记录操作系统类型

* ERPLY:与read和select命令有关
```bash
# read 将读到的标准输入存储到variable变量中。
read variable  # 读取标准输入的变量值
# 当read命令不带任何变量名时，read就将读到的标准输入存储到REPLY变量中。
read
echo "$REPLY"  # 存储未指定变量的用户输入

read name
echo "$name"
echo "$REPLY"

# input_reply
# input_name
# input_reply
```

```bash
select var in "a" "b" "c"
do
    echo "$REPLY"  # 存储用户的输入
    echo "$var"
    break
done
# #? 1
# 1
# a
```

* SECONDS:记录脚本从开始执行到结束所耗费的时间

* SHELLOPTS:记录了处于“开”状态的Shell选项列表，是只读变量
```bash
set -o optionname  # 打开名为optionname选项
set +o optionname  # 关闭名为optionname选项
```

* SHLVL:记录bash Shell嵌套的层次
```bash
# 启动第一个shell，$SHLVL=1
# 如果在这个shell中执行脚本，则脚本的SHLVL为$SHLVL=2
# 依次类推
```

* TMOUT:设置Shell的过期时间，当TMOUT不为0时，Shell在TMOUT秒后自动注销
```bash
TMOUT=3
read name  # 如果用户在3秒内不输入信息，脚本将退出
echo "$name"
```


### 字符串处理

> bash Shell提供了多种字符串处理的命令，如awk,expr。

* expr length:计算字符串长度
```bash
${#string}
expr length "$string"
```

```bash
string="a b c"
echo ${#string}
expr length "$string"
# 5
# 5
```

* expr index:**字符**第一次出现的位置(索引)
```bash
# 在$string上匹配$substring中字符第一次出现的位置，若匹配不到任何字符，expr index返回0
expr index $string $substring
```

```bash
string="nihao a"
expr index "$string" hao  # 3
expr index "$string" oah  # 3，oah中字符在string中第一次出现的位置
```

* expr match:从开头开始匹配的字符个数
```bash
# 从开头开始匹配，返回匹配的长度
expr match $string $substring  # substring可以是字符串，也可以是正则表达式
```

```bash
string="abc cba"
expr match "$string" a.*  # 7
expr match "$string" ab  # 2
expr match "$string" bc  # 0
```

* expr substr:抽取子串
```bash
# ${...}命令:
${string:position}  # 从0开始计数
${string:position:length}

# expr substr命令
expr substr $string $position $length  # $length必不可少，从1开始计数
```

```bash
string="abc def"
echo ${string:0}  # abc def
echo ${string:2}  # c def
echo ${string:2:3}  # c d
echo ${string: -2}  # ef,从右开始计数
echo ${string:(-2)}  # ef,从右开始计数，等价于上式

expr substr "$string" 1 3  # abc
```

* 删除子串
```bash
# 从头删除子串
${string#substring}  # 删除匹配的最短子串
${string##substring}  # 删除匹配的最长子串

# 从结尾处删除子串
${string%substring}  # 删除匹配的最短子串
${string%%substring}  # 删除匹配的最长子串
```

```bash
string="1234234"
echo ${string#1*2}  # 34234
echo ${string##1*2}  # 34
echo ${string%2*4}  # 1234
echo ${string%%2*4}  # 1
```

* 替换子串
```bash
${string/substring/replacement}  # 仅替换第一次匹配的子串
${string//substring/replacement}  # 替换所有匹配的子串

${string/#substring/replacement}  # 仅在开头处替换
${string/%substring/replacement}  # 仅在结尾处替换
```


#### 有类型变量

> shell变量一般是无类型的，但是shell提供了declare和typeset两个命令用于指定变量的类型，这两个命令等价。

```bash
declare [选项] 变量名
```

* -r:设置为只读
```bash
declare -r variable
readonly variable
```

* -i:将变量定义为整型（允许使用该变量进行算术运算）
```bash
variable1=12
variable2="$variable1"+1
echo "$variable2"  # 12+1

let variable3=$variable1+1
echo "$variable3"  # 13

declare -i variable4  # 将variable4定义为整型变量
variable4="$variable1"+1
echo "$variable4"  # 13

variable5=$((variable1+1))  # 双圆括号法(())执行运算
echo "$variable5"  # 13
```

* -a:将变量声明为数组类型

* -f:显示脚本之前定义过的所有函数名及其内容
```bash
declare -f  # 显示脚本之前定义过的所有函数名及其内容
declare -f function-name  # 只显示function-name及其内容
```

* -F:只显示函数名，不显示内容

* -x:将变量声明为环境变量
```bash
# 相当于export命令
# declare -x 允许在声明变量为环境变量的同时给变量赋值，而export不支持此功能。
declare -x variable-name=value
```


#### 间接变量引用

> 间接变量引用：一个变量引用另一个变量的值

```bash
variable1=value
variable2=variable1

eval tmp_var=\$$variable2  # value
tmp_var=${!variable2}  # value
```


#### bash数学运算

* expr命令
```bash
expr ARG1 op ARG2

expr 3 | 2  # 3
expr 0 | 2  # 2，ARG1不为空且非零时，返回ARG1，否则返回ARG2
expr 3 & 2  # 3，ARG1不为空且非零时，返回ARG1，否则返回0
expr 0 & 2  # 0，ARG1不为空且非零时，返回ARG1，否则返回0

expr 1 > 2  # 0，假
expr 1 < 2  # 1，真
expr 1 >= 2  # 0
expr 1 <= 2  # 1
expr 1 = 2  # 0
expr 1 != 2  # 1

expr 1 + 2  # 3，运算符前后需要有空格
expr 2 - 1  # 1
expr 1 \* 2  # 2，*为元字符，需要转义
expr 2 / 1  # 2
expr 2 % 1  # 0
```

* bc运算器

> 是一种内建的运算器。

```bash
bc  # 直接输入bc，启动ba运算器
bc -q  # 不输出版本信息
scale=4  # 设置精度为4
```

```bash
# 在shell脚本中使用：命令替换和bc结合
variable=`echo "options; expression" | bc`

var1=20
var2=3.14159
var3=`echo "scale=2; $var1 ^ 2" | bc`
var4=`echo "scale=2; $var3 * $var2" | bc`  # 1256.64
```
