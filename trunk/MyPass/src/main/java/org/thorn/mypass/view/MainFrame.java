package org.thorn.mypass.view;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
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
	setBounds(300, 100, 550, 600);
	contentPane = new JPanel();
	contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
	contentPane.setLayout(new BorderLayout(0, 0));
	setContentPane(contentPane);

	menuBar = new MyPassMenuBar();
	setJMenuBar(menuBar);
    }

    public void doLogin() {
	this.menuBar.loginAction(false);
	new LoginDialog();
    }
    
    public void doRegister() {
	new RegisterDialog();
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
