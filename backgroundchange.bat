@echo off
title BTELNYY Background Changer
@powershell.exe set-executionpolicy Unrestricted -scope CurrentUser
@powershell.exe -file backgroundchange.ps1
echo Changes Finished
pause

