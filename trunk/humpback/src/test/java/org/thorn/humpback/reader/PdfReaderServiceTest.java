package org.thorn.humpback.reader;

import junit.framework.TestCase;
import org.thorn.humpback.reader.entity.PdfConfiguration;
import org.thorn.humpback.reader.service.PdfReader;

import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-9-11 下午5:28
 * @Version: 1.0
 */
public class PdfReaderServiceTest extends TestCase {

    PdfReader pdfReaderService = new PdfReader();

    PdfConfiguration pdfConfiguration = new PdfConfiguration();

    public void testCreatePdf() throws Exception {

        pdfConfiguration.setWidth(600);
        pdfConfiguration.setHeight(800);
        pdfConfiguration.setFontSize(8);

        pdfConfiguration.setFilePath("D:\\API\\JDOM_API.txt");
        pdfConfiguration.setCharsetCode("gbk");


        pdfReaderService.createPdf(pdfConfiguration);
    }

    public void testSplitPdf() throws Exception {
        pdfConfiguration.setPdfMaxSize(1);

        pdfConfiguration.setPdfFolder("D:\\API\\");
        pdfConfiguration.setPdfName("txj.pdf");

        pdfReaderService.splitPdf(pdfConfiguration, new File("D:\\API\\txj.pdf"));
    }
}
