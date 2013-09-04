package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.spass.service.AccountService;
import org.thorn.spass.service.LocationService;
import org.thorn.spass.view.AccountTable;
import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.NoteDialog;
import org.thorn.spass.view.TopMenuBar;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午3:43
 * @Version: 1.0
 */
public class LoadNoteAction extends AbsAction {

    private JTextField file;

    private JPasswordField passwordField;

    private NoteDialog noteDialog;

    private boolean isCreate;

    public LoadNoteAction(Component parentComp, JTextField file, JPasswordField passwordField, boolean isCreate) {
        super(parentComp);
        this.noteDialog = (NoteDialog) parentComp;
        this.file = file;
        this.passwordField = passwordField;
        this.isCreate = isCreate;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        String filePath = file.getText();
        String pwd = String.copyValueOf(passwordField.getPassword());

        if (StringUtils.isEmpty(filePath)) {
            JOptionPane.showMessageDialog(noteDialog, "请选择密码本", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            if (StringUtils.isEmpty(pwd)) {
                JOptionPane.showMessageDialog(noteDialog, "请输入密码", "错误", JOptionPane.WARNING_MESSAGE);
            } else {
                AccountService accountService = SpringContext.getBean(AccountService.class);
                if (isCreate) {
                    accountService.createNote(filePath, pwd);
                } else {
                    accountService.loadNote(filePath, pwd);
                }

                LocationService locationService = SpringContext.getBean(LocationService.class);
                locationService.addOpenedNote(filePath);

                AccountTable accountTable = new AccountTable();
                MFrame.MAIN_FRAME.setMainPane(accountTable);

                noteDialog.setVisible(false);

                TopMenuBar topMenuBar = (TopMenuBar) MFrame.MAIN_FRAME.getJMenuBar();
                topMenuBar.addOperationMenus();
            }
        }
    }
}
