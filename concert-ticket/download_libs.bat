@echo off
echo 下载项目所需依赖文件...

mkdir lib

REM 下载Tomcat核心依赖
echo 下载Tomcat依赖...
curl -L -o lib\tomcat-embed-core-10.1.7.jar https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-core/10.1.7/tomcat-embed-core-10.1.7.jar
curl -L -o lib\tomcat-embed-jasper-10.1.7.jar https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-jasper/10.1.7/tomcat-embed-jasper-10.1.7.jar
curl -L -o lib\tomcat-embed-el-10.1.7.jar https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-el/10.1.7/tomcat-embed-el-10.1.7.jar

REM 下载MySQL驱动
echo 下载MySQL驱动...
curl -L -o lib\mysql-connector-j-8.0.33.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

REM 下载Servlet和JSP相关依赖
echo 下载Servlet/JSP依赖...
curl -L -o lib\jakarta.servlet-api-6.0.0.jar https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar
curl -L -o lib\javax.servlet.jsp-api-3.1.0.jar https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/3.1.0/javax.servlet.jsp-api-3.1.0.jar

REM 下载JSTL库
echo 下载JSTL库...
curl -L -o lib\taglibs-standard-impl-1.2.5.jar https://repo1.maven.org/maven2/org/apache/taglibs/taglibs-standard-impl/1.2.5/taglibs-standard-impl-1.2.5.jar
curl -L -o lib\taglibs-standard-spec-1.2.5.jar https://repo1.maven.org/maven2/org/apache/taglibs/taglibs-standard-spec/1.2.5/taglibs-standard-spec-1.2.5.jar

echo 下载完成！
dir lib