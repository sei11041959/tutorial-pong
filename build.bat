@echo off

set project="pong"
set srcpath="./src/*"
set zipfile="%project%.zip"
set lovefile="%project%.love"
set lovepath="C:\Program Files\LOVE\love.exe"

echo commpress!
powershell compress-archive -Path '%srcpath%' -DestinationPath '%zipfile%'
echo %zipfile%
echo done


echo lovefile
ren %zipfile% %lovefile%
echo %lovefile%
echo done


echo crafting exe...
copy /b %lovepath%+%lovefile% %project%.exe
echo done


del %lovefile%
echo all task DONE!
pause