package org.thorn.mypass.demo;

import javax.swing.*;
import java.awt.event.*;

public class JMenuItem3e extends JFrame{

	JTextArea theArea = null;

	public JMenuItem3e(){
	  
	  super("JMenuItem3e");
	  theArea = new JTextArea();
	  theArea.setEditable(false);
	  getContentPane().add(new JScrollPane(theArea));
	  JMenuBar MBar = new JMenuBar();
	  MBar.setOpaque(true);
	  
	  JMenu mfile = buildFileMenu();

	  MBar.add(mfile);  
	  setJMenuBar(MBar);
	}//end of JMenuItem3e()

	public JMenu buildFileMenu() {
  	
	  JMenu thefile = new JMenu("File");
	  thefile.setMnemonic('F');

	  JMenuItem newf = new JMenuItem("New",new ImageIcon("icons/new24.gif"));
	  JMenuItem open = new JMenuItem("Open",new ImageIcon("icons/open24.gif"));
	  JMenuItem close= new JMenuItem("Close",new ImageIcon("icons/close24.gif"));    
	  JMenuItem quit = new JMenuItem("Exit",new ImageIcon("icons/exit24.gif"));

	  newf.setMnemonic('N');
	  open.setMnemonic('O');
	  close.setMnemonic('L');
	  quit.setMnemonic('X');
	  
	  newf.setAccelerator( KeyStroke.getKeyStroke('N', java.awt.Event.CTRL_MASK, false) );
	  open.setAccelerator( KeyStroke.getKeyStroke('O', java.awt.Event.CTRL_MASK, false) );
	  close.setAccelerator( KeyStroke.getKeyStroke('L', java.awt.Event.CTRL_MASK, false) );
	  quit.setAccelerator( KeyStroke.getKeyStroke('X', java.awt.Event.CTRL_MASK, false) );

	  thefile.add(newf);	  	
	  thefile.add(open);
	  thefile.add(close);        
	  thefile.addSeparator();
	  thefile.add(quit);

	  return thefile;
	}//end of buildFileMenu()
	
	public static void main(String[] args){

	  JFrame F = new JMenuItem3e();
	  F.setSize(400,200);
	  F.addWindowListener(new WindowAdapter() {
	    public void windowClosing(WindowEvent e) {
	      System.exit(0); 
	    }
	  });//end of addWindowListener
	  F.setVisible(true); 
	} // end of main
}//end of class JMenuItem3e