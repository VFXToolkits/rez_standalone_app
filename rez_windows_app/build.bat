@echo off
color 0a

REM ��ʼ��װpython-3.7.9 embed �汾 win32
REM �жϵ�ǰ�Ƿ�װ
REM https://www.python.org/ftp/python/3.7.9/python-3.7.9-embed-win32.zip


echo ��ǰ������������µ�python������rez��
set /p IS_BUILD_REZ_ENV=��������ֵ��ʼ����

if defined IS_BUILD_REZ_ENV (
    echo ȷ������
    goto start_download
) else (
    echo end
    goto end
)

:start_download
if exist %~dp0python-3.7.9-embed-win32\python.exe (
    echo ��ǰ��python�����Ѿ�����: 
    goto rez_download
) else (
    REM �ӹٷ�����
    echo start download python application
    curl -o %~dp0python-3.7.9-embed-win32.zip https://www.python.org/ftp/python/3.7.9/python-3.7.9-embed-win32.zip
    tar -xf %~dp0python-3.7.9-embed-win32.zip -d python-3.7.9-embed-win32
    del %~dp0python-3.7.9-embed-win32.zip
)

REM ��ʼ����rez��
REM https://codeload.github.com/AcademySoftwareFoundation/rez/zip/refs/heads/master

:rez_download

if exist %~dp0python-3.7.9-embed-win32\Scripts\.rez_production_install (
    echo ��ǰrez�����Ѿ�����
    goto end
) else (
    REM �ӹٷ�����
    echo start download rez script
    curl -o rez_temp.zip https://codeload.github.com/AcademySoftwareFoundation/rez/zip/refs/heads/master
    tar -xf %~dp0rez_temp.zip -d rez_temp
    del %~dp0rez_temp.zip
)

:init_rez_env

REM ��ʼ���û���

REM ����Scripts
mkdir %~dp0python-3.7.9-embed-win32\Scripts

REM ����Lib/site-packages
mkdir %~dp0python-3.7.9-embed-win32\Lib\site-packages

copy %~dp0temp\__main__.py %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\.rez_production_install %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\rez.bat %~dp0python-3.7.9-embed-win32\Scripts
copy %~dp0temp\python37._pth %~dp0python-3.7.9-embed-win32

REM ����site-packages

copy %~dp0rez_temp\rez-master\src\rez %~dp0python-3.7.9-embed-win32\Lib\site-packages
copy %~dp0rez_temp\rez-master\src\rezplugins %~dp0python-3.7.9-embed-win32\Lib\site-packages

REM �Ƴ�rez

rmdir /S /Q %~dp0rez_temp

setx PATH=%~dp0python-3.7.9-embed-win32\Scripts;%PATH%

echo build done

:end

pause

