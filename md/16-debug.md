---
title: Shell 脚本调试技术
date: 2018-03-06
categories: ["shell"]
tags:
---

### Shell脚本调试技术

#### 使用trap命令

> trap 命令通过捕捉三种“伪信号(由Shell产生)”能够方便地跟踪`异常`的函数和命令、
正常函数和脚本的`结束`、随时`监控`变量的变化。

| 信号名称 | 产生条件 |
| --- | --- |
| EXIT | 从函数中退出，或整个脚本执行完毕 |
| ERR | 当一条命令返回非零状态码，即命令执行不成功 |
| DEBUG | 脚本中的每一条命令执行之前 |

```bash
# 脚本中的每一条命令执行之前,都会执行echo信息
trap 'echo "before execute line:$LINENO, a=$a"' DEBUG  # trap捕捉伪DEBUG
a=0
while :
do
    let "a=a+2"
done
```

```bash
trap 'echo "Line:$LINENO"' EXIT  # 捕获伪EXIT信号
trap 'echo "Line:$LINENO"' ERR  # 捕获伪ERR信号
```


#### 使用tee命令

> tee命令适用于管道的测试，通过观察tee命令产生的中间结果文件，可以清晰地看出管道间的数据流向。

```bash
local_ip=`cat /etc/network/interfaces | grep 'IPADDR' | cut -d= -f2`

# 将通过管道的数据分为两个分支，一个到文件，一个到标准输出。因此，可以通过分析debug.txt分析通过管道的数据
local_ip_tee=`cat /etc/network/interfaces | tee debug.txt | grep 'IPADDR' | tee -a debug.txt | cut -d= -f2 | tee -a debug.txt`
```


#### 调试钩子

> 一个if/then结构的代码块，DEBUG变量控制该代码是否执行。
在程序开发调试阶段，将DEBUG变量设为TRUE，使其输出调试信息。
在开发阶段，将DEBUG设置为FALSE，关闭调试钩子，而无需一一删除。

```bash
# 通常包装成函数，方便调用
if [ "$DEBUG" = "true" ]
then
    echo "info"
fi
```

```bash
DEBUG(){  # 定义
    if [ "$DEBUG" = "true" ]
    then
        $@
    fi
}

DEBUG echo "info"  # 使用
```


#### 使用Shell选项

| 选项名称 | 简写 | 意义 |
| --- | --- | --- |
| noexec | n | 读取命令，检查语法，不执行命令 |
| xtrace | x | 执行命令之前，将每个命令打印到标准输出 |
| 无 | c ... | 从...中读取命令 |

* -n：读取命令，检查语法，但不执行命令

> 若存在语法错误，会输出错误信息

```bash
# 在脚本开始处设置
set -n  # 或 set -o noexec
```

```bash
# 执行脚本时设置
sh -n 脚本名称
```

* -x：执行命令之前，将要执行的每个命令打印到标准输出

> 在行首显示“+”号，后面显示经过变量替换之后的命令行内容。

> -x选项经常和trap捕捉DEBUG信号结合使用：既可以输出实际执行的命令，又可以逐行跟踪相关的变量。

```bash
# 在脚本开始处设置
set -x  # 或 set -o xtrace
```

```bash
# 执行脚本时设置
sh -x 脚本名称
```

**定制-x选项提示符**：可以对行首的显示设置
```bash
# 设置PS4，定制-x选项提示符
# LINENO：行号
# FUNCNAME：数组变量，表示整个调用链上所有的函数名
export PS4='+{$LINENO:${FUNCNAME[0]}:${FUNCNAME[1}}'
```

* -c：从字符串读取并执行命令

> 当需要临时调试一小段脚本时可以考虑使用。

```bash
# sh -c:将后面的字符串作为命令来执行。
sh -c 'a=2;b=3;let c=$a*$b;echo "c=$c"'
```
