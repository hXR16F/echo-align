@echo off

pause

:loop
	cls
	echo. & call :echo-align center "centered text"

	timeout 1 /nobreak >nul
	goto :loop

:echo-align <align> <text>
	setlocal EnableDelayedExpansion
	(set^ tmp=%~2)
	if defined tmp (
		set "len=1"
		for %%p in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
			if "!tmp:~%%p,1!" neq "" (
				set /a "len+=%%p"
				set "tmp=!tmp:~%%p!"
			)
		)
	) else (
		set len=0
	)

	for /f "skip=4 tokens=2 delims=:" %%i in ('mode con') do (
		set /a cols=%%i
		goto loop_end
	)
	:loop_end

	if /i "%1" equ "center" (
		set /a offsetnum=^(%cols% / 2^) - ^(%len% / 2^)
		set "offset="
		for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
	) else if /i "%1" equ "right" (
		set /a offsetnum=^(%cols% - %len%^)
		set "offset="
		for /l %%i in (1 1 !offsetnum!) do set "offset=!offset! "
	)

	echo %offset%%~2
	endlocal

	exit /b
