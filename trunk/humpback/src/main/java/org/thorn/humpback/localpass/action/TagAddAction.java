package org.thorn.humpback.localpass.action;

import org.apache.commons.lang.StringUtils;

import javax.swing.*;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午4:01
 * @Version: 1.0
 */
public class TagAddAction implements ItemListener {

    private JTextField textField;

    public TagAddAction(JTextField textField) {
        this.textField = textField;
    }

    @Override
    public void itemStateChanged(ItemEvent e) {

        JCheckBox checkBox = (JCheckBox) e.getSource();

        String tags = textField.getText();
        int index = StringUtils.indexOf(tags, checkBox.getText());

        if (e.getStateChange() == ItemEvent.SELECTED && index <= -1) {
            textField.setText(tags + checkBox.getText() + "#");
        } else if (e.getStateChange() == ItemEvent.DESELECTED && index >= 0) {

            tags = StringUtils.replace(tags, checkBox.getText() + "#", "");
            textField.setText(tags);
        }
    }

}
