
### 判断

#### 简单if结构

```bash
if test
then command
    command
    ...
fi
```

```bash
if test; then  # if和then放在一行时必须有“;”。
    command
    command
    ...
fi
```

例子
```bash
read int1

if [ "$int1" -lt 10 ]
then echo "$int1"
fi
```


#### exit命令

> 退出

```bash
read str1

if [ -z "$str1" ]
then
    echo "you input is null"
    exit 1
fi
```


#### if/else结构

```bash
if test; then
    command
    ...
    command
else
    command
    ...
    command
fi
```

```bash
if [ -e "$1" ]; then
    echo "file $1 exist."
else
    echo "file $1 not exist."
    exit 1
fi
```


#### if/else语句嵌套

```bash
if test; then
    if test; then
        command
    else 
        command
    fi
else 
    if test; then
        command
    else 
        command    
    fi
fi
```

#### if/elif/else结构

```bash
if test; then
    command
elif test; then
    command 
elif test; then
    command 
else 
    command
fi
```


#### case结构

```bash
case variable in
value1)  # 必须是常量或正则表达式
   command
   ...
   command;;
value2)
   command
   ...
   command;;  # ;; break
*)  # default
   command
   ...
   command;;
esac
```

```bash
read month
case "$month" in
1)
   echo "the month 1";;
2)
   echo "the month 2";;
*)
   echo "谁说要写完了";;
esac
```


#### 运算符

* 算术运算符：+,-,*,/,%,\**

* 算术复合赋值运算符：+=,-=,*=,/=,%=

* 位运算符：<<(左移),>>(右移),&(按位与),|(按位或),~(按位非),^(按位异或)

* 自增自减运算符：++,--

* 数字常量
    1. 0作为前缀表示八进制
    2. 0x作为前缀表示十六进制
    3. 2#作为前缀表示二进制
    4. num#作为前缀表示num进制
