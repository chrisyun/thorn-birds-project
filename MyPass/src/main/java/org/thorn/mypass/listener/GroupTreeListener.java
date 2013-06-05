package org.thorn.mypass.listener;

import java.awt.event.ActionEvent;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JTree;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreePath;

import org.apache.commons.lang.StringUtils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.mypass.entity.Group;
import org.thorn.mypass.service.GroupService;
import org.thorn.mypass.service.ServiceFactory;
import org.thorn.mypass.view.ComponentReference;
import org.thorn.mypass.view.GroupPanel;

public class GroupTreeListener extends AbstractListener {

    private JTree tree;

    private JFrame frame = ComponentReference.getMainFrame();

    public GroupTreeListener(JTree tree) {
        this.tree = tree;
    }

    private void addGroup(DefaultMutableTreeNode selectionNode, Group thisGroup, DefaultTreeModel model,
                          GroupService groupService) throws DBAccessException {
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
    }

    private void modifyGroup(DefaultMutableTreeNode selectionNode, Group thisGroup, GroupService groupService)
            throws DBAccessException {
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
    }

    private void deleteGroup(DefaultMutableTreeNode selectionNode, Group thisGroup, DefaultTreeModel model,
                             GroupService groupService)
            throws DBAccessException {
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

    @Override
    public void action(ActionEvent e) throws Exception {
        String commond = e.getActionCommand();

        TreePath parentPath = tree.getSelectionPath();
        DefaultMutableTreeNode selectionNode = (DefaultMutableTreeNode)
                (parentPath.getLastPathComponent());

        if (selectionNode == null) {
            JOptionPane.showMessageDialog(frame, "请选择一个分组！", "错误",
                    JOptionPane.WARNING_MESSAGE);
            return;
        } else if (selectionNode.isRoot() && !StringUtils.equals(commond, GroupPanel.ACTION_ADD)) {
            JOptionPane.showMessageDialog(frame, "该分组不允许修改和删除！", "错误",
                    JOptionPane.WARNING_MESSAGE);
            return;
        }

        Group thisGroup = (Group) selectionNode.getUserObject();
        DefaultTreeModel model = (DefaultTreeModel) tree.getModel();
        GroupService groupService = ServiceFactory.getInstance().getGroupService();

        if (StringUtils.equals(commond, GroupPanel.ACTION_ADD)) {
            addGroup(selectionNode, thisGroup, model, groupService);
        } else if (StringUtils.equals(commond, GroupPanel.ACTION_MODIFY)) {
            modifyGroup(selectionNode, thisGroup, groupService);
        } else if (StringUtils.equals(commond, GroupPanel.ACTION_DELETE)) {
            deleteGroup(selectionNode, thisGroup, model, groupService);
        }

    }

}
