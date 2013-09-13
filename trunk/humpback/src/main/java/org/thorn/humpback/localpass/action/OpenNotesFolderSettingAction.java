package org.thorn.humpback.localpass.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.NotesFolderSettingDialog;

import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午2:45
 * @Version: 1.0
 */
public class OpenNotesFolderSettingAction extends AbsAction {

    public OpenNotesFolderSettingAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        new NotesFolderSettingDialog();
    }
}
