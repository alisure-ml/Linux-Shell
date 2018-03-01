
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

