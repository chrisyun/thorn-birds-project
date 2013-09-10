package org.thorn.spass.view;

import org.thorn.core.context.SpringContext;
import org.thorn.spass.entity.Account;
import org.thorn.spass.service.AccountService;

import javax.swing.table.AbstractTableModel;
import java.util.List;
import java.util.Set;

public class AccountTableModal extends AbstractTableModel {

    private static final String[] HEADER = {"网站地址", "账号", "标签"};

    private List<Account> data;

    public AccountTableModal(Set<String> tags) throws Exception {

        AccountService accountService = SpringContext.getBean(AccountService.class);
        data = accountService.queryAccounts(tags);
    }

    public int getRowCount() {
        return data.size();
    }

    public int getColumnCount() {
        return HEADER.length;
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Account account = data.get(rowIndex);

        Object value = null;

        switch (columnIndex) {
            case 0:
                value = account.getAddress();
                break;
            case 1:
                value = account.getUsername();
                break;
            case 2:
                Set<String> tags = account.getTag();
                StringBuilder stringBuilder = new StringBuilder();
                for(String tag : tags) {
                    stringBuilder.append(tag).append("#");
                }

                value = stringBuilder.toString();
                break;
            case 3:
                value = account.getRemark();
                break;

            default:
                value = account.getId();
                break;
        }

        return value;
    }

    @Override
    public String getColumnName(int column) {
        return HEADER[column];
    }

}
