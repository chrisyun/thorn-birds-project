package org.thorn.core.excel.xml;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.thorn.core.util.ReflectUtils;

public class ExcelByXmlUtils {

    private static Map<String, ExcelConfig> configMap = new Hashtable<String, ExcelConfig>(30);

    private static final String DATA_FORMAT = "yyyy-MM-dd HH:mm:ss";

    private ExcelConfig config;

    public ExcelByXmlUtils(String configName) throws ExcelByXmlException {
        config = configMap.get(configName);

        if (config == null) {
            synchronized (ExcelByXmlUtils.class) {
                try {
                    config = load(configName);
                } catch (ConfigurationException e) {
                    throw new ExcelByXmlException("the xml config has some mistakes!", e);
                } catch (ClassNotFoundException e) {
                    throw new ExcelByXmlException("the object can't find!", e);
                }
            }
        }
    }

    private ExcelConfig load(String configName) throws ConfigurationException, ClassNotFoundException {

        ExcelConfig excelCf = configMap.get(configName);

        if (excelCf != null) {
            return excelCf;
        }

        Configuration config = new XMLConfiguration(configName);

        excelCf = new ExcelConfig();

        excelCf.setFileName(config.getString("name.file"));
        excelCf.setSheetName(config.getString("name.sheet"));

        String objectName = config.getString("mapper.object");
        Class object = Class.forName(objectName);
        excelCf.setObject(object);

        excelCf.setDefaultStyle(new Style());
        excelCf.getDefaultStyle().setAlign(config.getString("style.align"));
        excelCf.getDefaultStyle().setBackgroundColor(config.getString("style.backgroundColor"));
        excelCf.getDefaultStyle().setBorder(config.getShort("style.border", null));
        excelCf.getDefaultStyle().setBorderColor(config.getString("style.borderColor"));
        excelCf.getDefaultStyle().setColor(config.getString("style.color"));
        excelCf.getDefaultStyle().setDateFormat(config.getString("style.dateFormat"));
        excelCf.getDefaultStyle().setFont(config.getString("style.font"));
        excelCf.getDefaultStyle().setFontSize(config.getShort("style.fontSize", null));
        excelCf.getDefaultStyle().setHeight(config.getShort("style.height", null));
        excelCf.getDefaultStyle().setNumberFormat(config.getString("style.numberFormat"));
        excelCf.getDefaultStyle().setWidth(config.getInteger("style.width", null));

        String[] title = config.getStringArray("title.header");
        if (title != null && title.length > 0) {

            excelCf.setTitle(new ArrayList<Header>());
            for (int i = 0; i < title.length; i++) {

                String name = title[i];
                Integer colspan = config.getInteger("title.header(" + i + ")[@colspan]", null);
                String style = config.getString("title.header(" + i + ")[@style]");

                Header header = new Header(name, colspan, style);
                this.mergeStyle(header.getStyle(), excelCf.getDefaultStyle());
                excelCf.getTitle().add(header);
            }
        }

        String[] columns = config.getStringArray("mapper.columns.column");
        excelCf.setColumns(new ArrayList<Column>());
        for (int i = 0; i < columns.length; i++) {

            String name = columns[i];
            String attr = config.getString("mapper.columns.column(" + i + ")[@attr]");
            String style = config.getString("mapper.columns.column(" + i + ")[@style]");

            Column col = new Column(name, attr, style);
            this.mergeStyle(col.getStyle(), excelCf.getDefaultStyle());
            excelCf.getColumns().add(col);
        }

        configMap.put(configName, excelCf);

        return excelCf;
    }

    public <T> void outputExcel(List<T> dataSource, OutputStream os)
            throws ExcelByXmlException {

        try {
            // office 2003
            HSSFWorkbook workBook = new HSSFWorkbook();
            HSSFSheet sheet = workBook.createSheet(config.getSheetName());

            // set title
            HSSFRow title = sheet.createRow(0);
            int i = 0;
            for (Header header : config.getTitle()) {

                HSSFCell cell = title.createCell(i);
                setCellValue(cell, header.getName(), header.getStyle());

                // set cell style
                setCellStyle(cell, header.getStyle(), workBook);
                if (header.getStyle().getHeight() != null) {
                    title.setHeight(header.getStyle().getHeight());
                }

                // col title
                if (header.getColSpan() != null) {
                    int j = header.getColSpan();
                    while (j > 1) {
                        i++;
                        cell = title.createCell(i);
                        j--;
                    }
                    
                    sheet.addMergedRegion(new CellRangeAddress(0, 0, i - header.getColSpan() + 1, i));
                }

                i++;
            }

            // set header
            String[] attrName = new String[config.getColumns().size()];

            HSSFRow header = sheet.createRow(1);
            for (int j = 0; j < config.getColumns().size(); j++) {
                Column col = config.getColumns().get(j);

                HSSFCell cell = header.createCell(j);
                setCellValue(cell, col.getName(), col.getStyle());

                setCellStyle(cell, col.getStyle(), workBook);
                if (col.getStyle().getHeight() != null) {
                    header.setHeight(col.getStyle().getHeight());
                }

                // set column width
                if (col.getStyle().getWidth() != null) {
                    sheet.setColumnWidth(j, (int) (col.getStyle().getWidth() * 35.7));
                }

                attrName[j] = col.getAttribute();
            }

            // 冻结标题栏
            sheet.createFreezePane(0, 2);

            // set content
            List<Object[]> list = ReflectUtils.object2ArrayByFilter(dataSource, attrName);
            if (list != null && list.size() > 0) {

                for (int j = 1; j < list.size(); j++) {
                    HSSFRow row = sheet.createRow(1 + j);

                    Object[] content = list.get(j);
                    for (int k = 0; k < content.length; k++) {
                        HSSFCell cell = row.createCell(k);

                        Style style = this.config.getColumns().get(k).getStyle();

                        setCellValue(cell, content[k], style);
                        setCellStyle(cell, style, workBook);
                        if (style.getHeight() != null) {
                            row.setHeight(style.getHeight());
                        }
                    }
                }
            }

            workBook.write(os);
        } catch (Exception e) {
            throw new ExcelByXmlException("output excel failure: ", e);
        }
    }

