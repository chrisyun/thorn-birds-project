package org.thorn.humpback.localpass.view;

import org.thorn.core.context.SpringContext;
import org.thorn.humpback.localpass.action.OpenAccountDialogListener;
import org.thorn.humpback.localpass.action.TagSearchAction;
import org.thorn.humpback.localpass.service.AccountService;

import javax.swing.*;
import javax.swing.table.JTableHeader;
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
        queryPanel.setBorder(BorderFactory.createTitledBorder("根据标签查询"));

        AccountService accountService = SpringContext.getBean(AccountService.class);
        Set<String> tagSet = accountService.queryTags();

        if (tagSet != null && tagSet.size() > 0) {

            JPanel tagPanel = new JPanel();
            tagPanel.setPreferredSize(new Dimension(570, 60));
            tagPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
            for (String tag : tagSet) {
                JCheckBox checkBox = new JCheckBox(tag);
                checkBox.addItemListener(new TagSearchAction(this));
                tagPanel.add(checkBox);
            }

            queryPanel.add(tagPanel);
        }

        table = new JTable(new AccountTableModal(null));
        JTableHeader header = table.getTableHeader();
        header.setPreferredSize(new Dimension(header.getWidth(), 25));
        table.setRowHeight(22);
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        // set table double click
        table.setColumnSelectionAllowed(false);
        table.setRowSelectionAllowed(true);
        table.addMouseListener(new OpenAccountDialogListener(table));
        JScrollPane tableScrollPanel = new JScrollPane(table);
        tableScrollPanel.setPreferredSize(new Dimension(590, 300));

        Box rowBox = Box.createVerticalBox();
        JScrollPane jScrollPane = new JScrollPane(queryPanel);
        jScrollPane.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
        rowBox.add(jScrollPane);
        rowBox.add(Box.createVerticalStrut(5));
        rowBox.add(tableScrollPanel);

        this.add(rowBox);
        this.setBorder(BorderFactory.createEmptyBorder(2, 2, 2, 2));
    }

    public void query(Set<String> tags) throws Exception {
        table.setModel(new AccountTableModal(tags));
    }
}
