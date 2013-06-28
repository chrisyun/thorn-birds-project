package org.thorn.mypass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.mypass.view.AccountTable;
import org.thorn.mypass.view.AccountTableModal;
import org.thorn.mypass.view.GroupPanel;

import java.awt.event.ActionEvent;

import javax.swing.JTextField;

public class AccountTableListener extends AbstractListener {

    @Override
    public void action(ActionEvent e) throws Exception {

        AccountTable table = (AccountTable) e.getSource();

        String command = e.getActionCommand();

        if(StringUtils.equals(command, AccountTable.BTN_QUERY)) {
            table.getTable().setModel(new AccountTableModal(GroupPanel.selectedGroupName, table.getQueryWebSite()));
        } else if(StringUtils.equals(command, AccountTable.BTN_ADD)) {

        }  else if(StringUtils.equals(command, AccountTable.TREE_QUERY)) {
            table.getTable().setModel(new AccountTableModal(GroupPanel.selectedGroupName, null));
        }

    }

}
