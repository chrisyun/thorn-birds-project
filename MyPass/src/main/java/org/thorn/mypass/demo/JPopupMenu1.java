package org.thorn.mypass.demo;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.event.*;
import javax.swing.border.*;

public class JPopupMenu1 extends JFrame{

	JTextArea theArea = null;
	static final String ComboStr[] = {"Times New Roman","Dialog","宋体","黑体","楷体"};
    JPopupMenu Popup = null;

	public JPopupMenu1(){
	  
	  super("JPopupMenu1");
	  theArea = new JTextArea();
	  theArea.setEditable(false);
	  this.getContentPane().add(new JScrollPane(theArea),BorderLayout.CENTER);
	  JMenuBar MBar = new JMenuBar();
	  MBar.setOpaque(true);
	  JMenu mfile = buildFileMenu();
	  JToolBar theBar = buildToolBar();
      this.getContentPane().add(theBar,BorderLayout.NORTH);
	  PopupPanel pp = new PopupPanel();
      this.getContentPane().add(pp,BorderLayout.SOUTH); 
          
	  MBar.add(mfile);  
	  setJMenuBar(MBar);
	}//end of JPopupMenu1()

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

	  newf.addActionListener(new ActionListener() {
	                   	     public void actionPerformed(ActionEvent e) {
			   	               theArea.append("- MenuItem New Performed -\n");
	                   	     }});

	  open.addActionListener(new ActionListener() {
	                   	     public void actionPerformed(ActionEvent e) {
			   	               theArea.append("- MenuItem Open Performed -\n");
	                   	     }});
	                   	 
	  close.addActionListener(new ActionListener() {
	                    	  public void actionPerformed(ActionEvent e) {
			   	                theArea.append("- MenuItem Close Performed -\n");
	                   	      }});

	  quit.addActionListener(new ActionListener() {
	                   	     public void actionPerformed(ActionEvent e) {
			   	               System.exit(0);
	  	           	         }});

	  thefile.add(newf);	  	
	  thefile.add(open);
	  thefile.add(close);        
	  thefile.addSeparator();
	  thefile.add(quit);

	  return thefile;
	}//end of buildFileMenu()
	
	public JToolBar buildToolBar() {
	  
	  JToolBar toolBar = new JToolBar();
      toolBar.setFloatable(true);
    
	  ToolBarAction tba_new   = new ToolBarAction("new",new ImageIcon("icons/new24.gif"));
	  ToolBarAction tba_open  = new ToolBarAction("open",new ImageIcon("icons/open24.gif"));
	  ToolBarAction tba_close = new ToolBarAction("close",new ImageIcon("icons/close24.gif"));
    
	  JButton JB;
	  JB = toolBar.add(tba_new);
	  JB.setActionCommand("#TooBar_NEW performed!");
	  JB.setToolTipText((String)tba_new.getValue(Action.NAME));
	  JB = toolBar.add(tba_open);
	  JB.setActionCommand("#ToolBar_OPEN performed!");
	  JB.setToolTipText((String)tba_open.getValue(Action.NAME));
	  JB = toolBar.add(tba_close);
	  JB.setActionCommand("#ToolBar_CLOSE performed!");
	  JB.setToolTipText((String)tba_close.getValue(Action.NAME));
    
	  toolBar.addSeparator();
        
	  ToolBarAction tba_B  = new ToolBarAction("bold",new ImageIcon("icons/bold24.gif"));
	  ToolBarAction tba_I  = new ToolBarAction("italic",new ImageIcon("icons/italic24.gif"));
	  ToolBarAction tba_U  = new ToolBarAction("underline",new ImageIcon("icons/underline24.gif")); 
	  JB = toolBar.add(tba_B);
	  JB.setActionCommand("#ToolBar_Bold performed!");
	  JB.setToolTipText((String)tba_B.getValue(Action.NAME));
	  JB = toolBar.add(tba_I);
	  JB.setActionCommand("#ToolBar_Italic performed!");
	  JB.setToolTipText((String)tba_I.getValue(Action.NAME));    
	  JB = toolBar.add(tba_U);
	  JB.setActionCommand("#ToolBar_Underline performed!");
	  JB.setToolTipText((String)tba_U.getValue(Action.NAME));
   
	  toolBar.addSeparator();    
	  JLabel JLfont = new JLabel("Font Type");
	  toolBar.add(JLfont);
	  toolBar.addSeparator();
	  JComboBox jcb = new JComboBox(ComboStr);
	  jcb.addActionListener(new ActionListener() {
	                    	  public void actionPerformed(ActionEvent e) {
			   	                theArea.append("*Combobox "+((JComboBox)e.getSource()).getSelectedItem()+" performed!\n");
	                   	    }});
	  toolBar.add(jcb);
	
	  return toolBar;
	}//end of buildToolBar()
	
	public static void main(String[] args){

	  JFrame F = new JPopupMenu1();
	  F.setSize(430,200);
	  F.addWindowListener(new WindowAdapter() {
	    public void windowClosing(WindowEvent e) {
	      System.exit(0); 
	    }
	  });//end of addWindowListener
	  F.setVisible(true); 
	} // end of main
	
	class ToolBarAction extends AbstractAction{

      public ToolBarAction(String name,Icon icon){
        super(name,icon);
      }

      public void actionPerformed(ActionEvent e){
    
        try{
          theArea.append(e.getActionCommand()+"\n");
        }catch(Exception ex){}
      }
    }//end of inner class ToolBarAction
    
    class PopupPanel extends JPanel implements MouseListener,PopupMenuListener,ActionListener{
      
      public PopupPanel(){
        
        Popup = new JPopupMenu();
      
        JMenuItem theItem;
        Popup.add(theItem = new JMenuItem("Cut",new ImageIcon("icons/cut24.gif")));
        theItem.addActionListener(this);
        Popup.add(theItem = new JMenuItem("Copy",new ImageIcon("icons/copy24.gif")));
        theItem.addActionListener(this);
        Popup.add(theItem = new JMenuItem("Paste",new ImageIcon("icons/paste24.gif")));
        theItem.addActionListener(this);
        Popup.addSeparator();
        Popup.add(theItem = new JMenuItem("Page Setup..."));
        theItem.addActionListener(this);
      
        Popup.setBorder(new BevelBorder(BevelBorder.RAISED));
      
        Popup.addPopupMenuListener(this);  
        addMouseListener(this);
      
      }//end of PopupPanel()
 
	  public void mouseClicked(MouseEvent me){ checkPopup(me);}
   	  public void mousePressed(MouseEvent me){ checkPopup(me);}
  	  public void mouseReleased(MouseEvent me){ checkPopup(me);}
	  public void mouseEntered(MouseEvent me){}
	  public void mouseExited(MouseEvent me){}
	
	  private void checkPopup(MouseEvent me){
	    if(me.isPopupTrigger()){
	      Popup.show(me.getComponent(), me.getX(), me.getY());
	    }
	  }//end of checkPopup() 
	
	  public void popupMenuWillBecomeVisible(PopupMenuEvent pme){
	    theArea.append("-PopupMenu Visibel!\n");
	  }
	  public void popupMenuWillBecomeInvisible(PopupMenuEvent pme){
	    theArea.append("-PopupMenu Invisibel!\n");
	  }
	  public void popupMenuCanceled(PopupMenuEvent pme){
	    theArea.append("-PopupMenu Hidden!\n");
	  }
	  
	  public void actionPerformed(ActionEvent ae){
	     theArea.append("+Popup "+ae.getActionCommand()+" performed!\n");
	  }
    }//end of inner class PopupPanel
}//end of class JPopupMenu1

