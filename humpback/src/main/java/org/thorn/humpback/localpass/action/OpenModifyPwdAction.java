package org.thorn.humpback.localpass.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.ModifyPwdDialog;

import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午5:29
 * @Version: 1.0
 */
public class OpenModifyPwdAction extends AbsAction {

    public OpenModifyPwdAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        new ModifyPwdDialog();
    }
}
