package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.NoteDialog;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午3:04
 * @Version: 1.0
 */
public class CreateOrOpenNoteAction extends AbsAction {

    private String filePath;

    private boolean isCreate;

    public CreateOrOpenNoteAction(String filePath, boolean isCreate) {
        super(MFrame.MAIN_FRAME);
        this.filePath = filePath;
        this.isCreate = isCreate;
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        NoteDialog dialog = new NoteDialog(MFrame.MAIN_FRAME, isCreate, filePath);
    }
}
