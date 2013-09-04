package org.thorn.spass.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.spass.view.AccountTable;
import org.thorn.spass.view.MFrame;

import javax.swing.*;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.HashSet;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午1:40
 * @Version: 1.0
 */
public class TagSearchAction implements ItemListener {

    static Logger log = LoggerFactory.getLogger(TagSearchAction.class);

    private static Set<String> selectedTags = new HashSet<String>();

    private AccountTable accountTable;

    public TagSearchAction(AccountTable accountTable) {
        this.accountTable = accountTable;
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        JCheckBox checkBox = (JCheckBox) e.getSource();

        if(e.getStateChange() == ItemEvent.SELECTED) {
            selectedTags.add(checkBox.getText());
        } else {
            selectedTags.remove(checkBox.getText());
        }

        // do query
        try {
            accountTable.query(selectedTags);
        } catch (Exception ex) {
            log.error("The button name : " + checkBox.getText() + " and panel cls : " + e.getSource().getClass(), ex);
            String msg = ex.getMessage().replaceAll(";", ";\n");
            JOptionPane.showMessageDialog(MFrame.MAIN_FRAME, msg, "操作异常", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void clearSelectedTags() {
        selectedTags.clear();
    }

}