    private void setCellValue(HSSFCell cell, Object obj, Style style) {

        if (obj instanceof Boolean) {

            cell.setCellValue((Boolean) obj);
            cell.setCellType(HSSFCell.CELL_TYPE_BOOLEAN);
        } else if (obj instanceof Date) {

            String dateFormat = style.getDateFormat();
            if (StringUtils.isEmpty(dateFormat)) {
                dateFormat = DATA_FORMAT;
            }

            SimpleDateFormat df = new SimpleDateFormat(dateFormat);
            String datetime = df.format((Date) obj);
            cell.setCellValue(new HSSFRichTextString(datetime));
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        } else if (obj instanceof Integer) {

            Integer intObj = (Integer) obj;
            cell.setCellValue(intObj.doubleValue());
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
        } else if (obj instanceof Double) {

            Double doubleObj = (Double) obj;
            cell.setCellValue(doubleObj);
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
        } else if (obj instanceof Long) {

            Long longObj = (Long) obj;
            cell.setCellValue(longObj.doubleValue());
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
        } else if (obj instanceof Float) {

            Float floatObj = (Float) obj;
            cell.setCellValue(floatObj.doubleValue());
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
        } else {

            cell.setCellValue(new HSSFRichTextString((String) obj));
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
        }
    }

    private void setCellStyle(HSSFCell cell, Style style, HSSFWorkbook workBook) {

        HSSFCellStyle cellStyle = workBook.createCellStyle();

        if (style.getBorder() != null) {
            // 设置上下左右四个边框宽度
            cellStyle.setBorderTop(style.getBorder());
            cellStyle.setBorderBottom(style.getBorder());
            cellStyle.setBorderLeft(style.getBorder());
            cellStyle.setBorderRight(style.getBorder());

            if (style.getBorderColor() != null) {
                // 设置上下左右四个边框颜色
                cellStyle.setTopBorderColor(style.getBorderColor());
                cellStyle.setBottomBorderColor(style.getBorderColor());
                cellStyle.setLeftBorderColor(style.getBorderColor());
                cellStyle.setRightBorderColor(style.getBorderColor());
            }
        }

        if (style.getBackgroundColor() != null) {
            // 设置单元格背景色及填充方式
            cellStyle.setFillForegroundColor(style.getBackgroundColor());
            cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        }

        HSSFFont font = workBook.createFont();

        if (style.getFont() != null) {
            font.setFontName(style.getFont());
        }
        if (style.getFontSize() != null) {
            font.setFontHeightInPoints(style.getFontSize());
        }
        if (style.getColor() != null) {
            font.setColor(style.getColor());
        }

        cellStyle.setFont(font);

        if (style.getAlign() != null) {
            cellStyle.setAlignment(style.getAlign());
        }

        cell.setCellStyle(cellStyle);
    }

    private void mergeStyle(Style style, Style defStyle) {
        if (style == null) {
            style = defStyle;
            return;
        }

        if (StringUtils.isEmpty(style.getFont()) && StringUtils.isNotEmpty(defStyle.getFont())) {
            style.setFont(defStyle.getFont());
        }
        if (StringUtils.isEmpty(style.getDateFormat()) && StringUtils.isNotEmpty(defStyle.getDateFormat())) {
            style.setDateFormat(defStyle.getDateFormat());
        }
        if (StringUtils.isEmpty(style.getNumberFormat()) && StringUtils.isNotEmpty(defStyle.getNumberFormat())) {
            style.setNumberFormat(defStyle.getNumberFormat());
        }
        if (style.getAlign() == null && defStyle.getAlign() != null) {
            style.setAlign(defStyle.getAlign());
        }
        if (style.getBackgroundColor() == null && defStyle.getBackgroundColor() != null) {
            style.setBackgroundColor(defStyle.getBackgroundColor());
        }
        if (style.getBorder() == null && defStyle.getBorder() != null) {
            style.setBorder(defStyle.getBorder());
        }
        if (style.getBorderColor() == null && defStyle.getBorderColor() != null) {
            style.setBorderColor(defStyle.getBorderColor());
        }
        if (style.getColor() == null && defStyle.getColor() != null) {
            style.setColor(defStyle.getColor());
        }
        if (style.getFontSize() == null && defStyle.getFontSize() != null) {
            style.setFontSize(defStyle.getFontSize());
        }
        if (style.getHeight() == null && defStyle.getHeight() != null) {
            style.setHeight(defStyle.getHeight());
        }
        if (style.getWidth() == null && defStyle.getWidth() != null) {
            style.setWidth(defStyle.getWidth());
        }
    }

}
