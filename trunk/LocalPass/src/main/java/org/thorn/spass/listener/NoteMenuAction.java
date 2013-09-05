package org.thorn.spass.listener;

import org.thorn.spass.view.CreateNoteDialog;
import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.OpenNoteDialog;

import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午3:04
 * @Version: 1.0
 */
public class NoteMenuAction extends AbsAction {

    private String filePath;

    private boolean isCreate;

    public NoteMenuAction(String filePath, boolean isCreate) {
        super(MFrame.MAIN_FRAME);
        this.filePath = filePath;
        this.isCreate = isCreate;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        if(isCreate) {
            CreateNoteDialog dialog = new CreateNoteDialog();
        } else {
            OpenNoteDialog dialog =new OpenNoteDialog(filePath);
        }
    }
}
