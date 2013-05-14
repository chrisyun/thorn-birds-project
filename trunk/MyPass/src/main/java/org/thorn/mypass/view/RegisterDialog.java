package org.thorn.mypass.view;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import org.apache.commons.lang.StringUtils;

public class RegisterDialog extends CommonDialog {

    private JTextField userText;

    private JPasswordField pwdField;

    private JPasswordField pwdRpField;

    private Box getBox(Component lable, Component comp) {
	return super.getBox(lable, 120, comp, 160, 30);
    }

    public RegisterDialog() {
	super(320, 200);

	JPanel contentPanel = new JPanel();
	contentPanel.setBorder(BorderFactory.createEmptyBorder(5, 20, 5, 20));
	Box rowBox = Box.createVerticalBox();
	contentPanel.add(rowBox);

	JLabel nameLabel = new JLabel("Username:");
	userText = new JTextField();
	rowBox.add(getBox(nameLabel, userText));
	rowBox.add(Box.createVerticalStrut(10));

	JLabel pwdLabel = new JLabel("Password:");
	pwdField = new JPasswordField();
	rowBox.add(getBox(pwdLabel, pwdField));
	rowBox.add(Box.createVerticalStrut(10));
	
	JLabel pwdRpLabel = new JLabel("Confirm password:");
	pwdRpField = new JPasswordField();
	rowBox.add(getBox(pwdRpLabel, pwdRpField));
	rowBox.add(Box.createVerticalStrut(10));
	
	JButton butOk = new JButton("Create");
	butOk.addActionListener(new ActionListener() {

	    public void actionPerformed(ActionEvent e) {
		String pwd = String.copyValueOf(pwdField.getPassword());
		String rpPwd = String.copyValueOf(pwdRpField.getPassword());
		String userName = userText.getText();

		if (StringUtils.isEmpty(userName)) {
		    JOptionPane.showMessageDialog(dialog, "You need inputting your username!", "Checking", JOptionPane.WARNING_MESSAGE);
		} else if (StringUtils.isEmpty(pwd)) {
		    JOptionPane.showMessageDialog(dialog, "You need inputting your password!", "Checking", JOptionPane.WARNING_MESSAGE);
		}  else if (StringUtils.isEmpty(rpPwd)) {
		    JOptionPane.showMessageDialog(dialog, "You need inputting your confirm password!", "Checking", JOptionPane.WARNING_MESSAGE);
		} else if (!StringUtils.equals(pwd, rpPwd)) {
		    JOptionPane.showMessageDialog(dialog, "The two passwords is not the same!", "Checking", JOptionPane.WARNING_MESSAGE);
		} else {
		    JOptionPane.showMessageDialog(dialog, "Register success!", "Success", JOptionPane.INFORMATION_MESSAGE);
		    dialog.setVisible(false);
		    ComponentReference.getMainFrame().doLogin();
		}
	    }
	});

	JButton butCancel = new JButton("Cancel");
	butCancel.addActionListener(new ActionListener() {

	    public void actionPerformed(ActionEvent e) {
		dialog.setVisible(false);
	    }
	});

	butOk.setPreferredSize(new Dimension(130, 30));
	butCancel.setPreferredSize(new Dimension(130, 30));
	Box colbox = Box.createHorizontalBox();
	colbox.add(butOk);
	colbox.add(Box.createHorizontalStrut(20));
	colbox.add(butCancel);
	rowBox.add(colbox);
	rowBox.add(Box.createVerticalStrut(10));
	
	super.showDialog("Create a new Account", contentPanel);
    }

}
