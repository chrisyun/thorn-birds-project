package org.thorn.spass.storage;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;
import org.thorn.spass.entity.Account;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-8-26 下午4:08
 * @Version: 1.0
 */
@Service
public class XmlParser {

    protected SAXReader saxReader = new SAXReader();

    public List<Account> parse(String xml) throws DocumentException {
        List<Account> accountList = new ArrayList<Account>();
        StringReader reader = new StringReader(xml);

        try {
            Document document = saxReader.read(reader);
            Element root = document.getRootElement();
            List<Element> accounts = root.elements("Account");

            for (Element account : accounts) {
                Account ac = new Account();

                ac.setId(account.elementTextTrim("id"));
                ac.setAddress(account.elementTextTrim("address"));
                ac.setUsername(account.elementTextTrim("username"));
                ac.setPassword(account.elementTextTrim("password"));
                ac.setRemark(account.elementTextTrim("remark"));

                String tags = account.elementTextTrim("tag");
                Set<String> tagSet = new HashSet<String>();
                String[] tagArray = StringUtils.split(tags, "#");
                for(String tag : tagArray) {
                    tagSet.add(tag);
                }
                ac.setTag(tagSet);

                accountList.add(ac);
            }
        } finally {
            reader.close();
        }

        return accountList;
    }

    public String modifyNode(String xml, Account account) throws DocumentException {
        StringReader reader = new StringReader(xml);

        try {
            Document document = saxReader.read(reader);
            Element root = document.getRootElement();
            List<Element> accounts = root.elements("Account");

            for (Element element : accounts) {
                if(StringUtils.equals(element.elementTextTrim("id"), account.getId())) {
                    element.element("address").setText(account.getAddress());
                    element.element("username").setText(account.getUsername());
                    element.element("password").setText(account.getPassword());
                    element.element("remark").setText(account.getRemark());

                    Set<String> tagSet = account.getTag();
                    String tags = "";
                    for(String tag : tagSet) {
                        tags += tag + "#";
                    }
                    element.element("tag").setText(tags);

                    break;
                }
            }

            return document.asXML();
        } finally {
            reader.close();
        }
    }

    public String addNode(String xml, Account account) throws DocumentException {
        StringReader reader = new StringReader(xml);

        try {
            Document document = saxReader.read(reader);
            Element root = document.getRootElement();
            Element ac = root.addElement("Account");

            ac.addElement("id").setText(account.getId());
            ac.addElement("address").setText(account.getAddress());
            ac.addElement("username").setText(account.getUsername());
            ac.addElement("password").setText(account.getPassword());
            ac.addElement("remark").setText(account.getRemark());

            Set<String> tagSet = account.getTag();
            String tags = "";
            for(String tag : tagSet) {
                tags += tag + "#";
            }
            ac.addElement("tag").setText(tags);

            return document.asXML();
        } finally {
            reader.close();
        }
    }

    public String delNode(String xml, Account account) throws DocumentException {
        StringReader reader = new StringReader(xml);

        try {
            Document document = saxReader.read(reader);
            Element root = document.getRootElement();
            List<Element> accounts = root.elements("Account");

            for (Element element : accounts) {
                if(StringUtils.equals(element.elementTextTrim("id"), account.getId())) {
                    root.remove(element);
                    break;
                }
            }

            return document.asXML();
        } finally {
            reader.close();
        }
    }

    public String convert(List<Account> accountList) throws DocumentException {
        Document document = DocumentHelper.createDocument();
        Element root = document.addElement("Note");

        for (Account account : accountList) {
            Element ac = root.addElement("Account");

            ac.addElement("id").setText(account.getId());
            ac.addElement("address").setText(account.getAddress());
            ac.addElement("username").setText(account.getUsername());
            ac.addElement("password").setText(account.getPassword());
            ac.addElement("remark").setText(account.getRemark());

            Set<String> tagSet = account.getTag();
            String tags = "";
            for(String tag : tagSet) {
                tags += tag + "#";
            }
            ac.addElement("tag").setText(tags);

        }

        return document.asXML();
    }

}
