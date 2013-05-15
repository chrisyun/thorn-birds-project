package org.thorn.mypass.view;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.EventQueue;

import javax.swing.BorderFactory;
import javax.swing.JApplet;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.border.EmptyBorder;

import org.thorn.mypass.utils.ImageUtils;

public class MainFrame extends JFrame {

    private JPanel contentPane;

    private MyPassMenuBar menuBar;

    /**
     * Launch the application.
     */
    public static void main(String[] args) {
	EventQueue.invokeLater(new Runnable() {
	    public void run() {
		try {
		    MainFrame frame = new MainFrame();
		    frame.setTitle("My Pass");
		    frame.setIconImage(ImageUtils.getIconFromCls("/icons/logo.png").getImage());
		    frame.setVisible(true);

		    ComponentReference.setMianFrame(frame);
		    frame.doLogin();
		} catch (Exception e) {
		    e.printStackTrace();
		}
	    }
	});
    }

    /**
     * Create the frame.
     */
    public MainFrame() {
	setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	setBounds(300, 100, 750, 500);
	contentPane = new JPanel();
	contentPane.setLayout(new BorderLayout(0, 0));
	setContentPane(contentPane);

	menuBar = new MyPassMenuBar();
	setJMenuBar(menuBar);
    }

    public void doLogin() {
//	this.menuBar.loginAction(false);
//	new LoginDialog();
	queryAccount();
    }

    public void doRegister() {
	new RegisterDialog();
    }
    
    public void doModifyPassword() {
	new ModifyPasswordDialog();
    }

    public void queryAccount() {
	AccountTable table = new AccountTable();
	JPanel tablePanel = table.getTablePanel();
	
	GroupPanel group = new GroupPanel();
	JPanel groupPanel = group.getGroupPanel();
	
	JSplitPane splitPane = new JSplitPane(
	            JSplitPane.HORIZONTAL_SPLIT,true, groupPanel, tablePanel);
	splitPane.setDividerSize(1);
	contentPane.add(splitPane);
	contentPane.updateUI();
    }
    
    
    public void doLogout() {
	int result = JOptionPane.showConfirmDialog(this, "Do you confirm logout?", "logout", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE);
	if (result == JOptionPane.YES_OPTION) {
	    doLogin();
	}
    }

    public void loginSuccess() {
	this.menuBar.loginAction(true);
    }

    public void exit() {
	int result = JOptionPane.showConfirmDialog(this, "Do you confirm exit?", "Exit", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE);
	if (result == JOptionPane.YES_OPTION) {
	    System.exit(0);
	}
    }

}
