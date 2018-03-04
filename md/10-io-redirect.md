---
title: Shell I/O重定向
date: 2018-02-27
categories: ["shell"]
tags:
---

### I/O重定向

> 用于捕捉一个文件、命令、程序或脚本，甚至代码块的输出，
然后把捕捉到的输出作为输入发送给另一个文件、命令、程序或脚本。

#### 管道

##### 管道简介

管道技术是Linux一种基本的`进程间通信技术`，利用`先进先出`来指挥进程间通信。

管道可应用于应用程序之间、Linux命令之间，以及应用程序和Linux命令之间的通信。

```bash
command1 | command2 | command3 | ... | commandn
# command1的输出发送给command2,作为command2的输入，后面的命令依次类推。
# 如果没有管道，command1的输出结果直接显示在Shell上。
```

##### cat和more命令

> cat和more命令用来显示文件的内容。

```bash
# 具体 option 查看帮助文档
cat [option] filename
more [option] [+linenum] filename  # [+linenum] 指定显示文件的起始行

# cat命令不提供分页功能，more在显示超过一页的文件时提供了分页的功能。
```

```bash
# 将ls的结果分页展示
ls -l | more
```


##### sed命令与管道

```bash
sed [选项] 'sed命令' 输入文件  # 原始的sed命令
| sed [选项] 'sed命令'  # sed命令与管道结合
```

```bash
# 打印ls -l结果的第1~5行
ls -l | sed -n '1,5p'
```

```bash
# 结合命令替换、管道、sed、变量赋值、echo等知识
variable1="abcdef"
replace="123"
variable2=`echo "$variable1" | sed "s/abc/$replace/g"`
echo "$variable2"  # 123def
```


#### I/O重定向

> I/O重定向：捕捉一个文件、命令、程序或脚本，甚至代码块的输出，
然后把捕捉到的输出作为输入发送给另一个文件、命令、程序或脚本。

* 文件标识符（FD）

> 用文件标识符来标识一个进程正在访问的特定文件，当打开一个文件或者创建一个文件时，
Linux将返回一个文件标识符供其他操作引用。

> 当启动一个进程时，将自动为该进程打开三个文件：标准输入、标准输出和标准错误输出，分别用0,1,2标识。

* tee命令

> T型数据流，讲一个输出分为两个支流，一个到标准输出，一个到某个输出文件。

```bash
# 将who的结果保存到output文件
who | tee output

# 将who的结果追加到output文件
who | tee -a output
```

* I/O重定向符号

```bash
cat > newfile  # 将键盘的输入重定向到newfile
# 在此输入内容
# 按CTRL+D结束输入

cat >> newfile  # 将键盘的输入追加到newfile
# 在此输入内容
# 按CTRL+D结束输入

cat newfile
# 显示刚才编辑的内容
```

```bash
n> filename  # 将文件标识符为n的内容输出到filename中

# 将指定文件标识符的内容重定向到另一文件中
ls z-file  # 假设：当前目录下没有z-file

ls z-file 2> newfile  # 将错误信息输入到newfile中
```

```bash
< filename  #  将文件的内容读入（重定向）标准输入中
n< filename  # 将文件的内容读入（重定向）文件标识符为n的文件中

wc -l < filename  # 统计文件的行数
```

* exec命令的用法

> 可以通过`文件标识符`打开或关闭文件，
也可以将`文件`重定向到`标准输入`或将`标准输出`重定向到`文件`

```bash
exec 8<&0  # 将FD 0(标准输入)复制到FD 8

exec < hfile  # 将hfile重定向到标准输入
read a  # 读取hfile的第一行
echo "$a"

exec 0<&8 8<&-  # 将FD 8复制到FD 0(标准输入)，关闭FD 8的输入（恢复标准输入）
```

```bash
exec 8>&1  # 将FD 1(标准输出)复制到FD 8

exec > log  # 将标准输出重定向log文件
echo "asd"  # 此时会将asd写入到log文件中

exec 1>&8 8>&-  # 将FD 8复制到FD 1(标准输出)，关闭FD 8的输出（恢复标准输出）
```

* tty

> 待研究

```bash
sudo echo "asd" > /dev/tty1  # 重定向到tty1，在tty1会接收到asd
```

* 代码块重定向

> 指在`代码块`内将`标准输入`或`标准输出`重定向到`文件`，而在`代码块`之外保留默认状态。
可以重定向的代码块是while,until,for等循环结构，也可以是if/then测试结构，甚至可以是函数。

**循环**

```bash
# `标准输入`重定向到`文件`
done > filename

# `标准输出`重定向到`文件`
done < filename
```

```bash
ls /etc > log  # 将结果重定向到log中

while [ "$filename" != "rc.d" ]; do
    read filename
    let "count+=1"
done < log  # 将标准输入重定向到log文件

echo "$count"
```

**if/then**

```bash
if [condition]
then
    ...
else
    ...
fi < filename
```

```bash
if [ -z "$1" ]
then
    echo "is null"  # 输出到log文件中
fi > log
```


#### 命令行处理

具体参考：
* [shell 命令行处理流程](http://blog.51cto.com/evillinux/1192072)
* [shell解析命令行的过程以及eval命令](https://www.cnblogs.com/f-ck-need-u/p/7426371.html)

> shell对每一个命令都要经过`命令行处理流程`进行处理。如，变量替换、通配符展开等。


#### eval命令

* [shell解析命令行的过程以及eval命令](https://www.cnblogs.com/f-ck-need-u/p/7426371.html)

> eval命令将其参数作为命令行，让shell重新执行该命令。

* 由于`命令行处`理需要`步骤`，所以当在后面`替换`的时候出现了前面`已经处理过`的情况，
当`执行命令`时会发生错误，所以用`eval`表明处理后的命令还需要`重新处理一遍`再执行。

* 如果命令中包含`变量替换`，且变量中包含任何需要shell在命令中`直接看到的字符`，
就需要使用eval命令，如命令结束符（;,|,&）、I/O重定向符（<,>）和引号等。

```bash
pipe="|"
ls $pipe wc -l  # 会报错（因为“管道符”需要在第一步被发现）
eval ls $pipe wc -l  # 正常执行
```
