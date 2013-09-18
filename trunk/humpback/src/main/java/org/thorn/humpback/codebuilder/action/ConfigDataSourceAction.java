package org.thorn.humpback.codebuilder.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.humpback.codebuilder.entity.DBConfig;
import org.thorn.humpback.codebuilder.service.DBOperator;
import org.thorn.humpback.codebuilder.view.DBConfigDialog;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.beans.PropertyVetoException;

/**
 * @Author: yfchenyun
 * @Since: 13-9-18 下午1:29
 * @Version: 1.0
 */
public class ConfigDataSourceAction extends AbsAction {

    private DBConfigDialog dbConfigDialog;

    public ConfigDataSourceAction(DBConfigDialog dbConfigDialog) {
        super(dbConfigDialog);

        this.dbConfigDialog = dbConfigDialog;
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        DBConfig dbConfig = dbConfigDialog.getFormData();

        if (StringUtils.isEmpty(dbConfig.getDriverClass())) {
            JOptionPane.showMessageDialog(dbConfigDialog, "请输入JDBC driver class", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(dbConfig.getUrl())) {
            JOptionPane.showMessageDialog(dbConfigDialog, "请输入JDBC url", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(dbConfig.getUsername())) {
            JOptionPane.showMessageDialog(dbConfigDialog, "请输入数据库用户名", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(dbConfig.getPassword())) {
            JOptionPane.showMessageDialog(dbConfigDialog, "请输入数据库密码", "错误", JOptionPane.WARNING_MESSAGE);
        } else {

            try {
                DBOperator dbOperator = new DBOperator(dbConfig);

                Context.put(DBConfig.class.getName(), dbConfig);
                Context.put(DBOperator.class.getName(), dbOperator);
            } catch (Exception ex) {
                throw new Exception("无法连接到数据库：" + ex.getMessage(), ex);
            }

            dbConfigDialog.setVisible(false);
        }

    }
}
