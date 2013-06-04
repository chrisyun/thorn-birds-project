package org.thorn.mypass.listener;

import java.awt.event.ActionEvent;

import javax.swing.JTable;
import javax.swing.JTextField;

public class AccountTableListener extends AbstractListener {
    
    private JTextField websiteText;
    
    private JTable table;
    
    public AccountTableListener(JTable table, JTextField websiteText) {
        this.websiteText = websiteText;
        this.table = table;
    }
    
    @Override
    public void action(ActionEvent e) throws Exception {
        // TODO Auto-generated method stub

    }

}
