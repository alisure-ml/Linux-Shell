---
title: Shell 环境变量
date: 2018-02-19
categories: ["shell"]
tags:
---

### 环境变量

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


#### source命令

* 可以在环境变量配置文件中添加新的环境变量，但是，新加入的行只有注销用户并再次登录后方可生效。
如果需要立即生效，需要用`source`命令执行文件。

* `source`命令也称为`点命令`，即`.`和`source`是等价的，通常用于重新执行刚刚修改的初始化文件，
使之立即生效，而不必注销重新登录。

```bash
. ~/.bash_profile
source ~/.bash_profile  # 这两个等价
```

* `source`是在当前bash环境下执行命令，执行Shell脚本是启动一个子Shell来执行命令，
所以用`source`执行脚本后，新环境变量在当前Shell和子Shell中立即生效。


#### Shell的交互与登录

* 交互shell：等待输入命令，并且立即执行，然后将结果反馈。
* 非交互shell：专门用来执行预先设定的命令，不与用户交互，读取存放在脚本文件中的命令，并执行它们。
* 登录shell：通过输入用户名/密码启动的Shell,通过带有`-l|--login`参数的bash命令启动shell。
比如，系统启动、远程登录、使用`su -`切换用户等。
* 非登录shell：登录Shell以外的情况。比如，从图形界面启动终端、使用`su`切换用户等。


### 配置文件解析

* `/etc/profile`：系统级的初始化文件，当`登录shell`时执行。
* `/etc/profile.d`：目录，用来存放个性化配置脚本，在`/etc/profile`中调用该目录下文件
* `/etc/bash.bashrc`：`/etc/profile`中调用该文件
* `/etc/bash.bash_logout`：系统级的`登录shell`清除文件，当`登录shell`退出时执行。

* `~/.bash_profile`：用户级的初始化文件，当`登录shell`时执行。
（`~/.bash_login`和`~/.profile`作为对其他shell的兼容，作用与`~/.bash_profile`相同）
* `~/.bashrc`：用户级的`交互shell`启动文件，当启动`交互shell`时执行。
* `~/.bash_logout`：用户级的`登录shell`清除文件，当`登录shell`退出时执行。如果不存在，则不执行。


#### `profile`系列文件

> `登录shell`启动时会加载`profile`系列文件。
主要目的是设置环境变量（经常出现`export`命令）和启动程序。

* `/etc/profile`
* `/etc/profile.d`
* `~/.bash_profile`
* `~/.bash_login`
* `~/.profile`

`非交互式登录shell`或`交互式登录shell`的`登录`过程：
1. 读取并执行`/etc/profile`文件
2. 读取并执行`~/.bash_profile`文件（若文件不存在，读取`~/.bash_login`文件，若也不存在，读取`~/.profile`文件）
3. `~/.bash_profile`或`~/.profile`显示调用了`~/.bashrc`。

`交互式登录shell`的`登出`过程（`非交互式登录shell`没有`登出`过程）：
1. 读取并执行`~/.bash_logout`文件
2. 读取并执行`/etc/bash.bash_logout`文件


#### `rc`系列文件

> `run command`的缩写，表示文件中存放需要执行的命令。
`交互式-非登录shell`启动时会加载`rc`系列文件。
主要目的是设置功能（执行`shopt`命令）和别名（执行`alias`命令）。

* `/etc/bash.bashrc`或`/etc/bashrc`
* `~/.bashrc`

`交互式非登录shell`：
1. 读取并执行`~/.bashrc`或`--rcfile`选项指定的文件

`非交互式非登录shell`：
1. 执行的配置文件由环境变量`BASH_ENV`指定。

> 用户由当前的Shell创建一个新的Shell,称为子Shell,
子Shell尝试读取`~/.bashrc`中的命令以设置环境变量。如果不存在，则不执行。

> `~/.bashrc`文件使得用户登录时的环境变量设置与子Shell的环境变量设置相分离。


#### 调用关系

1. `~/.bash_profile`或`~/.profile`显示调用`~/.bashrc`
2. `/etc/profile`显示调用`/etc/bash.bashrc`和`/etc/profile.d`


#### `/etc/profile.d`

> 用于：针对所有用户进行全局设置。

该目录用于存放个性化配置脚本，可以把需要的全局配置写入`.sh`文件放置在`/etc/profile.d`目录下。
系统调用`/etc/profile`时会执行该`.sh`文件。


### 建议

1. 对bash的功能进行设置或定义别名：修改`~/.bashrc`
2. 更改环境变量（用户级）：修改`~/.bash_profile` | `~/.bash_login` | `~/.profile`
3. 针对所有用户进行全局设置（比如，环境变量）：把需要的全局配置写入`.sh`文件放置在`/etc/profile.d`目录下


### Reference

* [关于“交互式-分交互式”与“登录-非登录”shell的总结](http://blog.csdn.net/sch0120/article/details/70226903)

* [关于“.bash_profile”和“.bashrc”区别的总结](http://blog.csdn.net/sch0120/article/details/70256318)

* [Linux下环境变量配置方法梳理（.bash_profile和.bashrc的区别）](http://blog.csdn.net/kevingrace/p/8072860.html)

