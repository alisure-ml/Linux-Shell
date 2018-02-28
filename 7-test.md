
### 测试

> 测试某种条件或某几种条件是否真实存在。


#### 测试结构

> 测试表达式的真假：如果为真，返回0；如果为假，返回非0整数值。

* 使用`test`命令进行测试
```bash
test expression
```

* 等价于上面的命令
```bash
[ expression ]  # 必须有空格
```


#### 整数比较运算符

> 整数比较运算符不适合浮点数比较，若想比较浮点数，则需要特定的函数

```bash
test "num1" numeric_operator "num2"
[ "num1" numeric_operator "num2" ]
```

```bash
test num1 -eq num2  # 等于，测试结果为0
test num1 -ge num2  # 大于或等于
test num1 -gt num2  # 大于
test num1 -le num2  # 小于或等于
test num1 -lt num2  # 小于
test num1 -ne num2  # 不等于
```

```bash
num1 = 15
[ "$num1" -eq 15 ]   # 测试num1是否等于15
echo $?               # 0 退出状态为0，表示num1等于15
[ "$num1" -eq 16 ]   # 测试num1是否等于15
echo $?               # 1 退出状态为1，表示num1不等于16
```


#### 字符串运算符

> 大小写敏感

```bash
test string
```

```bash
test string  # 测试字符串string是否不为空   
test -n string  # 测试字符串string是否不为空   
test -z string  # 测试字符串string是否为空   
test string1 = string2  # 测试字符串string1是否与string2相同   
test string1 !=string2  # 测试字符串string1是否与string2不相同
```


#### 文件操作符

```bash
test file_operator file
[ file_operator file ]  # File为文件名、目录名或文件路径等
```

```bash
test -d file  # 是否为目录
test -e file  # 是否存在
test -f file  # 是否是普通文件
test -s file  # 是否长度不为0
test -r file  # 是否是进程可读文件
test -w file  # 是否是进程可写文件
test -x file  # 是否是进程可执行文件
test -L file  # 是否是符号化链接
```
 
> 判断rwx权限经常和chmod结合使用。


#### 逻辑运算符

```bash
! expression  # 非
expression1 -a expression2  # 与
expression1 -o expression2  # 或

[ -e file1 -a -x file2 ]  # file1存在 与 file2可执行
```

