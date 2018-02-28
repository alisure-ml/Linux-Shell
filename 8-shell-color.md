# TODO

### 终端颜色


* [shell 终端字符颜色](http://blog.csdn.net/zj0910/article/details/47824139)


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
            echo -e -n "\033[47m  \033[0m"
        else
            echo -e -n "\033[47m  \033[0m"
        fi
    done
    echo ""
done
```
