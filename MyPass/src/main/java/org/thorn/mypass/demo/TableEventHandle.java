package org.thorn.mypass.demo;

import javax.swing.table.AbstractTableModel;
import javax.swing.event.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class TableEventHandle implements TableModelListener
{
    JTable table = null;
    MyTableOne mt = null;
    JLabel label = null; //显示修改字段位置

    public TableEventHandle() {

        JFrame f = new JFrame();
        mt=new MyTableOne();
        mt.addTableModelListener(this);

        table=new JTable(mt);

        JComboBox c = new JComboBox();
        c.addItem("Taipei");
        c.addItem("ChiaYi");
        c.addItem("HsinChu");
        table.getColumnModel().getColumn(1).setCellEditor(new DefaultCellEditor(c));

        table.setPreferredScrollableViewportSize(new Dimension(550, 30));
        JScrollPane s = new JScrollPane(table);

        label = new JLabel("修改字段位置：");
        f.getContentPane().add(s, BorderLayout.CENTER);
        f.getContentPane().add(label, BorderLayout.SOUTH);
        f.setTitle("TableEventHandle");
        f.pack();
        f.setVisible(true);

        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
    }

    public void tableChanged(TableModelEvent e)
    {
        int row = e.getFirstRow();
        int column = e.getColumn();
        label.setText("修改字段位置："+(row+1)+" 行 "+(column+1)+" 列");
        boolean cheat =((Boolean)(mt.getValueAt(row,6))).booleanValue();
        int grade1=((Integer)(mt.getValueAt(row,2))).intValue();
        int grade2=((Integer)(mt.getValueAt(row,3))).intValue();
        int total = grade1+grade2;
        if(cheat)
        {
            if(total > 120)
                mt.mySetValueAt(new Integer(119),row,4);
            else
                mt.mySetValueAt(new Integer(total),row,4);
            mt.mySetValueAt(new Boolean(false),row,5);
        }
        else
        {
            if(total > 120)
                mt.mySetValueAt(new Boolean(true),row,5);
            else
                mt.mySetValueAt(new Boolean(false),row,5);

            mt.mySetValueAt(new Integer(total),row,4);
        }
        table.repaint();
    }

    public static void main(String args[]) {

        new TableEventHandle();
    }
}

class MyTableOne extends AbstractTableModel {

    Object[][] p = {
            {"阿呆", "Taipei",new Integer(66), new Integer(32), new Integer(98),
                    new Boolean(false),new Boolean(false)},
            {"阿瓜", "ChiaYi",new Integer(85), new Integer(69), new Integer(154),
                    new Boolean(true),new Boolean(false)}};

    String[] n = {"姓名","居住地","语文","数学","总分","及格","作弊"};

    public int getColumnCount() {
        return n.length;
    }

    public int getRowCount() {
        return p.length;
    }

    public String getColumnName(int col) {
        return n[col];
    }

    public Object getValueAt(int row, int col) {
        return p[row][col];
    }

    public Class getColumnClass(int c) {
        return getValueAt(0, c).getClass();
    }

    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return true;
    }

    public void setValueAt(Object value, int row, int col) {
        p[row][col] = value;
        fireTableCellUpdated(row, col);
    }

    public void mySetValueAt(Object value, int row, int col) {
        p[row][col] = value;
    }
}



