---
title: Shell 循环与结构化命令
date: 2018-02-24
categories: ["shell"]
tags:
---

### 循环与结构化命令

#### for循环

* 列表for循环
```bash
for variable in {list}
do
    command
    ...
    command
done
```

```bash
for variable in 1 2 3  # 1,2,3
do
    echo "$variable"
done
# 1
# 2
# 3
```

```bash
for variable in {1..3}  # 1,2,3
do
    echo "$variable"
done
# 1
# 2
# 3
```

```bash
sum=0
for i in {1..10..2}  # 1到10，步长为2
do
    let "sum+=i"
done
echo "sum=$sum"
# 25
```

```bash
sum=0
for i in $(seq 1 2 10)  # seq是一个命令，1到10，步长为2
do
    let "sum+=i"
done
echo "sum=$sum"
# 25
```

```bash
for file in $(ls)  # 当前目录的所有文件
do
    echo "file:$file"
done
```

```bash
for file in $(*)  # 通配符*可以匹配当前目录下的所有文件
do
    echo "file:$file"
done
```


* 不带列表for循环：Shell会自动将`命令行键入的所有参数`依次组织成`列表`
```bash
for variable
do 
    command
    ...
    command
done
```
等价于
```bash
for variable in "$@"
do 
    command
    ...
    command
done
```

```bash
for argument
do 
    echo "$argument"
done
```


* 类C风格的for循环
```bash
for((expr1; expr2; expr3))  # 可以使用逗号表达式
do 
    command
    ...
    command
done
```

```bash
for((integer=1; integer<=3; integer++))
do
    echo "$integer"
done
# 1
# 2
# 3
```


#### while循环

```bash
while expression
do 
    command
    ...
    command
done
```

```bash
int=1
# while(("$int" <= 3))
while [[ "$int" <= 3 ]]  # 这两种都可以
do
    echo "$int"
    let "int++"
done
# 1
# 2
# 3
```

```bash
while [[ "$*" != "" ]]; do
    echo "$1"
    shift  # 使位置变量下移一位，并使$#变量递减。
done
```


#### until循环

```bash
until expression
do
    command
    ...
    command
done
```

```bash
i=1
until [[ "$i" -gt 3 ]]
do
    echo "$i"
    let "i++"
done
# 1
# 2
# 3
```


#### 嵌套循环

```bash
# 打印出九九乘法表
for((i=1; i <= 9; i++))
do
    j=1
    until [[ "$j" -gt "$i" ]]
    do
        let "n=i*j"
        echo -n "$i*$j=$n  "
        let "j++"
    done
    echo ""
done
```


#### 循环控制符

* break循环控制符
```bash
break
```

* continue循环控制符
```bash
continue
```


#### select结构

```bash
select variable in {list}
do
    command
    ...
    command
    break
done
```

```bash
select num in $(seq 1 4)  # 带列表的select
do
    break
done
echo "the num is $num"
# 1) 1
# 2) 2
# 3) 3
# 4) 4
# #? 4
# the num is 4
```

```bash
selece num  # 不带列表的select
do
    break
done
echo "the num is $num"
# ./xxx.sh 1 2 3 4

# 1) 1
# 2) 2
# 3) 3
# 4) 4
# #? 4
# the num is 4
```
