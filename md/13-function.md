---
title: Shell 函数
date: 2018-03-02
categories: ["shell"]
tags:
---

### 函数


#### 函数的定义和基本知识

> 函数的返回值只能为退出状态0或1。

```bash
function_name(){  # 函数名称
    command  # 函数不允许空命令，必须含有至少一条命令
    ...
    command
}

function_name  # 函数调用，在调用之前必须被定义。
```


#### 向函数传递参数

> 向函数传递的参数是以`位置参数`的方式传递的，不能传递数组等其他形式的变量。

```bash
function_name(){
    echo $1  # 第一个参数
    echo $2
    ...
    echo $n  # 第n个参数
}

function_name $a $b ... $N
```

```bash
half(){
    let "n=$1"
    let "n=n/2"
    echo "$n"
}

m=6
echo "$m"  # 6
half $m  # 3
echo "$m"  # 6
```


#### 函数返回值

> 通过return返回退出状态，0表示无错误，1表示有错误。

```bash
show_result(){
    if [ -z $1 ]
    then
        return 1  # 返回有错误
    else
        return 0  # 返回无错误
    fi
}
```


#### 函数调用

* 脚本放置多个函数

```bash
function_name_1(){
    echo "function_name_1"
}

function_name_2(){
    echo "function_name_2"
}

function_name_1
function_name_2
```

* 函数相互调用

```bash
function_name_1(){
    echo "function_name_1"
}

function_name_2(){
    echo "function_name_2"
    function_name_1
}

function_name_2
```


#### 局部变量和全局变量

* 可以通过`local`关键字在Shell函数中声明局部变量，局部变量将局限在函数范围内。

```bash
text="global variable"  # 全局变量
function_name(){
    local text="local variable"  # 局部变量
}
```

* 函数也可调用函数外的全局变量，如果一个局部变量和一个全局变量的名字相同，
则在函数中局部变量将会覆盖掉全局变量。


#### 函数递归

> 函数可以直接或间接调用其自身。

