package org.thorn.test.spass;

import junit.framework.TestCase;
import org.apache.commons.lang.StringUtils;
import org.springframework.util.Assert;
import org.thorn.spass.entity.Account;
import org.thorn.spass.storage.XmlParser;

import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-8-26 下午5:50
 * @Version: 1.0
 */
public class XmlParserTest extends TestCase {

    private XmlParser xmlParser;

    private String xml = "<Root>" +
            "<Account><id>1</id><address>www.iteye.com</address><username>cy</username><password>12123</password><remark></remark></Account>" +
            "<Account><id>2</id><address>www.iteye.com</address><username>cy</username><password>12123</password><remark></remark></Account>" +
            "</Root>";

    private Account node = new Account();

    @Override
    protected void setUp() throws Exception {
        super.setUp();
        xmlParser = new XmlParser();
        node.setId("2");
        node.setAddress("www.it");
        node.setUsername("chenyun");
        node.setPassword("123");
        node.setRemark("aaaa");
    }

    public void testParse() throws Exception {
        List<Account> list = xmlParser.parse(xml);
        Assert.isTrue(list.size() == 2);
    }

    public void testModifyNode() throws Exception {
        String newXml = xmlParser.modifyNode(xml, node);

        System.out.println("testModifyNode:" + newXml);

        List<Account> list = xmlParser.parse(newXml);
        Assert.isTrue(list.get(1).getId().equals("2"));
    }

    public void testAddNode() throws Exception {
        String newXml = xmlParser.addNode(xml, node);

        System.out.println("testAddNode:" + newXml);

        List<Account> list = xmlParser.parse(newXml);
        Assert.isTrue(list.get(2).getId().equals("2"));
    }

    public void testDelNode() throws Exception {
        String newXml = xmlParser.delNode(xml, node);

        System.out.println("testDelNode:" + newXml);

        List<Account> list = xmlParser.parse(newXml);
        Assert.isTrue(list.size() == 1);
    }

    public void testConvert() throws Exception {
        List<Account> list = xmlParser.parse(xml);
        String newXml = xmlParser.convert(list);

        System.out.println("testConvert:" + newXml);

        List<Account> list2 = xmlParser.parse(newXml);
        Assert.isTrue(list2.size() == 2);
    }

    public void testSplit() {

        String a = "aaaa";

        String[] a1 = a.split("#");

        System.out.println(a1.length + "---" + a1[0]);

        String[] a2 = StringUtils.split(a, "#");
        System.out.println(a2.length + "---" + a2[0]);

    }
}
