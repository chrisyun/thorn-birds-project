package org.thorn.spass.listener;

import org.thorn.spass.view.AccountDialog;
import org.thorn.spass.view.MFrame;

import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 上午11:10
 * @Version: 1.0
 */
public class OpenAccountDialogAction extends AbsAction {

    public OpenAccountDialogAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        AccountDialog accountDialog = new AccountDialog();
    }
}
