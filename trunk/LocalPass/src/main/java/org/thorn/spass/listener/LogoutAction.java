package org.thorn.spass.listener;

import org.thorn.core.context.SpringContext;
import org.thorn.spass.service.SessionService;
import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.TopMenuBar;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午4:09
 * @Version: 1.0
 */
public class LogoutAction extends AbsAction {


    public LogoutAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        int result = JOptionPane.showConfirmDialog(super.parentComp, "是否确认注销？", "注销", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {

            SessionService sessionService = SpringContext.getBean(SessionService.class);
            sessionService.clearSession();

            MFrame frame = MFrame.MAIN_FRAME;

            TopMenuBar topMenuBar = (TopMenuBar) MFrame.MAIN_FRAME.getJMenuBar();
            topMenuBar.removeOperationMenus();
            frame.removeMainPane();
        }
    }
}
