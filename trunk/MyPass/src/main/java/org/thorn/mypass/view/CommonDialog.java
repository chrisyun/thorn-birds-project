package org.thorn.mypass.view;

import org.thorn.core.swing.PositionUtils;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;

import javax.swing.Box;
import javax.swing.JDialog;


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

    protected Box getBox(Component label, int labWidth, Component comp, int compWidth, int height) {
        Box box = Box.createHorizontalBox();

        label.setPreferredSize(new Dimension(labWidth, height));
        comp.setPreferredSize(new Dimension(compWidth, height));
        box.add(label);
        box.add(comp);

        return box;
    }

}
