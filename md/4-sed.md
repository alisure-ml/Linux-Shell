---
title: Shell sed
date: 2018-02-17
categories: ["shell"]
tags:
---

### sed

> 非交互文本编辑器，流编辑器，将一系列编辑命令作用于一批文本文件。

> sed从文本的一个文本行或标准输入中读取数据，将其复制到缓冲区，然后读取命名行或脚本的第一个命令，
对此命令要求的行号进行编辑，重复此过程，直到所有命令都执行完毕。

* 保存修改：sed只对缓冲区原始文件的副本进行编辑，如果需要保存改动的内容，需要将输出重定向到另外的文件。
```
sed 'sed 命令' input-file > result-file
```


#### 调用sed方式

* Shell命令行中输入命令
```
sed [选项] 'sed 命令' 输入文件
```

* 将sed命令写入脚本文件，然后通过sed命令调用
```
sed [选项] -f sed脚本文件 输入文件
```


* 将sed命令写入脚本文件，设置该脚本文件可执行，然后执行该文件
```
chmod +x sed脚本文件
./sed脚本文件 输入文件
```


#### sed选项

* `-n`：不打印内容
```
sed -n '1,5p' input-file  # 只输出第一行到第五行
sed '1,5p' input-file  # 输出内容的同时输出指定行
```

* `-e`：将下一个字符串解析为sed命令
```
sed [选项] -e 'sed 命令1' -e 'sed 命令2' -e 'sed 命令n' 输入文件

sed -n -e '1,5p' -e '1,5=' input-file  # 用两个命令打印内容和行号
```

* `-f`：调用sed脚本文件

```
sed文件：print.sed
1,5p
1,5=

执行：
chmod u+x print.sed
sed -n -f ./print.sed input-file
```

或者：

```
sed文件：print.sed
#!/bin/sed -f
1,5p
1,5=
  
执行：
chmod u+x print.sed
./print.sed input-file
```


#### sed命令

> sed命令通常由定位文本和编辑命令两本分组成

* 定位文本
   1. 使用行号，指定一行，或指定行号范围
   2. 使用正则表达式

* 编辑命令：标识对文本进行何种处理


#### 编辑命令

* 追加文本(行)：`a\`
```
sed '1a\append str' input-file
```

* 插入文本(行)：`i\`
```
sed '1i\insert str' input-file
```

* 修改文本(行)：`c\`
```
sed '1c\update ste' input-file
```

* 删除文本(行)：`d`
```
sed '1d' input-file
```

* 替换文本(字符)：`s`
```
s/old-string/new-string/[替换选项]

sed 's/old-string/new-string/p' input-file  # 打印替换行和所有行
sed -n 's/old-string/new-string/p' input-file  # 只打印替换行
sed -n 's/old-string/new-string/pw new-file' input-file  # 将替换行打印并输出到另外的文件中
sed -n 's/string/new-&/p'  input-file  # & 代表 old-string
```

* 写入新文件：`w`
```
sed -n '1,5w new-file' input-file  # 将前五行写入到新文件中
```

* 从文件中读入：`r`
```
sed -n '$r other-file' input-file  # 将other-file中内容读到input-file末尾
```

* 退出命令：`q`
```
sed '5 q' input-file  # 打印前五行后立即退出
```

* 变换命令(字符)：`y`
```
sed 'y/123/abc' input-file  # 将1变为a,2变为b,3变为c
```

* 显示控制字符：`l`
```
sed -n '1,$l' input-file  # 显示所有的控制字符
```

* 执行命令组：`{}`
```
sed -n '/string/{p;=}' input-file
sed -n -e '/string/p' -e '/string/=' input-file  # 两者等价
```

