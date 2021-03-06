---
title: Shell 终端颜色
date: 2018-02-25
categories: ["shell"]
tags:
---

### 终端颜色


* [shell 终端字符颜色](http://blog.csdn.net/zj0910/article/details/47824139)



#### 带颜色的脚本

> 终端的字符颜色是用转义序列控制的，是文本模式下的系统显示功能，
和具体的语言无关，shell,python,perl等均可以调用。
转义序列是以 ESC 开头,可以用 \033 完成相同的工作
（ESC 的 ASCII 码用十进制表示就是 27， = 用八进制表示的 33）。

* 语法
```bash
\033[显示方式;前景色;背景色m
```


* 默认
```bash
\033[0m
```


* python中调用
```python
print("\033[1;31;40m{}\033[0m".format(" 输出红色字符"))
```


* 颜色
```bash
echo -e "\033[0;30m 前景:黑 \033[0;39m"
echo -e "\033[0;31m 前景:红 \033[0;39m"
echo -e "\033[0;32m 前景:绿 \033[0;39m"
echo -e "\033[0;33m 前景:棕 \033[0;39m"
echo -e "\033[0;34m 前景:蓝 \033[0;39m"
echo -e "\033[0;35m 前景:紫 \033[0;39m"
echo -e "\033[0;36m 前景:青 \033[0;39m"
echo -e "\033[0;37m 前景:白 \033[0;39m"
echo -e "\033[0;40m 背景:黑 \033[0;39m"
echo -e "\033[0;41m 背景:红 \033[0;39m"
echo -e "\033[0;42m 背景:绿 \033[0;39m"
echo -e "\033[0;43m 背景:棕 \033[0;39m"
echo -e "\033[0;44m 背景:蓝 \033[0;39m"
echo -e "\033[0;45m 背景:紫 \033[0;39m"
echo -e "\033[0;46m 背景:青 \033[0;39m"
echo -e "\033[0;47m 背景:白 \033[0;39m"
echo -e "\033[0;49m 背景:黑 \033[0;39m"
```

```bash
for i in `seq 16 255`
do
    let "j = $i % 6"
    if [ $j -eq 4 ]
    then
        echo ""
    fi
    echo -e -n "\e[38;5;${i}m ${i}    "
done
```


* 例子
```bash
echo -e "\033[44;37;5m Hello \033[0m World"
# e:是命令echo的一个可选项,用于激活特殊字符的解析器.
# \033:引导非常规字符序列
# 44:前景
# 37:背景
# 5:显示方式
# m:设置属性
# \033[0m:重新设置属性到默认值
``` 


#### 打印棋盘

```bash
for((i=1;i<=8;i++))
do 
    for((j=1;j<=8;j++))
    do
        total=$(($i + $j))
        tmp=$(($total % 2))
        if [ "$tmp" -eq 0 ]
        then
            echo -e -n "\033[37m  \033[0m"
        else
            echo -e -n "\033[47m  \033[0m"
        fi
    done
    echo ""
done
```

