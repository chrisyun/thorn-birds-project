package org.thorn.humpback.reader.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.reader.view.ReaderPanel;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午1:48
 * @Version: 1.0
 */
public class LoadReaderPanelAction extends AbsAction {

    public LoadReaderPanelAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        JPanel panel = new ReaderPanel();
        Context.MAIN_FRAME.setMainPane(panel);
    }
}
