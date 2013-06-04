package org.thorn.mypass.demo;
import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

public class SimpleTable2 {
     
    public SimpleTable2() {
    
   	JFrame f = new JFrame();
   	
        Object[][] p = {
            {"阿呆", new Integer(66), 
              new Integer(32), new Integer(98), new Boolean(false),new Boolean(false)},
            {"阿瓜", new Integer(85), 
              new Integer(69), new Integer(154), new Boolean(true),new Boolean(false)},          
        };

        String[] n = {"姓名", 
                      "国语",
                      "数学",
                      "总分",
                      "及格",
		      "作弊"};

	    TableColumn column = null;
        JTable table = new JTable(p, n);
        table.setPreferredScrollableViewportSize(new Dimension(550, 30));
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
        
        for (int i=0; i<6 ;i++)
        {
            column = table.getColumnModel().getColumn(i);
            if ((i % 2) == 0)
                column.setPreferredWidth(150);
            else
                column.setPreferredWidth(50);
        }
        
        //Create the scroll pane and add the table to it. 
        JScrollPane scrollPane = new JScrollPane(table);

        //Add the scroll pane to this window.
        f.getContentPane().add(scrollPane, BorderLayout.CENTER);
	    f.setTitle("Simple Table");
        f.pack();
        f.setVisible(true);
        
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

    }

    public static void main(String args[]) {
    
        new SimpleTable2();
    }
}

