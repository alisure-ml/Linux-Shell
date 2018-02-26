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
   2. 在`/home`下创建新用户的主目录，并将`/etc/skel`中的文件复制到该目录中。
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
