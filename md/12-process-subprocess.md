---
title: Shell 子Shell与进程处理
date: 2018-03-01
categories: ["shell"]
tags:
---

### 子Shell与进程处理


#### 子Shell

* 父Shell指在控制终端或xterm窗口给出提示符的进程
* 子Shell是由父Shell创建的进程。

* 只有一个函数可以创建子进程：fork函数。

#### 命令分类

* 内建命令(built-in command):由Shell本身执行的命令。

* 外部命令(external command):由fork创建出来的子Shell执行。

> 区别：   
内建命令不创建子shell，外部命令创建子shell。内建比外部命令执行的快。


#### 内建命令

> 包含在bash Shell工具包中的命令，是bash Shell的骨干部分（保留字也是bash Shell的骨干部分）


#### 冒号(:)

* 表示永真
```bash
while :  # ":"表示永真
do
    echo "lots of this"
done
```

* 清空文件
```bash
:> log  # 清空log文件
```

* 不做任何事，只进行参数展开


#### 圆括号结构

* 圆括号结构能够强制将其中的命令`运行在子Shell中`。
```bash
(
command1
command2
...
commandn
)
```

* 子Shell变量的作用域不能在父Shell中生效，export的环境变量也不能生效。
子Shell只能继承父Shell的一些属性，子Shell不能反过来改变父Shell的属性。
```bash
# 可以继承的属性
# 当前工作目录
# 环境变量
# 标准输入、标准输出和标准错误输出
# 所有已打开的文件标识符
# 被忽略的信号处理

# 不能继承的属性
# 除环境变量和.bahsrc文件中定义的变量之外的Shell变量
# 未被忽略的信号处理
```

* 子Shell可以接收父Shell从管道传送的数据。
```bash
cat /etc/passwd | (grep "root")  # 打印/etc/passwd文件中与root关键字所匹配的行
```

* 可以将计算量大的任务分成若干个小任务并行执行
```bash
# 圆括号后的“&”表示将此命令放在后台执行，继续执行下一命令
(grep -r "root" /etc/* | sort > part1) &  #  搜索，排序，输出
(grep -r "root" /usr/local/* | sort > part2) &
(grep -r "root" /lib/* | sort > part3) &
wait  # 等待后台执行的作业全部完成后再执行下面的命令
cat part1 part2 part3 | sort > part_total  # 合并后排序、输出
```

* 子Shell允许嵌套调用，可以在函数或圆括号结构内再次调用圆括号结构创建子Shell


#### Shell的限制模式

* RSH(Restricted Shell),限制模式，处于限制模式的Shell下运行一个脚本或脚本片段，
将会禁用一下命令或操作。

* 限制模式是基于安全方面的考虑，目的是限制脚本用户的权限，尽可能地较小脚本所带来的危害。


#### 进程处理

>当Shell命令不是内建命令时，Linux系统利用fork对一个子进程执行该命令，父进程处于等待状态；
然后，如果该命令或脚本中包含编译过的执行文件，内核将新程序装载到内存，并覆盖子进程，
执行结束后，退出子进程，父进程被重新激活，开始读取Shell提示符后的下一条命令。


>fork是Linux系统的一种系统调用，系统调用用于请求内核服务，这也是**进程访问硬件的唯一办法**
fork是创建新进程的系统调用，fork创建的子进程是父进程的副本。两个进程具有同样的环境、打开的文件、
用户标识符、当前工作目录和信号等。

* 进程号：Linux系统为每个进程分配一个数字以标识这个进程，称为进程号。
* 作业号：创建一个进程的Shell为此进程创建一个数字，也用于标识这个进程，这个数字称为作业号。

> 区别：作业号标识的是在此Shell下运行的所有进程；   
进程号是标识了整个系统下正在运行的所有进程。(Linux是多用户的系统，多用户可能开启了多个Shell)

```bash
grep -r "root" /etc/* | sort > part1 &    # 使用&符号使其在后台运行，
[1] 4693    # [1]是作业号   4693是进程号
```
> Notice: 默认情况下，当我们输入下一条命令时，Shell才提示后台运行的作业已经结束，而实际上，
该作业可能早就运行结束。若需一结束就在Shell上显示，则需要添加 b 选项。
```bash
set -b  # 开题norify选项
grep -r "root" /etc/* | sort > part1 & 
[1] 4693    # [1]是作业号   4693是进程号
[1]+ Done    grep -r "root" /etc/* | sort > part1  # 提示[1]号作业已经完成
```

#### 作业控制

后台运行和前台运行的区别

* 前台运行：能够控制当前终端或窗口,能接收用户的输入。
内建命令`fg`可将后台运行的作业放到前台。

* 后台运行：不在当前激活的终端或窗口中运行。
`&`符号使得作业在后台运行。

```bash
# sleep10.sh
sleep 10
```

```bash
./sleep10.sh &  # 放到后台执行

fg  # 将[1]号作业放到前台执行
fg %0  # 等同于fg,%n表示将第n+1个作业放到前台执行
```

* 阻塞作业：将正在运行的作业阻塞
```bash
# 1. 当作业在前台运行时，输入Ctrl+Z组合键，将作业转入阻塞状态，Shell提示作业已经停止。阻塞状态的进程时在后台的。
# 2. 输入jobs命令可以看到作业及其状态。
# 3.1 输入bg命令，可以使阻塞的作业转入后台执行。
# 3.2 输入fg命令，可以是作业重新转到前台。

# fg/bg/jobs命令只能以作业号为参数来指定作业，不能使用进程号。
```

* (disown)删除作业：从作业表中删除作业

> 作业表就是由jobs命令所列出的作业列表。

```bash
disown 指定作业  # 以指定作业的方式删除作业
disown 进程号  # 以进程号的方式指定所要删除的作业
```

* (wait)等待后台作业完成
```bash
ls /etc | grep "rc[0-9]" &  # 转入后台执行
echo "quit"  # 不等待上句执行完毕，立即输出

wait  # 等待后台作业执行完毕后结束脚本
```


#### 信号

> 信号是进程间通信机制中唯一的异步通信机制。

* Shell向进程发送信号大多通过Ctrl键加上一些功能键来实现。

| 组合键 | 信号类型 | 意义 |
| :---: | :---: | :----: |
| Ctrl+C | INT信号，即interrupt信号 | 停止当前的作业 |
| Ctrl+Z | TSTP信号，即terminal stop信号 | 使当前的作业暂时停止(转入阻塞状态) |
| Ctrl+\ | QUIT信号 | 当Ctrl+C无法停止作业时，使用此组合键 |
| Ctrl+Y | TSTP信号，即terminal stop信号 | 当进程从终端输入数据时，暂时停止该进程 |


* 内建命令`kill`可用于向进程发送`TERM`信号（terminal），功能与INT信号类似，也用于停止进程。

> kill命令可以通过进程号、作业号或进程命令名向任何作业发送信号。

```bash
kill 指定作业  # 通过作业号杀死进程
kill 进程号  # 通过进程号杀死进程

kill -l  # 查看kill命令所能发出的信号
```

* trap命令

> trap可以指定收到某种信号时所执行的命令，比如收到Ctrl+C所触发的INT信号，执行中断处理命令。

```bash
# 当收到指定的任何信号时，执行command命令，完成command命令后，继续脚本的执行，直到脚本执行结束。
trap command sig1 sig2 ... sign

trap "echo sth" INT  # 一旦收到INT信号，执行echo命令，执行之后继续脚本的执行。
trap "" TERM INT  # 忽略对TERM和INT两种信号的处理
```