package org.thorn.humpback.frame.action;

import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午2:02
 * @Version: 1.0
 */
public class ExitAction extends AbsAction {


    public ExitAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        int result = JOptionPane.showConfirmDialog(super.parentComp, "是否确认退出？", "退出", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {
            System.exit(0);
        }
    }
}
