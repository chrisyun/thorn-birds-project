package org.thorn.mypass.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.mypass.core.Configuration;
import org.thorn.mypass.core.Session;
import org.thorn.mypass.dao.GroupDAO;
import org.thorn.mypass.entity.Group;
import org.thorn.mypass.entity.GroupNode;
import org.thorn.mypass.entity.User;

@Service("groupService")
public class GroupService {
    
    @Autowired
    private GroupDAO groupDAO;
    
    public GroupNode getGroupTree() throws Exception {
        
        GroupNode root = new GroupNode(Configuration.GROUP_ROOT_NAME);
        
        Session session = Session.getCurrentSession();
        User user = session.getUser();
        
        List<Group> groups = groupDAO.getGroupByUserAndVersion(user.getUsername(), user.getUsedVersion());
        findChildren(root, groups);
        
        return root;
    }
    
    public void addGroup(Group group) throws DBAccessException {
        
        try {
            Session session = Session.getCurrentSession();
            User user = session.getUser();
            
            group.setUsername(user.getUsername());
            group.setVersion(user.getUsedVersion());
            
            groupDAO.saveGroup(group);
        } catch (Exception e) {
            throw new DBAccessException(e);
        }
    }
    
    public void modifyGroup(Group group) throws DBAccessException {
        
        try {
            Session session = Session.getCurrentSession();
            User user = session.getUser();
            
            group.setUsername(user.getUsername());
            group.setVersion(user.getUsedVersion());
            
            groupDAO.modifyGroup(group);
        } catch (Exception e) {
            throw new DBAccessException(e);
        }
    }
    
    public void deleteGroup(Group group) throws DBAccessException {
        try {
            groupDAO.deleteGroup(group.getId());
        } catch (Exception e) {
            throw new DBAccessException(e);
        }
    }
    
    private void findChildren(GroupNode parent, List<Group> groups) {
        
        for(Group group : groups) {
            if(StringUtils.equals(parent.getNode().getName(), group.getPname())) {
                parent.getChildren().add(new GroupNode(group));
            }
        }
        
        if(parent.getChindrenNumber() > 0) {
            for(GroupNode child : parent.getChildren()) {
                findChildren(child, groups);
            }
        }
    }
    
}
