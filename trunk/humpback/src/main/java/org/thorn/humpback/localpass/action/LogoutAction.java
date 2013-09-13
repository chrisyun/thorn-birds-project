package org.thorn.humpback.localpass.action;

import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.frame.view.MainFrame;
import org.thorn.humpback.frame.view.TopMenuBar;
import org.thorn.humpback.localpass.service.SessionService;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午4:09
 * @Version: 1.0
 */
public class LogoutAction extends AbsAction {


    public LogoutAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        int result = JOptionPane.showConfirmDialog(super.parentComp, "是否确认注销？", "注销", JOptionPane.YES_NO_OPTION,
                JOptionPane.INFORMATION_MESSAGE);
        if (result == JOptionPane.YES_OPTION) {

            SessionService sessionService = SpringContext.getBean(SessionService.class);
            sessionService.clearSession();

            MainFrame frame = Context.MAIN_FRAME;

            TopMenuBar topMenuBar = (TopMenuBar) Context.MAIN_FRAME.getJMenuBar();
            topMenuBar.removeOperationMenus();
            frame.removeMainPane();
        }
    }
}
