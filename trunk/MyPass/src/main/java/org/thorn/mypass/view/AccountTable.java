package org.thorn.mypass.view;

import java.awt.Dimension;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

import org.thorn.mypass.listener.AccountTableListener;

public class AccountTable {

    private JTable table;

    private JPanel panel;

    public AccountTable() throws Exception {

        // init queryPanel
        panel = new JPanel();
        Box box = Box.createVerticalBox();
        panel.add(box);

        Box querybox = Box.createHorizontalBox();
        querybox.add(Box.createHorizontalStrut(5));
        querybox.add(new JLabel("网站地址："));
        JTextField websiteText = new JTextField();
        querybox.add(websiteText);
        querybox.add(Box.createHorizontalStrut(40));
        JButton btn = new JButton("查询");
        btn.addActionListener(new AccountTableListener(table, websiteText));
        querybox.add(btn);
        querybox.add(Box.createHorizontalStrut(100));
        box.add(querybox);
        box.add(Box.createVerticalStrut(5));

        // init table
        table = new JTable(new AccountTableModal(null, null));
        table.setPreferredScrollableViewportSize(new Dimension(560, 380));
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        JScrollPane tableScrollPanel = new JScrollPane(table);

        box.add(tableScrollPanel);
    }

    public JPanel getTablePanel() {
        return this.panel;
    }

}
