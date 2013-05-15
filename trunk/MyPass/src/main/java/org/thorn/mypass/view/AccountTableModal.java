package org.thorn.mypass.view;

import javax.swing.table.AbstractTableModel;

public class AccountTableModal extends AbstractTableModel {
    
    private static final String[] HEANDER = {"Website", "Account", "Password", "Descriptor"};
    
    private String[][] data = {
	    {"www.163.com", "chenyun", "123466", "mail"},
	    {"www.123.com", "chris", "123466", "mail"},
    };
    
    public int getRowCount() {
	return data.length;
    }

    public int getColumnCount() {
	return HEANDER.length;
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
	return data[rowIndex][columnIndex];
    }

    @Override
    public String getColumnName(int column) {
	return HEANDER[column];
    }
    
    

}
