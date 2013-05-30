package org.thorn.mypass.view;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;
import javax.swing.JTree;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.mypass.core.Configuration;
import org.thorn.mypass.entity.Group;
import org.thorn.mypass.entity.GroupNode;
import org.thorn.mypass.service.GroupService;

public class GroupPanel extends AbstractListener implements ActionListener, TreeSelectionListener {

    private JTree tree;

    private JPanel panel;

    private JPopupMenu popMenu;

    private static final String ACTION_ADD = "ADD";

    private static final String ACTION_MODIFY = "MODIFY";

    private static final String ACTION_DELETE = "DELETE";

    private DefaultMutableTreeNode selectionNode;

    private JButton getButton(String text, String commond) {
        JButton b = new JButton(text);
        b.addActionListener(this);
        b.setActionCommand(commond);
        return b;
    }

    private JMenuItem getJMenuItem(String text, String commond) {
        JMenuItem item = new JMenuItem(text);
        item.addActionListener(this);
        item.setActionCommand(commond);
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

        GroupService groupService = SpringContext.getBean("groupService");
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

        popMenu = new JPopupMenu();
        popMenu.add(getJMenuItem("添加分组", ACTION_ADD));
        popMenu.addSeparator();
        popMenu.add(getJMenuItem("修改分组", ACTION_MODIFY));
        popMenu.addSeparator();
        popMenu.add(getJMenuItem("删除分组", ACTION_DELETE));
        popMenu.setBorder(BorderFactory.createLineBorder(Color.BLACK));

        Box btnbox = Box.createHorizontalBox();
        btnbox.add(getButton("添加", ACTION_ADD));
        btnbox.add(getButton("修改", ACTION_MODIFY));
        btnbox.add(getButton("删除", ACTION_DELETE));

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
        selectionNode = (DefaultMutableTreeNode) tree.getLastSelectedPathComponent();

        if (selectionNode != null) {
            Group selectedNode = (Group) selectionNode.getUserObject();
            // TODO do query

        }
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        String commond = e.getActionCommand();

        JFrame frame = ComponentReference.getMainFrame();

        if (selectionNode == null) {
            JOptionPane.showMessageDialog(frame, "请选择一个分组！", "错误",
                    JOptionPane.WARNING_MESSAGE);
            return;
        } else if (selectionNode.isRoot() && !StringUtils.equals(commond, ACTION_ADD)) {
            JOptionPane.showMessageDialog(frame, "该分组不允许修改和删除！", "错误",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        Group thisGroup = (Group) selectionNode.getUserObject();
        DefaultTreeModel model = (DefaultTreeModel) tree.getModel();
        GroupService groupService = SpringContext.getBean("groupService");

        if (StringUtils.equals(commond, ACTION_ADD)) {
            String result = JOptionPane.showInputDialog(frame, "请输入分组名称：", "添加分组",
                    JOptionPane.INFORMATION_MESSAGE);

            if (StringUtils.isNotBlank(result)) {
                result = result.trim();

                Group node = new Group(result, thisGroup.getName());

                groupService.addGroup(node);

                DefaultMutableTreeNode treeNode = new DefaultMutableTreeNode(node);
                model.insertNodeInto(treeNode, selectionNode, selectionNode.getChildCount());
                tree.scrollPathToVisible(new TreePath(treeNode.getPath()));
            }
        } else if (StringUtils.equals(commond, ACTION_MODIFY)) {
            String name = thisGroup.getName();
            String modifyName = (String) JOptionPane.showInputDialog(frame, "请输入新的分组名称：",
                    "修改分组",
                    JOptionPane.INFORMATION_MESSAGE, null, null, name);

            if (StringUtils.isNotBlank(modifyName) && !StringUtils.equals(name, modifyName)) {
                modifyName = modifyName.trim();
                thisGroup.setName(modifyName);

                // modify node
                groupService.modifyGroup(thisGroup);

                selectionNode.setUserObject(thisGroup);
                tree.updateUI();
            }

        } else if (StringUtils.equals(commond, ACTION_DELETE)) {

            if (!selectionNode.isLeaf()) {
                JOptionPane.showMessageDialog(frame, "请先删除该分组下面的分组", "错误",
                        JOptionPane.WARNING_MESSAGE);
                return;
            }

            int result = JOptionPane.showConfirmDialog(frame, "是否确认删除该分组？", "删除确认",
                    JOptionPane.YES_NO_OPTION,
                    JOptionPane.INFORMATION_MESSAGE);
            if (result == JOptionPane.YES_OPTION) {

                // delete
                groupService.deleteGroup(thisGroup);

                model.removeNodeFromParent(selectionNode);
                selectionNode = null;
            }
        }
    }

}
