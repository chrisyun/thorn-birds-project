package org.thorn.mypass.view;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridLayout;
import java.awt.Insets;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;

import org.thorn.mypass.utils.PositionUtils;

public class LoginDialog {

    private JDialog loginDialog;

    private Box getBox(Component lable, Component comp) {
	Box box = Box.createHorizontalBox();
	
	lable.setPreferredSize(new Dimension(80, 40));
	comp.setPreferredSize(new Dimension(160, 40));
	box.add(lable);
	box.add(comp);
	
	return box;
    }
    
    public LoginDialog() {
	loginDialog = new JDialog(ComponentReference.getMainFrame(), true);
	loginDialog.setBounds(PositionUtils.locationInCenter(ComponentReference.getMainFrame().getBounds(), 280, 130));
	
	JPanel contentPanel = new JPanel();
	contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
	Box rowBox = Box.createVerticalBox();
	contentPanel.add(rowBox);
	
	JLabel nameLabel = new JLabel("UserName:");
	JComboBox userCombo = new JComboBox(new String[] { "chenyun", "zhengzhuo" });
	rowBox.add(getBox(nameLabel, userCombo));
	rowBox.add(Box.createVerticalStrut(10));
	
	JLabel pwdLabel = new JLabel("Password:");
	JPasswordField pwdField = new JPasswordField();
	rowBox.add(getBox(pwdLabel, pwdField));
	rowBox.add(Box.createVerticalStrut(10));
	
	JButton butOk = new JButton("OK");
	JButton butCancel = new JButton("Cancel");
	rowBox.add(getBox(butOk, butCancel));
	rowBox.add(Box.createVerticalStrut(10));
	
	loginDialog.setContentPane(contentPanel);
    }

    public void login() {

	System.out.println(Thread.currentThread().getId());

	loginDialog.setTitle("Login");
	loginDialog.setVisible(true);
    }

    public void switchUser() {

    }

}
