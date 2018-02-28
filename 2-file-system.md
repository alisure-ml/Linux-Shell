## Linux文件系统


### 用户和用户组管理


#### Linux用户分为三类

1. root用户   
系统唯一，拥有最高权限。

2. 虚拟用户  
不具有登录系统的能力，但对于系统的运行不可或缺。

3. 普通用户 
能登陆系统，权限受到限制。


#### 常用命令

* 添加账户: useradd
```
useradd [option] [username]
```
   1. 在`/etc/passwd`中添加一条记录。
   2. 在`/home`下创建新用户的主目录，并将`/etc/skel`中的文件复制到该目录中(加上-m参数才会创建主目录)。
   3. 设置登录口令后才能登录。

查看新创建的用户和用户主目录
```
tail -l /etc/passwd
```

查看创建用户的密码
```
sudo tail -l /etc/shadow
```

* 修改用户帐号: usermod
```
sudo usermod [option] [username]
```
   1. 修改密码：显示为明码，用`passwd`为加密后的密码。
   ```
   sudo usermod -p 12345 username
   ```
   
   2. 修改用户登录时的目录
   ```
   sudo usermod -d /home/some/directory username
   ```

* 删除用户帐号: userdel
```
sudo userdel -r username
```

* 管理用户口令: passwd
```
sudo passwd [option] [username]
```


#### 用户组

* 用户组添加命令：groupadd

* 用户组修改命令：groupmod

* 用户组删除命令：groupdel


### 文件和目录操作

> Linux文件为无结构的字符流，文件名长度限制在255个字符以内。


#### 文件操作常用命令

* 文件清单命令：ls
```
ls [option] [file or directory]

ls -l
ls -l /home
```

* 文件复制命令：cp
```
cp [option] [source] [destination]
-i : 覆盖提示
-r : 递归地复制目录 
```

* 文件移动命令：mv
```
mv [option] [source] [destination]
-i : 覆盖提示
若source目录和destination在同一目录下，可实现重命名。
```

* 文件删除命令：rm
```
rm [option] [filename or directoryName]
-i : 删除确认
-r : 递归地删除目录
```

#### 目录操作常用命令

* 创建目录命令：mkdir
```
mkdir [option] [directoryName]
mkdir -m 777 directoryName: 设置目录的权限
mkdir -p dir/dir: 创建多级目录
```

* 删除目录命令：rmdir
```
rmdir [option] [directoryName]
rmdir -p directoryName: 递归删除空目录
```

* 目录切换命令：cd
```
cd [directoryName]
cd : 返回登录目录
cd ~ : 返回登录目录
cd - ： 返回上次访问的目录
```

#### 权限管理

* 三种访问权限：只读r、只写w、可执行x

* 三种类型用户：文件所有者u、同组用户g、其他用户o

* 第一位：`-`表示文件/`d`表示目录，后面的`-`表示没有相应权限

* 更改权限命令：chmod
```
chmod [userType] [signal] [type] [filename]
```
   1. 文字设定法
   ```
   chmod u+x,g+w,o+r filename： 文件所有者添加可执行权限，同组用户添加只写权限，其他用户添加只读权限
   chmod a+x filename: 所有用户添加可执行权限
   chmod g-x filename: 同组用户取消可执行权限
   chmod u=rw filename: 文件所有者只有只读和只写权限
   ```
   2. 数字设定法
   ```
   无权限：0,只读：4,只写：2,可执行：1
   三个数字，依次表示u,g,o
   chmod u+x,g+w filename 等价于 chmod 764
   ```
   
* 更改文件属主命令：chown

* 查找文件命令：find
```
find [路径] [选项] [操作]
find . -name "a*" -print: 在当前目录下，根据文件名查找以“a”开头的文件，并打印出结果
find . -name "a*" -exec ls -l {} \;: 对匹配的文件执行给出的Shell命令，{}会被搜索到的文件替换。
```


### 文本编辑器


#### vim编辑器

* 基础操作
```
vim [option] [filename...]

vim -R filename: 以只读方式编辑文件
vim +n filename: 编辑文件并将光标置于第n行
vim + filename: 编辑文件并将光标置于最后一行
```

* 工作模式

   1. 一般模式(命令行模式)：查看内容、退出、保存修改等
   ```
   1. vim filename  # 进入vim编辑器
   2. ：  # 按冒号“：”（Shift+;）
   3. “：W”:保存，“：Q”:退出，":q!":强制退出不保存，“Wq”:保存并退出
   ```
   
   2. 插入模式：编辑
   ```
   1. 在一般模式下按"i","o","a"都可以进入编辑模式。
   2. 按Esc从编辑模式退回到一般模式。
   ```
   
   3. 底行工作模式：搜索、替换
   ```
   1. 在一般模式下按"/","?"或":"进入底行工作模式。
   2. 按Esc从底行工作模式退回到一般模式。
   
   3. 搜索："/sth"
   4. 替换(第一次出现)："/:s/old_string/new_string"
   5. 替换(所有)："/:s/old_string/new_string/g"
   ```
   
* 配置文件
   1. 一般模式下按":"进入底行工作模式，输入`echo $VIM`显示配置文件位置
   2. 配置文件位置一般在`/usr/share/vim`

* 常用命令
   1. `dd`(命令行模式)：删除整行
   2. 
