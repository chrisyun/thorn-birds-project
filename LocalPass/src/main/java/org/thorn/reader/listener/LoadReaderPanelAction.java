package org.thorn.reader.listener;

import org.thorn.reader.view.ReaderPanel;
import org.thorn.spass.listener.AbsAction;
import org.thorn.spass.view.MFrame;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午1:48
 * @Version: 1.0
 */
public class LoadReaderPanelAction extends AbsAction {

    public LoadReaderPanelAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        JPanel panel = new ReaderPanel();
        MFrame.MAIN_FRAME.setMainPane(panel);
    }
}
