package org.thorn.humpback.localpass.action;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.localpass.view.AccountTable;

import javax.swing.*;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午1:40
 * @Version: 1.0
 */
public class TagSearchAction implements ItemListener {

    static Logger log = LoggerFactory.getLogger(TagSearchAction.class);

    private AccountTable accountTable;

    public TagSearchAction(AccountTable accountTable) {
        this.accountTable = accountTable;
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        JCheckBox checkBox = (JCheckBox) e.getSource();

        if(e.getStateChange() == ItemEvent.SELECTED) {
            Context.addSelectedTags(checkBox.getText());
        } else {
            Context.removeSelectedTags(checkBox.getText());
        }

        // do query
        try {
            accountTable.query(Context.getSelectedTags());
        } catch (Exception ex) {
            log.error("The button name : " + checkBox.getText() + " and panel cls : " + e.getSource().getClass(), ex);
            String msg = ex.getMessage().replaceAll(";", ";\n");
            JOptionPane.showMessageDialog(Context.MAIN_FRAME, msg, "操作异常", JOptionPane.ERROR_MESSAGE);
        }
    }
}
