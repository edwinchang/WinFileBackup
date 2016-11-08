@echo off
rem ===功能：备份单个文件===
rem ===设置其它本地变量（开始）===
setlocal
rem ===设置目标备份文件夹名称（可修改）===
set bakdir=!bak
rem ===获取文件名===
set filename_in=%1
echo %filename_in%
rem ===传入文件路径为空，则跳出程序===
if filename_in == "" goto ERR
rem ===获取文件夹路径、文件名（不包含后缀）、文件名后缀===
FOR %%i IN (%filename_in%) DO (SET curPath=%%~dpi& SET file_name=%%~ni& SET file_suffix=%%~xi)
rem ===如果文件名为空（可能传入的地址为文件夹或本身为空值或其它非法字符）===
if file_name == "" goto ERR
rem ===拼接文件名全路径===
set ymd=%date:~2,2%%date:~5,2%%date:~8,2%
set bakfilename_full=%curPath%%bakdir%\%file_name%_%ymd%%file_suffix%
rem ==============
rem ===开始备份===
rem ===如目录不存在则创建===
set bakdirPath=%curPath%%bakdir%
if not exist %bakdirPath% (mkdir %bakdirPath%)
rem ===如果文件存在，再次拼接文件名全路径，否则进行备份并退出===
if exist %bakfilename_full% (GOTO NEXT)
copy %filename_in% %bakfilename_full%
set final_suffix=0
GOTO SUCC
rem ===再次拼接文件名全路径，从文件全路径后累加_2开始，如果文件存在，则再累加1（如变为_3），以此类推，循环9次，直到文件不存在并备份，或全部存在===
:NEXT
set circle_full=10
set final_suffix=0
for /L %%i in (2,1,%circle_full%) do (if not exist %curPath%%bakdir%\%file_name%_%ymd%_%%i%file_suffix% (copy %filename_in% %curPath%%bakdir%\%file_name%_%ymd%_%%i%file_suffix% & SET final_suffix=%%i& GOTO SUCC))
rem ===所有备份尝试都失败===
if %final_suffix%==0 (GOTO TRYALL)
:SUCC
if %final_suffix% gtr 0 (set final_filename=%file_name%_%ymd%_%final_suffix%%file_suffix%) else (set final_filename=%file_name%_%ymd%%file_suffix%)
rem ===输出成功信息===
echo ---文件 %final_filename% 备份成功!!!---
pause
exit
rem ===输出失败信息===
:TRYALL
echo ---所有%circle_full%次备份尝试都失败，请检查!!!---
pause
exit
rem ===输出失败信息===
:ERR
echo ---文件备份失败，请检查!!!---
pause
exit
endlocal
rem ===设置其它本地变量（结束）===
