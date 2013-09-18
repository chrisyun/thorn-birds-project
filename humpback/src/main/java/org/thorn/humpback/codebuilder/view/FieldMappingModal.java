package org.thorn.humpback.codebuilder.view;

import org.thorn.humpback.codebuilder.entity.Field;
import org.thorn.humpback.frame.service.Context;

import javax.swing.table.DefaultTableModel;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-9-18 下午3:23
 * @Version: 1.0
 */
public class FieldMappingModal extends DefaultTableModel {

    private static final String[] HEADER = {"列名", "列类型", "主键", "字段名", "字段类型"};

    private List<Field> fieldList;

    public FieldMappingModal() {
        super();
        fieldList = (List<Field>) Context.get(Field.class.getName());
    }

    @Override
    public int getRowCount() {
        return fieldList.size();
    }

    @Override
    public int getColumnCount() {
        return HEADER.length;
    }

    @Override
    public String getColumnName(int column) {
        return HEADER[column];
    }

    @Override
    public void setValueAt(Object aValue, int row, int column) {
        super.setValueAt(aValue, row, column);

        Field field = fieldList.get(row);
        if(column == 3) {
            field.setFieldName((String) aValue);
        } else if(column == 4) {
            field.setFieldType((String) aValue);
        }
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        if(columnIndex > 2) {
            return true;
        }

        return false;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Field field = fieldList.get(rowIndex);

        Object value = null;

        switch (columnIndex) {
            case 0 :
                value = field.getTabName();
                break;
            case 1 :
                value = field.getTabType();
                break;
            case 2 :
                value = field.isKey();
                break;
            case 3 :
                value = field.getFieldName();
                break;
            case 4 :
                value = field.getFieldType();
                break;

            default:
                value = field;
                break;
        }


        return value;
    }
}
