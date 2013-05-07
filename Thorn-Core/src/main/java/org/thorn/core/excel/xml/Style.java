package org.thorn.core.excel.xml;

import java.io.Serializable;
import java.lang.reflect.Field;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.CellStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Style implements Serializable {

	static Logger log = LoggerFactory.getLogger(Style.class);

	/**
	 * 
	 */
	private static final long serialVersionUID = 4574126629289971287L;

	private String font;

	private Short fontSize;

	private Short color;

	private Short backgroundColor;

	private Short border;

	private Short borderColor;

	private Short height;

	private Integer width;

	private Short align;

	private String numberFormat;

	private String dateFormat;

	public Style() {

	}

	public Style(String style) {
		String[] array = StringUtils.split(style, ";");

		if (array != null && array.length > 0) {

			for (String attr : array) {

				int index = attr.indexOf(":");

				if (index < 1) {
					continue;
				}

				String name = attr.substring(0, index).trim();
				String value = attr.substring(index + 1).trim();

				if (StringUtils.equalsIgnoreCase("font", name)) {
					this.font = value;
				} else if (StringUtils.equalsIgnoreCase("fontSize", name)) {
					this.fontSize = Short.parseShort(value);
				} else if (StringUtils.equalsIgnoreCase("color", name)) {
					this.setColor(value);
				} else if (StringUtils.equalsIgnoreCase("backgroundColor", name)) {
					this.setBackgroundColor(value);
				} else if (StringUtils.equalsIgnoreCase("border", name)) {
					this.border = Short.parseShort(value);
				} else if (StringUtils.equalsIgnoreCase("borderColor", name)) {
					this.setBorderColor(value);
				} else if (StringUtils.equalsIgnoreCase("height", name)) {
					this.height = Short.parseShort(value);
				} else if (StringUtils.equalsIgnoreCase("width", name)) {
					this.width = Integer.parseInt(value);
				} else if (StringUtils.equalsIgnoreCase("align", name)) {
					this.setAlign(value);
				} else if (StringUtils.equalsIgnoreCase("numberFormat", name)) {
					this.numberFormat = value;
				} else if (StringUtils.equalsIgnoreCase("dateFormat", name)) {
					this.dateFormat = value;
				}
			}
		}
	}
	
	public void setColor(String color) {
		this.color = getColor(color);
	}
	
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = getColor(backgroundColor);
	}
	
	public void setBorderColor(String borderColor) {
		this.borderColor = getColor(borderColor);
	}
	
	public void setAlign(String align) {
		if (StringUtils.equalsIgnoreCase("center", align)) {
			this.align = CellStyle.ALIGN_CENTER;
		} else if (StringUtils.equalsIgnoreCase("left", align)) {
			this.align = CellStyle.ALIGN_LEFT;
		} else if (StringUtils.equalsIgnoreCase("right", align)) {
			this.align = CellStyle.ALIGN_RIGHT;
		}
	}
	
	private Short getColor(String color) {
		color = color.toUpperCase();

		try {
			Class cls = Class.forName("org.apache.poi.hssf.util.HSSFColor$"
					+ color);
			Field field = cls.getField("index");

			return field.getShort(cls.newInstance());
		} catch (Exception e) {
			log.warn("can't find class[" + color + "], please review!", e);

			return null;
		}
	}

	public String getFont() {
		return font;
	}

	public void setFont(String font) {
		this.font = font;
	}

	public Short getFontSize() {
		return fontSize;
	}

	public void setFontSize(Short fontSize) {
		this.fontSize = fontSize;
	}

	public Short getColor() {
		return color;
	}

	public void setColor(Short color) {
		this.color = color;
	}

	public Short getBackgroundColor() {
		return backgroundColor;
	}

	public void setBackgroundColor(Short backgroundColor) {
		this.backgroundColor = backgroundColor;
	}

	public Short getBorder() {
		return border;
	}

	public void setBorder(Short border) {
		this.border = border;
	}

	public Short getBorderColor() {
		return borderColor;
	}

	public void setBorderColor(Short borderColor) {
		this.borderColor = borderColor;
	}

	public Short getHeight() {
		return height;
	}

	public void setHeight(Short height) {
		this.height = height;
	}

	public Short getAlign() {
		return align;
	}

	public void setAlign(Short align) {
		this.align = align;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public String getNumberFormat() {
		return numberFormat;
	}

	public void setNumberFormat(String numberFormat) {
		this.numberFormat = numberFormat;
	}

	public String getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}
}
