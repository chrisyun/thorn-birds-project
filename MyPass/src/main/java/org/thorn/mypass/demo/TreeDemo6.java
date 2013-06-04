package org.thorn.mypass.demo;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.tree.*;

public class TreeDemo6 implements ActionListener,TreeModelListener
{
    JLabel label = null;
    JTree tree = null;
    DefaultTreeModel treeModel = null;
    String nodeName = null; //原有节点名称 
    
    public TreeDemo6()
    {
        JFrame f = new JFrame("TreeDemo");
        Container contentPane = f.getContentPane();
        
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("资源管理器");
        
        tree = new JTree(root);
        tree.setEditable(true);
        tree.addMouseListener(new MouseHandle());
        treeModel = (DefaultTreeModel)tree.getModel();
        treeModel.addTreeModelListener(this);
        
        JScrollPane scrollPane = new JScrollPane();
        scrollPane.setViewportView(tree);
        
        JPanel panel = new JPanel();
        JButton b = new JButton("新增节点");
        b.addActionListener(this);
        panel.add(b);
        b = new JButton("删除节点");
        b.addActionListener(this);
        panel.add(b);
        b = new JButton("清除有所节点");
        b.addActionListener(this);
        panel.add(b);
                
        label = new JLabel("Action");
        contentPane.add(panel,BorderLayout.NORTH);
        contentPane.add(scrollPane,BorderLayout.CENTER);
        contentPane.add(label,BorderLayout.SOUTH);
        f.pack();
        f.setVisible(true);
        
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

    }
    
    public void actionPerformed(ActionEvent ae)
    {
        if (ae.getActionCommand().equals("新增节点"))
        {
            DefaultMutableTreeNode parentNode = null;
            
            DefaultMutableTreeNode newNode = new DefaultMutableTreeNode("新节点");
            newNode.setAllowsChildren(true);
            TreePath parentPath = tree.getSelectionPath();

            parentNode = (DefaultMutableTreeNode)
                             (parentPath.getLastPathComponent());

            treeModel.insertNodeInto(newNode,parentNode,parentNode.getChildCount());
            tree.scrollPathToVisible(new TreePath(newNode.getPath()));
            
            label.setText("新增节点成功");
        }
        
        if (ae.getActionCommand().equals("删除节点"))
        {
            TreePath treepath = tree.getSelectionPath();
            if (treepath != null)
            {
                DefaultMutableTreeNode selectionNode = (DefaultMutableTreeNode)
                             treepath.getLastPathComponent();
                TreeNode parent = (TreeNode)selectionNode.getParent();
                if (parent != null)
                {
                    treeModel.removeNodeFromParent(selectionNode);
                    treeModel.reload();
                    label.setText("删除节点成功");
                }
            }
        }
        
        if (ae.getActionCommand().equals("清除所有节点"))
        {
            DefaultMutableTreeNode rootNode = (DefaultMutableTreeNode)treeModel.getRoot();
            rootNode.removeAllChildren();
            treeModel.reload();
            label.setText("清除所有节点成功");
        }
    }
    
    public void treeNodesChanged(TreeModelEvent e) {
        
        TreePath treePath = e.getTreePath();
        DefaultMutableTreeNode node = (DefaultMutableTreeNode)treePath.getLastPathComponent();
        try {
            int[] index = e.getChildIndices();
            node = (DefaultMutableTreeNode)node.getChildAt(index[0]);
        } catch (NullPointerException exc) {}
        label.setText(nodeName+" 更改数据为: "+(String)node.getUserObject());
    }
    public void treeNodesInserted(TreeModelEvent e) {
        System.out.println("new node inserted");
    }
    public void treeNodesRemoved(TreeModelEvent e) {
        System.out.println("node deleted");
    }
    public void treeStructureChanged(TreeModelEvent e) {
        System.out.println("structrue changed");
    }

    public static void main(String args[]) {
    
        new TreeDemo6();
    }
    
    class MouseHandle extends MouseAdapter
    {
        public void mousePressed(MouseEvent e) 
        {
            try{
                JTree tree = (JTree)e.getSource();
            
                int rowLocation = tree.getRowForLocation(e.getX(), e.getY());
                TreePath treepath = tree.getPathForRow(rowLocation);
                TreeNode treenode = (TreeNode) treepath.getLastPathComponent(); 
            
                nodeName = treenode.toString();
                System.out.println("click on:" + nodeName);
            }catch(NullPointerException ne){}
        }
    }
}


