package org.thorn.spass.listener;

import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.NotesFolderSettingDialog;

import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午2:45
 * @Version: 1.0
 */
public class OpenNotesFolderSettingAction extends AbsAction {

    public OpenNotesFolderSettingAction() {
        super(MFrame.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        new NotesFolderSettingDialog();
    }
}
