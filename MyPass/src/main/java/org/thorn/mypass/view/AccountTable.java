package org.thorn.mypass.view;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

import org.thorn.mypass.listener.AbstractListener;
import org.thorn.mypass.listener.AccountTableListener;

public class AccountTable {

    private JTable table;

    private JPanel panel;

    private JTextField websiteText;

    public static final String BTN_QUERY = "查询";

    public static final String BTN_ADD = "新增";

    public static final String TREE_QUERY = "按组查询";

    public AccountTable() throws Exception {

        // init queryPanel
        panel = new JPanel();
        Box box = Box.createVerticalBox();
        panel.add(box);

        Box queryBox = Box.createHorizontalBox();
        queryBox.add(Box.createHorizontalStrut(5));
        queryBox.add(new JLabel("网站地址："));
        websiteText = new JTextField();
        queryBox.add(websiteText);
        queryBox.add(Box.createHorizontalStrut(40));
        JButton btn = new JButton(BTN_QUERY);

        final AccountTable thisObj = this;
        btn.addActionListener(new AbstractListener() {

            @Override
            public void action(ActionEvent e) throws Exception {
                e.setSource(thisObj);
                new AccountTableListener().actionPerformed(e);
            }
        });
        queryBox.add(btn);
        queryBox.add(Box.createHorizontalStrut(100));
        box.add(queryBox);
        box.add(Box.createVerticalStrut(5));

        // init table
        table = new JTable(new AccountTableModal(null, null));
        table.setPreferredScrollableViewportSize(new Dimension(560, 380));
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        JScrollPane tableScrollPanel = new JScrollPane(table);

        box.add(tableScrollPanel);
    }

    public JTable getTable() {
        return table;
    }

    public JPanel getTablePanel() {
        return panel;
    }

    public String getQueryWebSite() {
        return websiteText.getText();
    }
}
