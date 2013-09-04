package org.thorn.spass.listener;

import org.thorn.core.context.SpringContext;
import org.thorn.spass.entity.Account;
import org.thorn.spass.service.AccountService;
import org.thorn.spass.view.AccountDialog;

import javax.swing.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午2:07
 * @Version: 1.0
 */
public class OpenAccountDialogListener extends MouseAdapter {

    private JTable table;

    public OpenAccountDialogListener(JTable table) {
        this.table = table;
    }

    @Override
    public void mouseClicked(MouseEvent e) {

        if(e.getClickCount() == 2) {
            int idNum = 4;
            int rowNum = table.getSelectedRow();

            String id = (String) table.getModel().getValueAt(rowNum, idNum);

            AccountService accountService = SpringContext.getBean(AccountService.class);

            Account account = accountService.queryAccount(id);

            AccountDialog dialog = new AccountDialog(account);
        }
    }



}
