@echo off
rem ===���ܣ����ݵ����ļ�===
rem ===�����������ر�������ʼ��===
setlocal
rem ===����Ŀ�걸���ļ������ƣ����޸ģ�===
set bakdir=!bak
rem ===��ȡ�ļ���===
set filename_in=%1
echo %filename_in%
rem ===�����ļ�·��Ϊ�գ�����������===
if filename_in == "" goto ERR
rem ===��ȡ�ļ���·�����ļ�������������׺�����ļ�����׺===
FOR %%i IN (%filename_in%) DO (SET curPath=%%~dpi& SET file_name=%%~ni& SET file_suffix=%%~xi)
rem ===����ļ���Ϊ�գ����ܴ���ĵ�ַΪ�ļ��л���Ϊ��ֵ�������Ƿ��ַ���===
if file_name == "" goto ERR
rem ===ƴ���ļ���ȫ·��===
set ymd=%date:~2,2%%date:~5,2%%date:~8,2%
set bakfilename_full=%curPath%%bakdir%\%file_name%_%ymd%%file_suffix%
rem ==============
rem ===��ʼ����===
rem ===��Ŀ¼�������򴴽�===
set bakdirPath=%curPath%%bakdir%
if not exist %bakdirPath% (mkdir %bakdirPath%)
rem ===����ļ����ڣ��ٴ�ƴ���ļ���ȫ·����������б��ݲ��˳�===
if exist %bakfilename_full% (GOTO NEXT)
copy %filename_in% %bakfilename_full%
set final_suffix=0
GOTO SUCC
rem ===�ٴ�ƴ���ļ���ȫ·�������ļ�ȫ·�����ۼ�_2��ʼ������ļ����ڣ������ۼ�1�����Ϊ_3�����Դ����ƣ�ѭ��9�Σ�ֱ���ļ������ڲ����ݣ���ȫ������===
:NEXT
set circle_full=10
set final_suffix=0
for /L %%i in (2,1,%circle_full%) do (if not exist %curPath%%bakdir%\%file_name%_%ymd%_%%i%file_suffix% (copy %filename_in% %curPath%%bakdir%\%file_name%_%ymd%_%%i%file_suffix% & SET final_suffix=%%i& GOTO SUCC))
rem ===���б��ݳ��Զ�ʧ��===
if %final_suffix%==0 (GOTO TRYALL)
:SUCC
if %final_suffix% gtr 0 (set final_filename=%file_name%_%ymd%_%final_suffix%%file_suffix%) else (set final_filename=%file_name%_%ymd%%file_suffix%)
rem ===����ɹ���Ϣ===
echo ---�ļ� %final_filename% ���ݳɹ�!!!---
pause
exit
rem ===���ʧ����Ϣ===
:TRYALL
echo ---����%circle_full%�α��ݳ��Զ�ʧ�ܣ�����!!!---
pause
exit
rem ===���ʧ����Ϣ===
:ERR
echo ---�ļ�����ʧ�ܣ�����!!!---
pause
exit
endlocal
rem ===�����������ر�����������===
