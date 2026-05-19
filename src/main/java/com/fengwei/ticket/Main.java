package com.fengwei.ticket;

import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

import java.io.File;

public class Main {
    public static void main(String[] args) throws Exception {
        System.out.println("=== Concert Ticket System Startup ===");
        
        // Create Tomcat server instance
        Tomcat tomcat = new Tomcat();
        
        // Set port number
        int port = 8081;
        tomcat.setPort(port);
        
        // Set webapp directory
        String webappDirLocation = "src/main/webapp/";
        StandardContext ctx = (StandardContext) tomcat.addWebapp("/ticket-system", new File(webappDirLocation).getAbsolutePath());
        
        // Set classpath for compiled classes
        String targetClasses = "target/classes";
        File additionWebInfClasses = new File(targetClasses);
        WebResourceRoot resources = new StandardRoot(ctx);
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes", 
                additionWebInfClasses.getAbsolutePath(), "/"));
        ctx.setResources(resources);
        
        // Start the server
        tomcat.start();
        
        System.out.println("=== Server Started Successfully ===");
        System.out.println("Server is running at: http://localhost:" + port + "/ticket-system");
        System.out.println("Press Ctrl+C to stop the server");
        
        // Keep the server running
        tomcat.getServer().await();
    }
}