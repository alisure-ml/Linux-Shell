
### file sort

> 对文件内的记录进行排序

```bash
sort [选项] [输入文件]
```

* "-t:"以“：”分隔
* "-k3"按第3个域排序
* "-n"按数字大小排序
* "-r"结果逆向显示
* "-u"去除重复行
* "-o new-file"重定向到指定文件
```bash
sort -t: -k3nru -o new-file input-file
```

* "-c"测试是否排序
```bash
sort -t: -c input-file
```


### file uniq

> 去除文本中的连续的重复行

> sort -u 去除所有的重复行

* -c:打印每行重复的次数
* -d:只显示重复的行（重复的行只显示一次）
* -u:不显示重复的行

```
uniq -c input-file
```


### file join

> 两个文件中记录的连接


### file cut

> 按域或行提取文本（对每一行或域都会执行）

* 指定提取字符数或范围
```
cut -c3-8 input-file  # 提取第3到8个字符
```

* 指定提取域数或范围
```
cut -f3,8 input-file  # 提取第3和第8个域
```

* 改变域分隔符
```
cut -d: -f3-5 input-file
```


### file paste

> 粘贴


### file split

> 切割成小文件


### tar

> 归档命令

```
tar [选项] 文件名或目录名
```

* -c:创建新的包
* -r:添加新文件
* -t:列出包内容
* -u:更新内容
* -x:解压缩
* -f:使用压缩文件或设备（通常使必须的）
* -v:处理文件的详细信息
* -z:用gzip压缩和解压文件

**压缩**
```
tar -cf 压缩包名称 need-tar-file  # 将need-tar-file加入到new.ext中
tar -tf 压缩包名称  # 查看压缩包的内容

tar -rf 压缩包名称 other-need-tar-file  # 向new.ext中添加新的文件
tar -uf 压缩包名称 need-update-tar-file  # 向new.ext中更新文件

tar -czf  压缩包名称 need-tar-file  # 用gzip压缩，解压时也需要-z
```

**解压缩**
```
tar -xvf 压缩包名称  # 解压非gzip格式的压缩包
tar -zxvf 压缩包名称  # 解压gzip格式的压缩包
```

> 注意：tar -cf 将多个文件放在一起，并没有压缩。
gzip命令对tar创建的包进行压缩，使用tar -zxvf可进行解压。
也可以用gzip -d进行解压得到归档包，然后再对包用tar -xvf进行解压。
