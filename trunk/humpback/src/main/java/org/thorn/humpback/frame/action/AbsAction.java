package org.thorn.humpback.frame.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public abstract class AbsAction implements ActionListener {

    static Logger log = LoggerFactory.getLogger(AbsAction.class);

    protected Component parentComp;

    public AbsAction(Component parentComp) {
        this.parentComp = parentComp;
    }

    public void actionPerformed(ActionEvent e) {
        try {
            action(e);
        } catch (Exception ex) {
            log.error("The button name : " + e.getActionCommand() + " and panel cls : " + e.getSource().getClass(), ex);
            String msg = ex.getMessage().replaceAll(";", ";\n");
            JOptionPane.showMessageDialog(parentComp, msg, "操作异常", JOptionPane.ERROR_MESSAGE);
        }
    }

    public abstract void action(ActionEvent e) throws Exception;

}
