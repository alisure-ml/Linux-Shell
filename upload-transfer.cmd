@echo off

:: 1. 新建文件夹
if not exist %1 md %1

cd %2

:: 2. 新建文件（命名）
for /f "delims=" %%a in ('dir /b *.md') do (
    copy %%a ..\%1\Shell-%%a
)

cd ..
