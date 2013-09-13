package org.thorn.humpback;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.view.MainFrame;

import javax.swing.*;
import java.awt.*;

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
