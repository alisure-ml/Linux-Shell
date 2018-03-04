@echo off

set shell_project=C:\ALISURE\Python\Pycharm\File\other\Linux-Shell
set need_upload_md_path=md
set need_upload_file_path=github

set github_project=C:\ALISURE\IDEA\File\github-site\hexo\alisure.github.io
set github_file_path=source\_posts

:: 转换内容
echo begin upload-transfer.cmd
call upload-transfer.cmd %need_upload_file_path% %need_upload_md_path%
echo upload-transfer over

:: 复制文件到指定目录
copy %shell_project%\%need_upload_file_path% %github_project%\%github_file_path%

:: 部署上线
echo begin upload-hexo.cmd
call upload-hexo.cmd %github_project%
cd %shell_project%
echo upload-hexo over

:: 上传git
echo begin upload-git.cmd
call upload-git.cmd %github_project% %github_file_path%
cd %shell_project%
echo upload-git over

:: 删除生产的文件
echo begin delete file
rd /s /q %need_upload_file_path%
echo delete file

echo all over
