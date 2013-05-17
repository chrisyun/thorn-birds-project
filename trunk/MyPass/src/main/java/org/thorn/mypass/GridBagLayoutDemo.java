package org.thorn.mypass;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class GridBagLayoutDemo {
     
    public GridBagLayoutDemo() {
    
        JButton b;
        GridBagConstraints c;
        int gridx,gridy,gridwidth,gridheight,anchor,fill,ipadx,ipady;
        double weightx,weighty;
        Insets inset;     
        
    	JFrame f = new JFrame();

    	GridBagLayout gridbag = new GridBagLayout();
        Container contentPane = f.getContentPane();
        contentPane.setLayout(gridbag);
        
        b= new JButton("first");
        gridx=0;
        gridy=0;
        gridwidth = 1;
        gridheight = 1;
        weightx = 10;
        weighty = 1;
        anchor = GridBagConstraints.CENTER;
        fill = GridBagConstraints.HORIZONTAL;
        inset = new Insets(0,0,0,0);
        ipadx = 0;
        ipady = 0;
        c = new GridBagConstraints(gridx,gridy,gridwidth,gridheight,weightx,weighty,anchor,fill,inset,ipadx,ipady);
        gridbag.setConstraints(b,c);
        contentPane.add(b); 
        
        b= new JButton("second");
        gridx=1;
        gridy=0;
        gridwidth = 2;
        gridheight = 1;
        weightx = 1;
        weighty = 1;
        anchor = GridBagConstraints.CENTER;
        fill = GridBagConstraints.HORIZONTAL;
        inset = new Insets(0,0,0,0);
        ipadx = 50;
        ipady = 0;
        c = new GridBagConstraints(gridx,gridy,gridwidth,gridheight,weightx,weighty,anchor,fill,inset,ipadx,ipady);
        gridbag.setConstraints(b,c);
        contentPane.add(b); 
        
        b= new JButton("third");
        gridx=0;
        gridy=1;
        gridwidth = 1;
        gridheight = 1;
        weightx = 1;
        weighty = 1;
        anchor = GridBagConstraints.CENTER;
        fill = GridBagConstraints.HORIZONTAL;
        inset = new Insets(10,0,0,0);
        ipadx = 0;
        ipady = 50;
        c = new GridBagConstraints(gridx,gridy,gridwidth,gridheight,weightx,weighty,anchor,fill,inset,ipadx,ipady);
        gridbag.setConstraints(b,c);
        contentPane.add(b); 
        
        b= new JButton("fourth");
        gridx=1;
        gridy=1;
        gridwidth = 1;
        gridheight = 1;
        weightx = 1;
        weighty = 1;
        anchor = GridBagConstraints.CENTER;
        fill = GridBagConstraints.HORIZONTAL;
        inset = new Insets(0,0,0,0);
        ipadx = 0;
        ipady = 0;
        c = new GridBagConstraints(gridx,gridy,gridwidth,gridheight,weightx,weighty,anchor,fill,inset,ipadx,ipady);
        gridbag.setConstraints(b,c);
        contentPane.add(b); 
        
        b= new JButton("This is the last button");
        gridx=2;
        gridy=1;
        gridwidth = 1;
        gridheight = 2;
        weightx = 1;
        weighty = 1;
        anchor = GridBagConstraints.SOUTH;
        fill = GridBagConstraints.HORIZONTAL;
        inset = new Insets(0,0,0,0);
        ipadx = 0;
        ipady = 0;
        c = new GridBagConstraints(gridx,gridy,gridwidth,gridheight,weightx,weighty,anchor,fill,inset,ipadx,ipady);
        gridbag.setConstraints(b,c);
        contentPane.add(b);
        
	    f.setTitle("GridBagLayout");
        f.pack();
        f.setVisible(true);
        
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                    System.exit(0);
            }
        });
    }

    public static void main(String args[]) {
    
        new GridBagLayoutDemo();
    }
}
