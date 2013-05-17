package org.thorn.mypass;
import javax.swing.*;
import javax.swing.tree.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

public class TreeDemo7 implements TreeSelectionListener
{
    JEditorPane editorPane;

    public TreeDemo7()
    {
        JFrame f = new JFrame("TreeDemo");
        Container contentPane = f.getContentPane();
        DefaultMutableTreeNode root = new DefaultMutableTreeNode("资源管理器");
        DefaultMutableTreeNode node = new DefaultMutableTreeNode("TreeDemo1.java");
        root.add(node);
        node = new DefaultMutableTreeNode("TreeDemo2.java");
        root.add(node);
        node = new DefaultMutableTreeNode("TreeDemo3.java");
        root.add(node);
        node = new DefaultMutableTreeNode("TreeDemo4.java");
        root.add(node);
        
        JTree tree = new JTree(root);
        tree.getSelectionModel().setSelectionMode(
            TreeSelectionModel.SINGLE_TREE_SELECTION);
        tree.addTreeSelectionListener(this);

        JScrollPane scrollPane1 = new JScrollPane(tree);
        editorPane = new JEditorPane();
        JScrollPane scrollPane2 = new JScrollPane(editorPane);
        JSplitPane splitPane = new JSplitPane(
            JSplitPane.HORIZONTAL_SPLIT,true, scrollPane1, scrollPane2);

        contentPane.add(splitPane);
        f.pack();
        f.setVisible(true);
        
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
    }

    public void valueChanged(TreeSelectionEvent e)
    {
        JTree tree = (JTree) e.getSource(); 
        DefaultMutableTreeNode selectionNode =
            (DefaultMutableTreeNode)tree.getLastSelectedPathComponent();

        String nodeName = selectionNode.toString();
        
        if (selectionNode.isLeaf()) 
        {
            String filepath = "file:"+System.getProperty("user.dir") +
                               System.getProperty("file.separator") +
                               nodeName;
                           
            try {
                 editorPane.setPage(filepath);
            } catch(IOException ex) {
                 System.out.println("找不到此文件");
            }
        }
    }
    
    public static void main(String[] args) {
        new TreeDemo7();        
    }
}              

