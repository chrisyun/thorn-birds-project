package org.thorn.humpback.codebuilder.action;

import org.thorn.humpback.codebuilder.view.ExecuteSqlPanel;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.frame.view.MainFrame;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-18 下午5:04
 * @Version: 1.0
 */
public class RetExecuteSqlAction extends AbsAction {

    public RetExecuteSqlAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        MainFrame mainFrame = Context.MAIN_FRAME;

        JPanel panel = new ExecuteSqlPanel();
        mainFrame.setMainPane(panel);
    }
}
