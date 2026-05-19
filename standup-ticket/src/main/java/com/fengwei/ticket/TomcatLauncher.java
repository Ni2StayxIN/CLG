package com.fengwei.ticket;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class TomcatLauncher {

    public static void main(String[] args) throws Exception {
        int port = Integer.parseInt(System.getProperty("server.port", "8081"));

        File webapp = new File("target/ticket-system");
        if (!webapp.exists()) {
            System.err.println("Run 'mvn package' first");
            System.exit(1);
        }

        File baseDir = new File("target/tomcat-base");
        baseDir.mkdirs();
        new File(baseDir, "webapps").mkdirs();
        new File(baseDir, "work").mkdirs();
        new File(baseDir, "temp").mkdirs();

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.setBaseDir(baseDir.getAbsolutePath());
        tomcat.getConnector();

        Context ctx = tomcat.addWebapp("/ticket-system", webapp.getAbsolutePath());
        ctx.setParentClassLoader(TomcatLauncher.class.getClassLoader());

        tomcat.start();

        System.out.println();
        System.out.println("========================================");
        System.out.println("  http://localhost:" + port + "/ticket-system/shows");
        System.out.println("========================================");
        System.out.println();

        tomcat.getServer().await();
    }
}
