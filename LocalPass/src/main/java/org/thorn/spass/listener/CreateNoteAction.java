package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.spass.service.AccountService;
import org.thorn.spass.service.LocationService;
import org.thorn.spass.view.AccountTable;
import org.thorn.spass.view.MFrame;
import org.thorn.spass.view.TopMenuBar;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午3:43
 * @Version: 1.0
 */
public class CreateNoteAction extends AbsAction {

    private JTextField folder;

    private JTextField noteName;

    private JPasswordField passwordField;

    private JDialog noteDialog;

    public CreateNoteAction(Component parentComp, JTextField folder,
                            JTextField noteName, JPasswordField passwordField) {
        super(parentComp);
        this.noteDialog = (JDialog) parentComp;
        this.folder = folder;
        this.noteName = noteName;
        this.passwordField = passwordField;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        String folderPath = folder.getText();
        String note = noteName.getText();
        String pwd = String.copyValueOf(passwordField.getPassword());

        if (StringUtils.isEmpty(folderPath)) {
            JOptionPane.showMessageDialog(noteDialog, "请选择目录", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(note)) {
            JOptionPane.showMessageDialog(noteDialog, "请输入密码本名称", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(pwd)) {
            JOptionPane.showMessageDialog(noteDialog, "请输入密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            AccountService accountService = SpringContext.getBean(AccountService.class);

            StringBuilder filePath = new StringBuilder(folderPath);
            if(!folderPath.endsWith("\\")) {
                filePath.append("\\").append(note);
            } else {
                filePath.append(note);
            }

            accountService.createNote(filePath.toString(), pwd);

            LocationService locationService = SpringContext.getBean(LocationService.class);
            locationService.addOpenedNote(filePath.toString());

            AccountTable accountTable = new AccountTable();
            MFrame.MAIN_FRAME.setMainPane(accountTable);

            noteDialog.setVisible(false);

            TopMenuBar topMenuBar = (TopMenuBar) MFrame.MAIN_FRAME.getJMenuBar();
            topMenuBar.addOperationMenus();
        }
    }
}
