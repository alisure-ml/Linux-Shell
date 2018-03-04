:: cd到指定目录
pushd %1

:: 向git中添加文件
git add %2

:: commit修改
git commit -m update

:: 上传
:: Username:ALISURE
:: Password:
git push
