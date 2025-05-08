@echo off   
setlocal enabledelayedexpansion

:: Solicitar datos al usuario
set /p ip_address=Introduce la dirección IP: 
set /p subnet_mask=Introduce la máscara de red: 
set /p gateway=Introduce la puerta de enlace: 

:: Configurar la interfaz de red Ethernet
echo Configurando la interfaz de red...
netsh interface ip set address name="Ethernet" static %ip_address% %subnet_mask% %gateway%

:: Verificar si la configuración fue exitosa
if %errorlevel% equ 0 (
    echo Configuración aplicada correctamente.
) else (
    echo Error al aplicar la configuración.
    exit /b 1
)

:: Crear un log con la fecha y configuración aplicada
set log_file=config_red.log
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set formatted_date=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2! !datetime:~8,2!:!datetime:~10,2!:!datetime:~12,2!

echo [%formatted_date%] IP: %ip_address%, Máscara: %subnet_mask%, Puerta de enlace: %gateway% >> %log_file%

echo Configuración registrada en %log_file%.
pause
