package org.thorn.reader.entity;

/**
 * @Author: yfchenyun
 * @Since: 13-9-11 下午4:51
 * @Version: 1.0
 */
public class PdfConfiguration {

    private String filePath;

    private float width;

    private float height;

    private int fontSize;

    private int pdfMaxSize;

    private String pdfName;

    private String pdfFolder;

    private String charsetCode;

    public PdfConfiguration() {

    }

    public PdfConfiguration(String filePath, float width, float height, int fontSize,
                            int pdfMaxSize, String pdfName, String pdfFolder, String charsetCode) {
        this.filePath = filePath;
        this.width = width;
        this.height = height;
        this.fontSize = fontSize;
        this.pdfMaxSize = pdfMaxSize;
        this.pdfName = pdfName;
        this.pdfFolder = pdfFolder;
        this.charsetCode = charsetCode;
    }

    public String getCharsetCode() {
        return charsetCode;
    }

    public void setCharsetCode(String charsetCode) {
        this.charsetCode = charsetCode;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public float getWidth() {
        return width;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public int getFontSize() {
        return fontSize;
    }

    public void setFontSize(int fontSize) {
        this.fontSize = fontSize;
    }

    public int getPdfMaxSize() {
        return pdfMaxSize;
    }

    public void setPdfMaxSize(int pdfMaxSize) {
        this.pdfMaxSize = pdfMaxSize;
    }

    public String getPdfName() {
        return pdfName;
    }

    public void setPdfName(String pdfName) {
        this.pdfName = pdfName;
    }

    public String getPdfFolder() {
        return pdfFolder;
    }

    public void setPdfFolder(String pdfFolder) {
        this.pdfFolder = pdfFolder;
    }
}
