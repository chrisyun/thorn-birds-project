package org.thorn.humpback.codebuilder.view;

import org.thorn.core.swing.PositionUtils;
import org.thorn.humpback.codebuilder.action.ConfigDataSourceAction;
import org.thorn.humpback.codebuilder.entity.DBConfig;
import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import java.awt.*;

/**
 * @Author: yfchenyun
 * @Since: 13-9-17 下午4:08
 * @Version: 1.0
 */
public class DBConfigDialog extends JDialog {

    private JTextField driverField;

    private JTextField urlField;

    private JTextField userField;

    private JTextField passwordField;

    private static Dimension labelDimension = new Dimension(70, 27);

    private static Dimension textDimension = new Dimension(200, 27);

    public DBConfigDialog() {
        super(Context.MAIN_FRAME, true);

        this.setBounds(PositionUtils.locationInCenter(Context.MAIN_FRAME.getBounds(), 320, 250));
        this.setTitle("数据库配置");

        JPanel contentPanel = new JPanel();
        contentPanel.setBorder(BorderFactory.createEmptyBorder(20, 10, 0, 10));

        Box rowBox = Box.createVerticalBox();

        Box columnBox = Box.createHorizontalBox();
        JLabel label = new JLabel("Driver:");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        driverField = new JTextField();
        driverField.setPreferredSize(textDimension);
        columnBox.add(driverField);

        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("Url:");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        urlField = new JTextField();
        urlField.setPreferredSize(textDimension);
        columnBox.add(urlField);

        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("Username:");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        userField = new JTextField();
        userField.setPreferredSize(textDimension);
        columnBox.add(userField);

        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("Password:");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        passwordField = new JTextField();
        passwordField.setPreferredSize(textDimension);
        columnBox.add(passwordField);

        rowBox.add(columnBox);
        rowBox.add(Box.createVerticalStrut(10));

        JButton button = new JButton("确定");
        button.addActionListener(new ConfigDataSourceAction(this));
        rowBox.add(button);

        this.getRootPane().setDefaultButton(button);

        contentPanel.add(rowBox);

        DBConfig dbConfig = (DBConfig) Context.get(DBConfig.class.getName());
        if(dbConfig != null) {
            driverField.setText(dbConfig.getDriverClass());
            urlField.setText(dbConfig.getUrl());
            userField.setText(dbConfig.getUsername());
            passwordField.setText(dbConfig.getPassword());
        }

        this.setContentPane(contentPanel);
        this.setResizable(false);
        this.setVisible(true);
    }

    public DBConfig getFormData() {
        DBConfig dbConfig = new DBConfig();

        dbConfig.setDriverClass(driverField.getText());
        dbConfig.setUrl(urlField.getText());
        dbConfig.setUsername(userField.getText());
        dbConfig.setPassword(passwordField.getText());

        return dbConfig;
    }

}
