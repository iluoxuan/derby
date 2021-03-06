@REM --
@REM -- REQUIREMENTS:
@REM --         You must have the derby jar files as well as the
@REM --   derby network server class files in your classpath.
@REM --
@REM --  Check the setNetworkServerCP.bat file for an example of
@REM --   what to set.
@REM -- This file for use on Windows systems
@REM ---------------------------------------------------------

@echo off
@rem set DERBY_INSTALL=


@if !"%CLASSPATH%"==! call "%DERBY_INSTALL%"/frameworks/NetworkServer/bin/setNetworkServerCP.bat
@if "%CLASSPATH%" == "" call "%DERBY_INSTALL%"/frameworks/NetworkServer/bin/setNetworkServerCP.bat

if   "%JAVA_HOME%" == "" goto setjavaMsg

:set_host

if "%1" == "" goto setServerHost
set derbyHost=%1
goto set_port

:setServerHost
if not "%DERBY_SERVER_HOST%" == "" goto setServerHost2
set derbyHost=localhost
goto set_port

:setServerHost2
set derbyHost=%DERBY_SERVER_HOST%


:set_port
shift
if "%1" == "" goto setServerPort
set derbyPort=%1
goto stop_server


:setServerPort
if not "%DERBY_SERVER_PORT%" == ""  goto setServerPort2
set derbyPort=1527
goto stop_server

:setServerPort2
set derbyPort=%DERBY_SERVER_PORT%

:stop_server

@REM ---------------------------------------------------------
@REM -- shutdown Derby as a Network server
@REM ---------------------------------------------------------
%JAVA_HOME%\bin\java org.apache.derby.drda.NetworkServerControl shutdown -h %derbyHost% -p %derbyPort%

goto end
@REM ---------------------------------------------------------
@REM -- To use a different JVM with a different syntax, simply edit
@REM -- this file
@REM ---------------------------------------------------------

:setJavaMsg
echo Please set JAVA_HOME in order to start the Network Server

:end
set derbyPort=
set derbyHost=
