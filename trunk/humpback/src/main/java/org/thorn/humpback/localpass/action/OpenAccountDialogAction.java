package org.thorn.humpback.localpass.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.AccountDialog;

import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 上午11:10
 * @Version: 1.0
 */
public class OpenAccountDialogAction extends AbsAction {

    public OpenAccountDialogAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        new AccountDialog();
    }
}
