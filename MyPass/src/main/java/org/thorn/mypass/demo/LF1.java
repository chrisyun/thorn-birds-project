package org.thorn.mypass.demo;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class LF1 implements ActionListener
{
    JFrame f = null;
    JButton b = null;
    JMenuItem item1 = null;
    JMenuItem item2 = null;
    JMenuItem item3 = null;
    
    LF1(){
        f = new JFrame("Look and Feel");
        Container contentPane = f.getContentPane();
        contentPane.setLayout(new GridLayout(1,3));
        
        JMenuBar menubar = new JMenuBar();
        JMenu menu = new JMenu("选择想要的Look_and_Feel");
        item1 = new JMenuItem("Java Look and Feel");
        item2 = new JMenuItem("Windows Look and Feel");
        item3 = new JMenuItem("Motif Look and Feel");
        item1.addActionListener(this);
        item2.addActionListener(this);
        item3.addActionListener(this);
        menu.add(item1);
        menu.add(item2);
        menu.add(item3);
        menubar.add(menu);
        f.setJMenuBar(menubar);
        
        JPanel p1 = new JPanel();
        p1.setLayout(new GridLayout(2,1));
        JLabel label = new JLabel("下面是按钮");
        b = new JButton("按我",new ImageIcon(".\\icons\\hand.jpg"));
        b.setHorizontalTextPosition(JButton.CENTER);
        b.setVerticalTextPosition(JButton.BOTTOM);
        b.addActionListener(this);
        p1.add(label);
        p1.add(b);
        
        JPanel p2 = new JPanel();
        p2.setLayout(new GridLayout(3,1));
        p2.setBorder(BorderFactory.createTitledBorder("速食店")); 
        JCheckBox c1 = new JCheckBox("麦当劳");
        JCheckBox c2 = new JCheckBox("肯德鸡");
        JCheckBox c3 = new JCheckBox("21世纪");
        p2.add(c1);
        p2.add(c2);
        p2.add(c3);
        
        String[] s = {"10","12","14","16","18"}; 
        JList list = new JList(s);
        list.setBorder(BorderFactory.createTitledBorder("文字大小"));

        contentPane.add(p1);
        contentPane.add(p2);
        contentPane.add(list);
        
        f.pack();
        f.show();
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                    System.exit(0);
            }
        });
    }
    
    public static void main(String[] args)
    {
        new LF1();
    }
    
    public void actionPerformed(ActionEvent e)
    {
        if(e.getSource() == b)
        {
            JFrame newf = new JFrame("新窗口");
            newf.setSize(200,200);
            newf.show();
        }
        if(e.getSource() == item1)
        {
            try {
        	    UIManager.setLookAndFeel("javax.swing.plaf.metal.MetalLookAndFeel");
        	    SwingUtilities.updateComponentTreeUI(f);
                f.pack();
            }  
            catch( Exception e1 ) {
               System.out.println ("Look and Feel Exception");
               System.exit(0);
            }
        }
        if(e.getSource() == item2)
        {
            try {
        	    UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
        	    SwingUtilities.updateComponentTreeUI(f);
                f.pack();
            }  
            catch( Exception e1 ) {
               System.out.println ("Look and Feel Exception");
               System.exit(0);
            }
        }
        if(e.getSource() == item3)
        {
            try {
        	    UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
        	    SwingUtilities.updateComponentTreeUI(f);
                f.pack();
            }  
            catch( Exception e1 ) {
               System.out.println ("Look and Feel Exception");
               System.exit(0);
            }
        }
    }
}

