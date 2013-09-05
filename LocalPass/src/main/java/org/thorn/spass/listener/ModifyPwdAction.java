package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.spass.service.AccountService;
import org.thorn.spass.view.MFrame;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午5:47
 * @Version: 1.0
 */
public class ModifyPwdAction extends AbsAction {

    private JDialog modifyPwdDialog;

    private JPasswordField curPwdField;

    private JPasswordField newPwdField;

    private JPasswordField repeatPwdField;

    public ModifyPwdAction(JDialog modifyPwdDialog, JPasswordField curPwdField,
                           JPasswordField newPwdField, JPasswordField repeatPwdField) {
        super(modifyPwdDialog);
        this.modifyPwdDialog = modifyPwdDialog;
        this.curPwdField = curPwdField;
        this.newPwdField = newPwdField;
        this.repeatPwdField = repeatPwdField;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        String curPwd = String.copyValueOf(curPwdField.getPassword());
        String newPwd = String.copyValueOf(newPwdField.getPassword());
        String repeatPwd = String.copyValueOf(repeatPwdField.getPassword());

        if (StringUtils.isEmpty(curPwd)) {
            JOptionPane.showMessageDialog(modifyPwdDialog, "请输入当前密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(newPwd)) {
            JOptionPane.showMessageDialog(modifyPwdDialog, "请输入新密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(repeatPwd)) {
            JOptionPane.showMessageDialog(modifyPwdDialog, "请再次输入新密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (!StringUtils.equals(newPwd, repeatPwd)) {
            JOptionPane.showMessageDialog(modifyPwdDialog, "两次输入的新密码不一样", "错误", JOptionPane.WARNING_MESSAGE);
        } else {

            AccountService accountService = SpringContext.getBean(AccountService.class);

            if (accountService.verifyPassword(curPwd)) {
                accountService.modifyPassword(newPwd);

                modifyPwdDialog.setVisible(false);
                JOptionPane.showMessageDialog(MFrame.MAIN_FRAME, "密码修改成功", "成功", JOptionPane.INFORMATION_MESSAGE);
            } else {
                JOptionPane.showMessageDialog(modifyPwdDialog, "当前密码错误", "错误", JOptionPane.WARNING_MESSAGE);
            }
        }
    }
}
