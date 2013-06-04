package org.thorn.mypass.view;

import java.util.List;

import javax.swing.table.AbstractTableModel;

import org.thorn.mypass.entity.Website;
import org.thorn.mypass.service.ServiceFactory;
import org.thorn.mypass.service.WebsiteService;

public class AccountTableModal extends AbstractTableModel {

    private static final String[] HEANDER = { "网站地址", "账号", "备注", "所在分组" };

    private List<Website> data;
    
    public AccountTableModal(String groupName, String websitename) throws Exception {

        WebsiteService wsService = ServiceFactory.getInstance().getWebsiteService();
        data = wsService.queryWebsite(groupName, websitename);
    }

    public int getRowCount() {
        return data.size();
    }

    public int getColumnCount() {
        return HEANDER.length;
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Website ws = data.get(rowIndex);
        
        Object value = null;
        
        switch (columnIndex) {
        case 0:
            value = ws.getWebsite();
            break;
        case 1:
            value = ws.getAccount();
            break;
        case 2:
            value = ws.getDescription();
            break;
        case 3:
            value = ws.getGroupName();
            break;

        default:
            value = ws.getWebsite();
            break;
        }
        
        return value;
    }

    @Override
    public String getColumnName(int column) {
        return HEANDER[column];
    }

}
