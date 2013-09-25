package org.thorn.humpback.codebuilder.action;

import org.thorn.humpback.codebuilder.entity.Field;
import org.thorn.humpback.codebuilder.view.RenderTemplatePanel;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import javax.swing.table.TableModel;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-9-18 下午5:09
 * @Version: 1.0
 */
public class MappingFieldAction extends AbsAction {

    private JTable table;

    public MappingFieldAction(JTable table) {
        super(Context.MAIN_FRAME);
        this.table = table;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        List<Field> fieldList = new ArrayList<Field>();

        TableModel tableModel = table.getModel();

        int rowSize = tableModel.getRowCount();

        for (int i = 0; i < rowSize; i++) {
            Field field = (Field) tableModel.getValueAt(i, 99);
            fieldList.add(field);
        }

        Context.put(Field.class.getName(), fieldList);

        JPanel panel = new RenderTemplatePanel();
        Context.MAIN_FRAME.setMainPane(panel);
    }
}
