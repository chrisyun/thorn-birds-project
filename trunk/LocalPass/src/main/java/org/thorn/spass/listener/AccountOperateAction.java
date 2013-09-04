package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.spass.entity.Account;
import org.thorn.spass.enums.AccountOperateEnum;
import org.thorn.spass.service.AccountService;
import org.thorn.spass.view.AccountDialog;
import org.thorn.spass.view.AccountTable;
import org.thorn.spass.view.MFrame;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午2:46
 * @Version: 1.0
 */
public class AccountOperateAction extends AbsAction {

    private AccountDialog dialog;

    private AccountOperateEnum operateEnum;

    public AccountOperateAction(AccountDialog dialog, AccountOperateEnum operateEnum) {
        super(dialog);
        this.dialog = dialog;
        this.operateEnum = operateEnum;
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        Account account = dialog.getFormData();

        if (StringUtils.isEmpty(account.getAddress()) && operateEnum != AccountOperateEnum.DELETE) {
            JOptionPane.showMessageDialog(dialog, "请输入地址", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(account.getUsername()) && operateEnum != AccountOperateEnum.DELETE) {
            JOptionPane.showMessageDialog(dialog, "请输入账号", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(account.getPassword()) && operateEnum != AccountOperateEnum.DELETE) {
            JOptionPane.showMessageDialog(dialog, "请输入密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            AccountService accountService = SpringContext.getBean(AccountService.class);

            if(operateEnum == AccountOperateEnum.DELETE) {
                accountService.deleteAccount(account);
            } else if(operateEnum == AccountOperateEnum.MODIFY) {
                accountService.modifyAccount(account);
            } else {
                accountService.addAccount(account);
            }

            dialog.setVisible(false);

            AccountTable accountTable = new AccountTable();
            MFrame.MAIN_FRAME.setMainPane(accountTable);
        }

    }
}
