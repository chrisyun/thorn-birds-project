package org.thorn.humpback.qrcode.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.qrcode.view.QrPanel;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午5:17
 * @Version: 1.0
 */
public class LoadQrPanelAction extends AbsAction {

    public LoadQrPanelAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        JPanel panel = new QrPanel();
        Context.MAIN_FRAME.setMainPane(panel);
    }
}
