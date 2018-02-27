
### 变量


#### 变量类型

* 本地变量：当前Shell进程中有效
* 环境变量：用户登录后到注销之前的所有应用中都有效
* 位置参数：Shell脚本传递的参数


#### 变量替换和赋值

> 引用变量值称为变量替换，$为变量替换符，如variable是变量名，$variable是变量的值。

* 变量赋值
```bash
variable=value
```

* 变量替换
```bash
${variable}
```

* 变量赋值中可以使用另一个变量
```bash
variable2="hello world"
variable3="saying $variable2"
echo $variable3
```

* 清除变量的值
```bash
unset 变量名
echo 变量名  # 显示空白行
```

* 测试是否被赋值
```bash
unset variable
echo ${variable:?value}
```

#### 无类型的Shell脚本变量

> Shell脚本变量是无类型的，并且Shell变量同时有数值型和字符型两种赋值，数值型初值为0,字符型初值为空，而且不用定义可以直接使用。

```bash
#!/bin/bash

a=100
let "a+=1"
echo "a=$a"  # a=101

b=xx3
echo "b=$b"  # b=xx3
declare -i b
echo "b=$b"  # b=xx3

let "b+=1"
echo "b=$b"  # b=1,数值型初值为0

echo "c=$c"  # c= ,字符型初值为空,不用定义可以直接使用
let "c+=1"
echo "c=$c"  # c=1,数值型初值为0,不用定义可以直接使用

exit 0
```


#### 环境变量

* 定义和清除环境变量
```bash
ENVIRON_VARIABLE=value  # 环境变量赋值
export ENVIRON_VARIABLE  # 声明环境变量，export表明此变量是环境变量

env  # 列出所有的环境变量

unset ENVIRON_VARIABLE  # 清除环境变量
```

* 重要的环境变量
   1. PWD:当前目录路径
   2. OLDPWD:前一个目录路径
   3. PATH:包含可执行文件的目录列表
    ```bash
    export PATH="/new/path":$PATH
    ```
   4. HOME/SHELL/USER/UID/PPID
   5.PS1/PS2:提示符变量，设置提示符格式
    ```bash
    PS1="\# \t \u@\H:\w\$ "  # 45 20:17:32 z840@HP-Workstation:~/ALISURE/Linux-Shell$
    ```

* 环境变量配置文件
   1. 








