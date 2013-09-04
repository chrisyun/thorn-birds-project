package org.thorn.spass.view;

import org.thorn.core.context.SpringContext;
import org.thorn.spass.listener.OpenAccountDialogAction;
import org.thorn.spass.listener.OpenAccountDialogListener;
import org.thorn.spass.listener.TagSearchAction;
import org.thorn.spass.service.AccountService;

import javax.swing.*;
import java.awt.*;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-9-3 下午4:14
 * @Version: 1.0
 */
public class AccountTable extends JPanel {

    private JTable table;

    public AccountTable() throws Exception {

        JPanel queryPanel = new JPanel();
        queryPanel.setBorder(BorderFactory.createEmptyBorder(3, 5, 3, 5));

        AccountService accountService = SpringContext.getBean(AccountService.class);
        Set<String> tagSet = accountService.queryTags();

        if (tagSet != null && tagSet.size() > 0) {

            JPanel tagPanel = new JPanel();
            tagPanel.setLayout(new GridLayout(tagSet.size() / 3, 3));
            tagPanel.setBorder(BorderFactory.createTitledBorder("标签"));

            for (String tag : tagSet) {
                JCheckBox checkBox = new JCheckBox(tag);

                checkBox.addItemListener(new TagSearchAction(this));
                tagPanel.add(checkBox);
            }

            queryPanel.add(tagPanel);
        }


        Box columnBox = Box.createHorizontalBox();
        JButton button = new JButton("添 加");
        button.addActionListener(new OpenAccountDialogAction());
        columnBox.add(Box.createHorizontalStrut(450));
        columnBox.add(button);
        queryPanel.add(columnBox);

        table = new JTable(new AccountTableModal(null));
        table.setPreferredScrollableViewportSize(new Dimension(590, 330));
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        // set table double click
        table.setColumnSelectionAllowed(false);
        table.setRowSelectionAllowed(true);
        JScrollPane tableScrollPanel = new JScrollPane(table);

        table.addMouseListener(new OpenAccountDialogListener(table));

        Box rowBox = Box.createVerticalBox();
        rowBox.add(queryPanel);
        rowBox.add(Box.createVerticalStrut(5));
        rowBox.add(tableScrollPanel);

        this.add(rowBox);
    }

    public void query(Set<String> tags) throws Exception {
        table.setModel(new AccountTableModal(tags));
    }
}
