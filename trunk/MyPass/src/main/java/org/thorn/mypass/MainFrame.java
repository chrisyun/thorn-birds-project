package org.thorn.mypass;

import javax.swing.*;
import java.awt.event.*;
import java.awt.*;

public class MainFrame extends JFrame{

  JDesktopPane desktop;
  JMenuBar     MBar;
  JToolBar     toolBar;  
	
  public MainFrame(){

    super("MainFrame-Look and Feel");
    setBounds(100,100,600,400);
    buildContent();
    buildMenu();
    buildToolBar();

    this.getContentPane().add(toolBar,BorderLayout.NORTH);
     
    this.addWindowListener(new WindowAdapter() {
    	public void windowClosing(WindowEvent e) {
    	  quit(); 
        }
    });//end of addWindowListener
  }//end of main

  protected void buildContent() {
    desktop = new JDesktopPane();
    getContentPane().add(desktop);
  }//end of buildContent()

  protected void buildMenu(){
    MBar = new JMenuBar();
    MBar.setOpaque(true);
    JMenu mfile = buildFileMenu();
    JMenu mdemo = buildDemoMenu(); 
    
    //�]�wHot Key Alt+'?'    
    mfile.setMnemonic('F');
    mdemo.setMnemonic('D');    
    
    MBar.add(mfile);
    MBar.add(mdemo);
    setJMenuBar(MBar);    
  }//end of bulidMenu()

  protected void buildToolBar(){
    toolBar = new JToolBar();
    toolBar.setFloatable(true);
    
    ToolBarAction tba_new   = new ToolBarAction("new",new ImageIcon("icons/new24.gif"));
    ToolBarAction tba_open  = new ToolBarAction("open",new ImageIcon("icons/open24.gif"));
    ToolBarAction tba_close = new ToolBarAction("close",new ImageIcon("icons/copy24.gif"));
    ToolBarAction tba_save  = new ToolBarAction("save",new ImageIcon("icons/save24.gif"));
    
    JButton JB;
    JB = toolBar.add(tba_new);
    JB.setActionCommand("TB_NEW");
    JB.setToolTipText((String)tba_new.getValue(Action.NAME));
    JB = toolBar.add(tba_open);
    JB.setActionCommand("TB_OPEN");
    JB.setToolTipText((String)tba_open.getValue(Action.NAME));
    JB = toolBar.add(tba_close);
    JB.setActionCommand("TB_CLOSE");
    JB.setToolTipText((String)tba_close.getValue(Action.NAME));
    
    toolBar.addSeparator();
    
    JB = toolBar.add(tba_save);
    JB.setActionCommand("TB_SAVE");
    JB.setToolTipText((String)tba_save.getValue(Action.NAME));
    tba_save.setEnabled(false);
  }//end of buildToolBar()

  public void quit(){
    System.exit(0); 
  }//end of quit()

  public JMenu buildFileMenu() {
  	
    JMenu file = new JMenu("File");
    JMenuItem newf = new JMenuItem("New");
    JMenuItem open = new JMenuItem("Open");
    JMenuItem close= new JMenuItem("Close");    
    JMenuItem quit = new JMenuItem("Exit");

    newf.setEnabled(false);
    open.setEnabled(false);
    close.setEnabled(false);
 
    //���ܥ�
    newf.setMnemonic('N');
    open.setMnemonic('O');
    close.setMnemonic('C');   
    quit.setMnemonic('X');
    //�]�wHot Key, Ctrl+'?'
    newf.setAccelerator( KeyStroke.getKeyStroke('N',java.awt.Event.CTRL_MASK,false) );    
    open.setAccelerator( KeyStroke.getKeyStroke('O',java.awt.Event.CTRL_MASK,false) );
    close.setAccelerator( KeyStroke.getKeyStroke('C',java.awt.Event.CTRL_MASK,false) );
    quit.setAccelerator( KeyStroke.getKeyStroke('X',java.awt.Event.CTRL_MASK,false) );    

    quit.addActionListener(new ActionListener() {
	                   public void actionPerformed(ActionEvent e) {
			   quit();
	  	           }});
    file.add(newf);	  	
    file.add(open);
    file.add(close);        
    file.addSeparator();
    file.add(quit);
    return file;
  }//end of buildFileMenu()

  protected JMenu buildDemoMenu() {
  	
    JMenu demo = new JMenu("Demo");
    JMenuItem tree     = new JMenuItem("Tree Structure");

    tree.setMnemonic('T');
    tree.setAccelerator( KeyStroke.getKeyStroke('T',java.awt.Event.CTRL_MASK,false) );
    
    tree.addActionListener(new ActionListener() {
	                   public void actionPerformed(ActionEvent e) {
			     DemoTree();
	                   }});
    demo.add(tree);
    return demo;                
  }//end of buildDemoMenu()

  public void DemoTree() {

    JInternalFrame JItree = new DemoTree();
    desktop.add(JItree, new Integer(1));
    try { 
         JItree.setVisible(true);
	 JItree.setSelected(true); 
    }catch (java.beans.PropertyVetoException e2) {}  	
  }//end of DemoTree()

}//end of class MainFrame
