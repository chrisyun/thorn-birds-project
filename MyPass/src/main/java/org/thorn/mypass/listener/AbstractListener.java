package org.thorn.mypass.listener;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JOptionPane;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.mypass.view.ComponentReference;

public abstract class AbstractListener implements ActionListener {

    static Logger log = LoggerFactory.getLogger(AbstractListener.class);

    protected Component comp;

    @Override
    public void actionPerformed(ActionEvent e) {
        try {
            action(e);
        } catch (Exception ex) {
            log.error("The button name : " + e.getActionCommand() + " and panel cls : " + e.getSource().getClass(), ex);
            if (comp == null) {
                comp = ComponentReference.getMainFrame();
            }
            String msg = ex.getMessage().replaceAll(";", ";\n");
            JOptionPane.showMessageDialog(comp, msg, "操作异常", JOptionPane.ERROR_MESSAGE);
        }
    }

    public abstract void action(ActionEvent e) throws Exception;

}
