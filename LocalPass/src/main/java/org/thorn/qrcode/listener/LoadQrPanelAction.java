package org.thorn.qrcode.listener;

import org.thorn.qrcode.view.QrPanel;
import org.thorn.spass.listener.AbsAction;
import org.thorn.spass.view.MFrame;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午5:17
 * @Version: 1.0
 */
public class LoadQrPanelAction extends AbsAction {

    public LoadQrPanelAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        JPanel panel = new QrPanel();
        MFrame.MAIN_FRAME.setMainPane(panel);
    }
}
