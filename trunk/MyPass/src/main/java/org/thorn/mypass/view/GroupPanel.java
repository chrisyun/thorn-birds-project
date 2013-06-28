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
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

import org.thorn.mypass.core.Configuration;
import org.thorn.mypass.entity.Group;
import org.thorn.mypass.entity.GroupNode;
import org.thorn.mypass.listener.GroupTreeListener;
import org.thorn.mypass.service.GroupService;
import org.thorn.mypass.service.ServiceFactory;

public class GroupPanel implements TreeSelectionListener {

    public static String selectedGroupName = "";

    public static final String ACTION_ADD = "ADD";

    public static final String ACTION_MODIFY = "MODIFY";

    public static final String ACTION_DELETE = "DELETE";

    public static final String ACTION_CLICK = "TREE_QUERY";

    private JTree tree;

    private JPanel panel;

    private JPopupMenu popMenu;

    private ActionListener clickListener;

    private Object source;

    private String queryCommand;

    private JButton getButton(String text, String command, ActionListener listener) {
        JButton b = new JButton(text);
        b.addActionListener(listener);
        b.setActionCommand(command);
        return b;
    }

    private JMenuItem getJMenuItem(String text, String command, ActionListener listener) {
        JMenuItem item = new JMenuItem(text);
        item.addActionListener(listener);
        item.setActionCommand(command);
        return item;
    }

    private void addTreeLeaves(GroupNode parentNode, DefaultMutableTreeNode parent) {

        if (parentNode.getChindrenNumber() > 0) {
            for (GroupNode node : parentNode.getChildren()) {
                DefaultMutableTreeNode leaf = new DefaultMutableTreeNode(node.getNode());
                parent.add(leaf);

                addTreeLeaves(node, leaf);
            }
        }
    }

    public GroupPanel() throws Exception {

        // init tree
        DefaultMutableTreeNode root = new DefaultMutableTreeNode(new Group(Configuration.GROUP_ROOT_NAME));

        GroupService groupService = ServiceFactory.getInstance().getGroupService();
        GroupNode rootNode = groupService.getGroupTree();
        addTreeLeaves(rootNode, root);

        root.setUserObject(new Group(Configuration.GROUP_ROOT_SHOW_NAME));

        tree = new JTree(root);
        tree.setEditable(false);
        tree.getSelectionModel().setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
        JScrollPane treeScrollPane1 = new JScrollPane(tree);

        tree.addTreeSelectionListener(this);
        tree.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                TreePath path = tree.getPathForLocation(e.getX(), e.getY());

                if (path != null && e.getButton() == 3) {
                    popMenu.show(tree, e.getX(), e.getY());
                }
            }
        });

        ActionListener listener = new GroupTreeListener(tree);

        popMenu = new JPopupMenu();
        popMenu.add(getJMenuItem("添加分组", ACTION_ADD, listener));
        popMenu.addSeparator();
        popMenu.add(getJMenuItem("修改分组", ACTION_MODIFY, listener));
        popMenu.addSeparator();
        popMenu.add(getJMenuItem("删除分组", ACTION_DELETE, listener));
        popMenu.setBorder(BorderFactory.createLineBorder(Color.BLACK));

        Box btnbox = Box.createHorizontalBox();
        btnbox.add(getButton("添加", ACTION_ADD, listener));
        btnbox.add(getButton("修改", ACTION_MODIFY, listener));
        btnbox.add(getButton("删除", ACTION_DELETE, listener));

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

    public void valueChanged(TreeSelectionEvent e) {
        JTree tree = (JTree) e.getSource();
        DefaultMutableTreeNode selectionNode = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();

        if (selectionNode != null) {
            Group selectedNode = (Group) selectionNode.getUserObject();

            // set current groupName
            selectedGroupName = selectedNode.getName();

            // do query
            ActionEvent ae = new ActionEvent(source, 13, queryCommand);
            clickListener.actionPerformed(ae);
        }
    }


    public void registerClickListener(ActionListener listener, Object source, String command) {
        this.clickListener = listener;
        this.queryCommand = command;
        this.source = source;
    }

}
