
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
   5. PS1/PS2:提示符变量，设置提示符格式
    ```bash
    PS1="\# \t \u@\H:\w\$ "  # 45 20:17:32 z840@HP-Workstation:~/ALISURE/Linux-Shell$
    ```

##### 环境变量配置文件

* `.bash_profile`

当用户登陆时，Shell会自动执行`.bash_profile`文件。   
可以在后面添加新的环境变量，但是，新加入的行只有注销用户并再次登录后方可生效。   
如果需要立即生效，需要用`source`命令执行文件。

```bash
. .bash_profile
source .bash_profile  # 这两个等价
```

> `source`命令也称为`点命令`，即`.`和`source`是等价的，通常用于重新执行刚刚修改的初始化文件，
使之立即生效，而不必注销重新登录。

> `source`是在当前bash环境下执行命令，执行Shell脚本是启动一个子Shell来执行命令，
所以用`source`执行脚本后，新环境变量在当前Shell和子Shell中立即生效。

> 当用户登陆时，首先查找是否存在`.bash_profile`文件，若不存在则查找是否存在`.bash_login`文件，
若也不存在则查找是否存在`.profile`。

* `.bashrc`

> 如果用户由当前的Shell创建一个新的Shell,称为子Shell,
子Shell尝试读取`.bashrc`中的命令以设置环境变量。
如果不存在，则不执行。

> `.bashrc`文件使得用户登录时的环境变量设置与子Shell的环境变量设置相分离。

* `.bash_logout`

> 在用户注销时执行，用户可以在该文件中写入清除某些环境变量或记录注销时间等命令。
如果不存在，则不执行。


