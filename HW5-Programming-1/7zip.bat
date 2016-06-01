set STARTTIME=%TIME%
7z.exe a "C:\Dropbox\Studies\BGU\Information Theory\HW5-Programming-1\orig.zip" "C:\Dropbox\Studies\BGU\Information Theory\HW5-Programming-1\orig.txt"
set ENDTIME=%TIME%
set /A DURATION=%ENDTIME%-%STARTTIME%
rem we might have measured the time inbetween days
if %ENDTIME% LSS %STARTTIME% set set /A DURATION=%STARTTIME%-%ENDTIME%
rem now break the centiseconds down to hors, minutes, seconds and the remaining centiseconds
set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)
rem some formatting
if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%
rem outputing
echo STARTTIME: %STARTTIME% centiseconds
echo ENDTIME: %ENDTIME% centiseconds
echo DURATION: %DURATION% in centiseconds
echo %DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONHS%



set STARTTIME=%TIME%
C:\Program Files\7-Zip>7z.exe e "C:\Dropbox\Studies\BGU\Information Theory\HW5-Programming-1\orig.zip"
set ENDTIME=%TIME%
set /A DURATION=%ENDTIME%-%STARTTIME%
rem we might have measured the time inbetween days
if %ENDTIME% LSS %STARTTIME% set set /A DURATION=%STARTTIME%-%ENDTIME%
rem now break the centiseconds down to hors, minutes, seconds and the remaining centiseconds
set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)
rem some formatting
if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%
rem outputing
echo STARTTIME: %STARTTIME% centiseconds
echo ENDTIME: %ENDTIME% centiseconds
echo DURATION: %DURATION% in centiseconds
echo %DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONHS%
