package org.thorn.mypass;
import javax.swing.*;
import javax.swing.tree.*;

public class DemoTree extends JInternalFrame{

  public DemoTree(){
    super("Demo Tree Structure", true, true, true, true);

    DefaultMutableTreeNode manager;
    DefaultMutableTreeNode leader;
    DefaultMutableTreeNode engineer;

    DefaultMutableTreeNode top = new DefaultMutableTreeNode("Empolyee List");

    top.add( manager  = new DefaultMutableTreeNode("Manager") );
    top.add( leader   = new DefaultMutableTreeNode("Leader") );
    top.add( engineer = new DefaultMutableTreeNode("Engineer") );

    manager.add( new DefaultMutableTreeNode("C. Fan") );
    manager.add( new DefaultMutableTreeNode("C. Tomas") );
    manager.add( new DefaultMutableTreeNode("C. Simth") );

    leader.add( new DefaultMutableTreeNode("K. Jacky") );
    leader.add( new DefaultMutableTreeNode("M. Shu") );

    engineer.add( new DefaultMutableTreeNode("E. Kevin") );
    engineer.add( new DefaultMutableTreeNode("H. Alex") );
    engineer.add( new DefaultMutableTreeNode("G. J.") );
    engineer.add( new DefaultMutableTreeNode("L. Kate") );
    engineer.add( new DefaultMutableTreeNode("F. Mike") );

    JTree tree = new JTree(top);
    JScrollPane treeScroller = new JScrollPane(tree);
    treeScroller.setBackground(tree.getBackground());
    setContentPane(treeScroller);
    setSize( 250, 200);
    setLocation( 200, 20);	
  }//end of DemoTree()
}//end of class DemoTree