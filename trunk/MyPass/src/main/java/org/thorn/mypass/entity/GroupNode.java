package org.thorn.mypass.entity;

import java.util.ArrayList;
import java.util.List;

public class GroupNode {

    private Group node;
    
    private List<GroupNode> children = new ArrayList<GroupNode>();
    
    public GroupNode(String groupName) {
        node = new Group(groupName);
    }
    
    public GroupNode(Group node) {
        this.node = node;
    }
    
    public Group getNode() {
        return node;
    }

    public void setNode(Group node) {
        this.node = node;
    }

    public List<GroupNode> getChildren() {
        return children;
    }

    public void setChildren(List<GroupNode> children) {
        this.children = children;
    }
    
    public int getChindrenNumber() {
        return this.children.size();
    }
}
