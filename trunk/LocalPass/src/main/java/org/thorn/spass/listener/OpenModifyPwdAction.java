package org.thorn.spass.listener;

import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.ModifyPwdDialog;

import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午5:29
 * @Version: 1.0
 */
public class OpenModifyPwdAction extends AbsAction {

    public OpenModifyPwdAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        new ModifyPwdDialog();
    }
}
