package org.thorn.humpback.localpass.action;

import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.CreateNoteDialog;
import org.thorn.humpback.localpass.view.OpenNoteDialog;

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
        super(Context.MAIN_FRAME);
        this.filePath = filePath;
        this.isCreate = isCreate;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        if (isCreate) {
            CreateNoteDialog dialog = new CreateNoteDialog();
        } else {
            OpenNoteDialog dialog = new OpenNoteDialog(filePath);
        }
    }
}
