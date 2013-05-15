package org.thorn.mypass.view;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTree;
import javax.swing.event.TreeModelEvent;
import javax.swing.event.TreeModelListener;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreeSelectionModel;

public class GroupPanel implements ActionListener, TreeModelListener, TreeSelectionListener {
    
    private JTree tree;
    
    private JPanel panel;
    
    private JButton getButton(String text) {
	JButton b = new JButton(text);
        b.addActionListener(this);
        return b;
    }
    
    public GroupPanel() {
	
	// init tree
	DefaultMutableTreeNode root = new DefaultMutableTreeNode("The group");
	tree = new JTree(root);
        tree.setEditable(true);
        tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
        JScrollPane treeScrollPane1 = new JScrollPane(tree);
        
        tree.addTreeSelectionListener(this);
        tree.getModel().addTreeModelListener(this);
        
        Box btnbox = Box.createHorizontalBox();
        btnbox.add(getButton("Add"));
        btnbox.add(getButton("Modify"));
        btnbox.add(getButton("Delete"));
        
        // init panel
        panel = new JPanel();
        Box box = Box.createVerticalBox();
        panel.add(box);
        box.add(btnbox);
        box.add(treeScrollPane1);
    }
    
    public JPanel getGroupPanel() {
	return this.panel;
    }
    
    
    public void treeNodesChanged(TreeModelEvent e) {
	// TODO Auto-generated method stub
	
    }

    public void treeNodesInserted(TreeModelEvent e) {
	// TODO Auto-generated method stub
	
    }

    public void treeNodesRemoved(TreeModelEvent e) {
	// TODO Auto-generated method stub
	
    }

    public void treeStructureChanged(TreeModelEvent e) {
	// TODO Auto-generated method stub
	
    }

    public void actionPerformed(ActionEvent e) {
	// TODO Auto-generated method stub
	
    }

    public void valueChanged(TreeSelectionEvent e) {
	// TODO Auto-generated method stub
	
    }
    
}
