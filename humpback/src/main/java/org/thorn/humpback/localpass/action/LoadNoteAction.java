package org.thorn.humpback.localpass.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.frame.view.TopMenuBar;
import org.thorn.humpback.localpass.service.AccountService;
import org.thorn.humpback.localpass.service.LocationService;
import org.thorn.humpback.localpass.view.AccountTable;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午3:43
 * @Version: 1.0
 */
public class LoadNoteAction extends AbsAction {

    private JTextField file;

    private JPasswordField passwordField;

    private JDialog noteDialog;

    public LoadNoteAction(JDialog noteDialog, JTextField file, JPasswordField passwordField) {
        super(noteDialog);
        this.noteDialog = noteDialog;
        this.file = file;
        this.passwordField = passwordField;
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
                accountService.loadNote(filePath, pwd);

                LocationService locationService = SpringContext.getBean(LocationService.class);
                locationService.addOpenedNote(filePath);

                AccountTable accountTable = new AccountTable();
                Context.MAIN_FRAME.setMainPane(accountTable);

                noteDialog.setVisible(false);

                TopMenuBar topMenuBar = (TopMenuBar) Context.MAIN_FRAME.getJMenuBar();
                topMenuBar.addOperationMenus();
            }
        }
    }
}
