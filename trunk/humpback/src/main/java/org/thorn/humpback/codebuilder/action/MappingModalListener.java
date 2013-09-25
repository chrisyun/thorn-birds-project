package org.thorn.humpback.codebuilder.action;

import javax.swing.*;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

/**
 * @Author: yfchenyun
 * @Since: 13-9-22 上午10:34
 * @Version: 1.0
 */
public class MappingModalListener implements TableModelListener {

    private JTable jTable;

    public MappingModalListener(JTable jTable) {
        this.jTable = jTable;
    }

    @Override
    public void tableChanged(TableModelEvent e) {
        int row = e.getFirstRow();
        int column = e.getColumn();

        Object value = jTable.getModel().getValueAt(row, column);
        jTable.getModel().setValueAt(value, row, column);
        jTable.repaint();
    }
}
