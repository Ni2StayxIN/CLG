@echo off
set CLASSPATH=target\classes;target\ticket-system\WEB-INF\lib\* 
java -cp %CLASSPATH% com.fengwei.ticket.Main