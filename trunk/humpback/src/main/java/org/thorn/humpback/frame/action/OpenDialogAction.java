package org.thorn.humpback.frame.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.humpback.codebuilder.view.DBConfigDialog;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.AccountDialog;
import org.thorn.humpback.localpass.view.ModifyPwdDialog;
import org.thorn.humpback.localpass.view.NotesFolderSettingDialog;

import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-16 上午9:44
 * @Version: 1.0
 */
public class OpenDialogAction extends AbsAction {

    public OpenDialogAction() {
        super(Context.MAIN_FRAME);
    }

    public OpenDialogAction(Component parentComp) {
        super(parentComp);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        String command = e.getActionCommand();

        if(StringUtils.equals(command, AccountDialog.class.getName())) {
            new AccountDialog();
        } else if(StringUtils.equals(command, NotesFolderSettingDialog.class.getName())) {
            new NotesFolderSettingDialog();
        } else if(StringUtils.equals(command, ModifyPwdDialog.class.getName())) {
            new ModifyPwdDialog();
        } else if(StringUtils.equals(command, DBConfigDialog.class.getName())) {
            new DBConfigDialog();
        }
    }
}
