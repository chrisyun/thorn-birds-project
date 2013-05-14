package org.thorn.mypass.view;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.Box;
import javax.swing.JDialog;

import org.thorn.mypass.utils.PositionUtils;

public class CommonDialog {

    protected JDialog dialog;

    public CommonDialog(int width, int height) {
	dialog = new JDialog(ComponentReference.getMainFrame(), true);
	dialog.setBounds(PositionUtils.locationInCenter(ComponentReference.getMainFrame().getBounds(), width, height));
	dialog.setResizable(false);
    }

    protected void showDialog(String title, Container contentPanel) {
	dialog.setContentPane(contentPanel);
	dialog.setTitle(title);
	dialog.setVisible(true);
    }

    protected Box getBox(Component lable, int labWidth, Component comp, int compWidth, int height) {
	Box box = Box.createHorizontalBox();
	
	lable.setPreferredSize(new Dimension(labWidth, height));
	comp.setPreferredSize(new Dimension(compWidth, height));
	box.add(lable);
	box.add(comp);

	return box;
    }

}
