package org.thorn.mypass.view;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;
import javax.swing.JTree;
import javax.swing.border.BevelBorder;
import javax.swing.event.PopupMenuEvent;
import javax.swing.event.PopupMenuListener;
import javax.swing.event.TreeModelEvent;
import javax.swing.event.TreeModelListener;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

public class GroupPanel extends MouseAdapter implements ActionListener, TreeModelListener, TreeSelectionListener {

    private JTree tree;

    private JPanel panel;
    
    private JPopupMenu popMenu;
    
    private JButton getButton(String text) {
	JButton b = new JButton(text);
	b.addActionListener(this);
	return b;
    }

    private JMenuItem getJMenuItem(String text) {
	JMenuItem item = new JMenuItem(text);
	item.addActionListener(this);
	return item;
    }

    public GroupPanel() {

	// init tree
	DefaultMutableTreeNode root = new DefaultMutableTreeNode("The group");
	root.add(new DefaultMutableTreeNode("Mail"));
	root.add(new DefaultMutableTreeNode("Blog"));

	tree = new JTree(root);
	tree.setEditable(true);
	tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
	JScrollPane treeScrollPane1 = new JScrollPane(tree);

	tree.addTreeSelectionListener(this);
	tree.addMouseListener(this);
	tree.getModel().addTreeModelListener(this);

	popMenu = new JPopupMenu();
	popMenu.add(getJMenuItem("Add group"));
	popMenu.addSeparator();
	popMenu.add(getJMenuItem("Modify group"));
	popMenu.addSeparator();
	popMenu.add(getJMenuItem("Delete group"));
	popMenu.setBorder(BorderFactory.createLineBorder(Color.BLACK));
	
	
	Box btnbox = Box.createHorizontalBox();
	btnbox.add(getButton("Add"));
	btnbox.add(getButton("Modify"));
	btnbox.add(getButton("Delete"));

	// init panel
	panel = new JPanel();
	Box box = Box.createVerticalBox();
	panel.add(box);
	box.add(btnbox);
	box.add(Box.createVerticalStrut(2));
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

    @Override
    public void mousePressed(MouseEvent e) {
	TreePath path = tree.getPathForLocation(e.getX(), e.getY());
	
	if(path != null && e.getButton() == 3) {
	    popMenu.show(tree, e.getX(), e.getY());
	}
	
    }

    
}
