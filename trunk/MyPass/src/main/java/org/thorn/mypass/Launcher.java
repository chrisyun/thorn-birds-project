package org.thorn.mypass;

import java.awt.EventQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.core.context.SpringContext;
import org.thorn.core.swing.ImageUtils;
import org.thorn.mypass.view.ComponentReference;
import org.thorn.mypass.view.MainFrame;

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
                    context.setApplicationContext("applicationContext.xml");
                    
                    MainFrame frame = new MainFrame();
                    frame.setTitle("My Pass");
                    frame.setIconImage(ImageUtils.getIconFromCls("/icons/logo.png").getImage());
                    frame.setVisible(true);

                    ComponentReference.setMainFrame(frame);
                    frame.doLogin();
                } catch (Exception e) {
                    log.error("Launcher exception", e);
                }
            }
        });
    }

}
