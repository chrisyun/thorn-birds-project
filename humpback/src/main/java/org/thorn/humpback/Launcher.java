package org.thorn.humpback;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.service.Registry;
import org.thorn.humpback.frame.view.MainFrame;

import javax.swing.*;
import java.awt.*;
import java.net.URL;

public class Launcher {

    static Logger log = LoggerFactory.getLogger(Launcher.class);

    /**
     * Launch the application.
     */
    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    SpringContext context = new SpringContext();
                    context.setApplicationContext(new String[]{"humpback-Spring.xml"});

                    Registry registry = SpringContext.getBean(Registry.class);

                    LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
                    loggerContext.reset();
                    loggerContext.putProperty("location", registry.getLocation() + "/log");
                    JoranConfigurator joranConfigurator = new JoranConfigurator();
                    joranConfigurator.setContext(loggerContext);

                    URL url = Launcher.class.getResource("/log.xml");
                    joranConfigurator.doConfigure(url);

                    JFrame frame = new MainFrame();
                    frame.setVisible(true);
                    frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
                } catch (Exception e) {
                    log.error("Launcher exception", e);
                }
            }
        });
    }

}
