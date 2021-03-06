---
title: Shell 编写风格
date: 2018-03-05
categories: ["shell"]
tags:
---

### 编写风格

#### 缩进

* 缩进4个字符

* 缩进最多3级


#### 空格和空行

* 赋值运算符：不能有空格

* 其他运算符：前后空出一个空格

* 判断运算符：if中的[、]左右有空格


#### 命名规范


#### 注释风格

* 变量：在之后注释

* 函数：在之前注释



### 脚本优化

* 简化脚本：创建函数或其他方法处理重复部分

* 保存脚本的灵活性：对静态值不要硬编码，尽量使用变量，并为脚本或函数提供参数

* 给用户足够的提示



### 特殊命令

* shift命令

> 用于向脚本传递参数时的每一位参数偏移，其每次将参数位置向左偏移一位。

```bash
echo "number of arguments is $#"
echo "what you input is :"

while [[ "$*" != "" ]]
do
    echo "$1"
    shift
done

# ./xxx.sh h e l
# number of arguments is 3
# what you inpur is :
# h
# e
# l
```

* getopts命令



### 交互式和非交互式Shell脚本

* 交互式Shell脚本

> Shell等待用户的输入，并且执行用户提交的命令。

* 非交互式Shell脚本获得root权限

```bash
if [ $UID -ne 0 ]  # 判断是否是root
then
    echo "you are not root" >&2  # 重定向到标准错误输出
    exit 5  # 设置退出状态为5
fi
```


#### Shell包装

> Shell包装的脚本指内嵌系统命令或工具的脚本,这种脚本保留了传递给命令的一系列参数.

> 将常用功能写成shell文件.

