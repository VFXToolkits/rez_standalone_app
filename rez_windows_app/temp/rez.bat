@echo off
echo %*
call %~dp0..\python.exe %~dp0__main__.py %*
