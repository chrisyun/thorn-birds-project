package org.thorn.mypass.view;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

public class AccountTable implements ActionListener {
    
    private JTextField websiteText;
    
    private JTable table;
    
    private JPanel panel;
    
    public AccountTable() {
	
	// init queryPanel
	panel = new JPanel();
	Box box = Box.createVerticalBox();
	panel.add(box);
	
	Box querybox = Box.createHorizontalBox();
	querybox.add(Box.createHorizontalStrut(5));
	querybox.add(new JLabel("WebSite:"));
	websiteText = new JTextField();
	querybox.add(websiteText);
	querybox.add(Box.createHorizontalStrut(40));
	JButton btn = new JButton("Query");
	btn.addActionListener(this);
	querybox.add(btn);
	querybox.add(Box.createHorizontalStrut(100));
	box.add(querybox);
	box.add(Box.createVerticalStrut(5));
	
	// init table
	table = new JTable(new AccountTableModal());
        table.setPreferredScrollableViewportSize(new Dimension(530, 380));
        table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
	JScrollPane tableScrollPanel = new JScrollPane(table);
	
	box.add(tableScrollPanel);
    }

    public void actionPerformed(ActionEvent e) {
	// TODO Auto-generated method stub
	
    }
    
    public JPanel getTablePanel() {
	return this.panel;
    }
    
}
