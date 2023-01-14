@echo off
color 0a

REM 开始安装python-3.7.9 embed 版本 win32
REM 判断当前是否安装
REM https://www.python.org/ftp/python/3.7.9/python-3.7.9-embed-win32.zip


echo 当前会从网络下载新的python环境和rez包
set /p IS_BUILD_REZ_ENV=输入任意值开始构建

if defined IS_BUILD_REZ_ENV (
    echo 确认下载
    goto start_download
) else (
    echo end
    goto end
)

:start_download
if exist %~dp0python-3.7.9-embed-win32\python.exe (
    echo 当前的python环境已经存在: 
    goto rez_download
) else (
    REM 从官方下载
    echo start download python application
    curl -o %~dp0python-3.7.9-embed-win32.zip https://www.python.org/ftp/python/3.7.9/python-3.7.9-embed-win32.zip
    tar -xf %~dp0python-3.7.9-embed-win32.zip -d python-3.7.9-embed-win32
    del %~dp0python-3.7.9-embed-win32.zip
)

REM 开始下载rez包
REM https://codeload.github.com/AcademySoftwareFoundation/rez/zip/refs/heads/master

:rez_download

if exist %~dp0python-3.7.9-embed-win32\Scripts\.rez_production_install (
    echo 当前rez环境已经存在
    goto end
) else (
    REM 从官方下载
    echo start download rez script
    curl -o rez_temp.zip https://codeload.github.com/AcademySoftwareFoundation/rez/zip/refs/heads/master
    tar -xf %~dp0rez_temp.zip -d rez_temp
    del %~dp0rez_temp.zip
)

:init_rez_env

REM 开始配置环境

REM 创建Scripts
mkdir %~dp0python-3.7.9-embed-win32\Scripts

REM 创建Lib/site-packages
mkdir %~dp0python-3.7.9-embed-win32\Lib\site-packages

copy %~dp0temp\__main__.py %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\.rez_production_install %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\rez.bat %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\python37._pth %~dp0python-3.7.9-embed-win32

REM 复制site-packages

copy %~dp0rez_temp\rez-master\src\rez %~dp0python-3.7.9-embed-win32\Lib\site-packages
copy %~dp0rez_temp\rez-master\src\rezplugins %~dp0python-3.7.9-embed-win32\Lib\site-packages

REM 移除rez

rmdir /S /Q %~dp0rez_temp

setx PATH=%~dp0python-3.7.9-embed-win32\Scripts;%PATH%

echo build done

:end

pause

