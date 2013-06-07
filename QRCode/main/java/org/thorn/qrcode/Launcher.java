package org.thorn.qrcode;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
                    MainFrame frame = new MainFrame();
                    frame.setVisible(true);
                } catch (Exception e) {
                    log.error("Launcher exception", e);
                }
            }
        });
    }

}
