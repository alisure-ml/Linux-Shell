---
title: Shell 简介
date: 2018-02-14
categories: ["shell"]
tags:
---

## Shell简介

Shell提供了`用户`与`内核`交互的`接口`，接收用户输入的指令，并把它送入到内核去执行。


### Shell打开方式

* 通过终端打开Shell
```
CTRL + ALT + T
```
* Shell登录系统
```
CTRL + ALT + F1 ~ F6 / F7
```
* 或者远程登录
```
Putty
```


### Shell版本

* 查看种类
```
cat /etc/shells
```

* 查看版本
```
bash -version
```


### Shell的基本元素
> Shell脚本将一系列的Linux命令放在一个文件中。

* `#!/bin/bash`:指定解释器
```
#!/bin/bash
#!/bin/sh
```

* 命令组成
```
命令名称 -选项 参数
```

* 查看帮助
```
man 命令名称
```

* 同一行多条命令（分号分隔命令）
```
date;who
```


### 执行Shell脚本

1. 赋权
```
chmod +x file_name.sh
```

2. 执行
```
./file_name.sh
```
