package org.thorn.humpback.codebuilder.view;

import org.thorn.humpback.codebuilder.entity.JDBCTypesMapping;
import org.thorn.humpback.frame.action.OpenDialogAction;
import org.thorn.humpback.localpass.view.AccountTableModal;

import javax.swing.*;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumn;
import javax.swing.table.TableColumnModel;
import java.awt.*;

/**
 * @Author: yfchenyun
 * @Since: 13-9-17 下午4:06
 * @Version: 1.0
 */
public class MappingFieldPanel extends JPanel {

    private JTable table;

    public MappingFieldPanel() {
        this.setPreferredSize(new Dimension(580, 420));
        this.setBorder(BorderFactory.createTitledBorder(BorderFactory.createLineBorder(Color.BLUE), "第二步 配置字段映射（双击字段名及字段类型列进行修改）"));

        FieldMappingModal mappingModal = new FieldMappingModal();
        table = new JTable(mappingModal);

        TableColumnModel tableColumnModel = table.getColumnModel();
        TableColumn tableColumn = tableColumnModel.getColumn(4);

        JComboBox comboBox = new JComboBox(JDBCTypesMapping.JAVA_TYPES);
        DefaultCellEditor cellEditor = new DefaultCellEditor(comboBox);
        tableColumn.setCellEditor(cellEditor);

        JTableHeader header = table.getTableHeader();
        header.setPreferredSize(new Dimension(header.getWidth(), 25));
        table.setRowHeight(22);
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);

        JScrollPane tableScrollPanel = new JScrollPane(table);
        tableScrollPanel.setPreferredSize(new Dimension(560, 330));

        Box rowBox = Box.createVerticalBox();
        rowBox.add(tableScrollPanel);

        rowBox.add(Box.createVerticalStrut(10));

        Box columnBox = Box.createHorizontalBox();
        JButton button = new JButton("上一步");
        columnBox.add(button);
        columnBox.add(Box.createHorizontalStrut(30));
        button = new JButton("下一步");
        columnBox.add(button);

        rowBox.add(columnBox);
        this.add(rowBox);
    }
}
