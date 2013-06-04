package org.thorn.mypass.demo;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.tree.*;

public class TreeDemo5 implements TreeModelListener
{
    JLabel label = null;
    String nodeName = null; //原有节点名称
    
    public TreeDemo5()
    {
        JFrame f = new JFrame("TreeDemo");
        Container contentPane = f.getContentPane();
        
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("资源管理器");
        DefaultMutableTreeNode node1 = new DefaultMutableTreeNode("文件夹");
        DefaultMutableTreeNode node2 = new DefaultMutableTreeNode("我的电脑");
        DefaultMutableTreeNode node3 = new DefaultMutableTreeNode("收藏夹");
        DefaultMutableTreeNode node4 = new DefaultMutableTreeNode("Readme");
        root.add(node1);
        root.add(node2);
        root.add(node3);
        root.add(node4);
        
        DefaultMutableTreeNode leafnode = new DefaultMutableTreeNode("公司文件");
        node1.add(leafnode);
        leafnode = new DefaultMutableTreeNode("个人信件");
        node1.add(leafnode);
        leafnode = new DefaultMutableTreeNode("私人文件");
        node1.add(leafnode);
        
        leafnode = new DefaultMutableTreeNode("本机磁盘(C:)");
        node2.add(leafnode);
        leafnode = new DefaultMutableTreeNode("本机磁盘(D:)");
        node2.add(leafnode);
        leafnode = new DefaultMutableTreeNode("本机磁盘(E:)");
        node2.add(leafnode);
        
        DefaultMutableTreeNode node31 = new DefaultMutableTreeNode("网站列表");
        node3.add(node31);
        
        leafnode = new DefaultMutableTreeNode("天勤网站");
        node31.add(leafnode);
        leafnode = new DefaultMutableTreeNode("足球消息");
        node31.add(leafnode);
        leafnode = new DefaultMutableTreeNode("网络书店");
        node31.add(leafnode);
        
        JTree tree = new JTree(root);
        tree.setEditable(true);
        tree.addMouseListener(new MouseHandle());
        DefaultTreeModel treeModel = (DefaultTreeModel)tree.getModel();
        treeModel.addTreeModelListener(this);
        
        JScrollPane scrollPane = new JScrollPane();
        scrollPane.setViewportView(tree);
        
        label = new JLabel("更改数据为: ");
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
    
    public void treeNodesChanged(TreeModelEvent e) {
        
        TreePath treePath = e.getTreePath();
        System.out.println(treePath);
        DefaultMutableTreeNode node = (DefaultMutableTreeNode)treePath.getLastPathComponent();
        try {
            int[] index = e.getChildIndices();
            node = (DefaultMutableTreeNode)node.getChildAt(index[0]);
        } catch (NullPointerException exc) {}
        label.setText(nodeName+"更改数据为: "+(String)node.getUserObject());
    }
    public void treeNodesInserted(TreeModelEvent e) {
    }
    public void treeNodesRemoved(TreeModelEvent e) {
    }
    public void treeStructureChanged(TreeModelEvent e) {
    }

    public static void main(String args[]) {
    
        new TreeDemo5();
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
            }catch(NullPointerException ne){}
        }
    }
}


