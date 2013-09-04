package org.thorn.spass.service;

import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.core.util.AESUtils;
import org.thorn.core.util.MD5Utils;
import org.thorn.spass.entity.Account;
import org.thorn.spass.exception.SPassException;
import org.thorn.spass.storage.FileStore;
import org.thorn.spass.storage.XmlParser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 上午10:54
 * @Version: 1.0
 */
@Service
public class AccountService {

    @Autowired
    private FileStore fileStore;

    @Autowired
    private XmlParser xmlParser;

    @Autowired
    private SessionService sessionService;

    public void createNote(String filePath, String password) throws Exception {

        String root = "<Note></Note>";
        String aesKey = MD5Utils.encodeBySalt(password, password);
        String content = AESUtils.encrypt(root, aesKey);

        fileStore.write(filePath, content);
        sessionService.loadSession(filePath, root, new ArrayList<Account>(), new HashSet<String>(), aesKey);
    }

    public void addAccount(Account account) throws SPassException {
        account.setId(System.currentTimeMillis() + "");

        try {
            String xml = xmlParser.addNode(sessionService.getCurrentXml(), account);
            String content = AESUtils.encrypt(xml, sessionService.getCurrentPassword());

            fileStore.write(sessionService.getCurrentFilePath(), content);

            this.loadNoteByAesKey(sessionService.getCurrentFilePath(), sessionService.getCurrentPassword());
        } catch (DocumentException e) {
            throw new SPassException("XML文件解析出错", e);
        } catch (Exception e) {
            throw new SPassException("添加文件出错", e);
        }
    }

    public void modifyAccount(Account account) throws SPassException {
        try {
            String xml = xmlParser.modifyNode(sessionService.getCurrentXml(), account);
            String content = AESUtils.encrypt(xml, sessionService.getCurrentPassword());

            fileStore.write(sessionService.getCurrentFilePath(), content);

            this.loadNoteByAesKey(sessionService.getCurrentFilePath(), sessionService.getCurrentPassword());
        } catch (DocumentException e) {
            throw new SPassException("XML文件解析出错", e);
        } catch (Exception e) {
            throw new SPassException("添加文件出错", e);
        }
    }

    public void deleteAccount(Account account) throws SPassException {
        try {
            String xml = xmlParser.delNode(sessionService.getCurrentXml(), account);
            String content = AESUtils.encrypt(xml, sessionService.getCurrentPassword());

            fileStore.write(sessionService.getCurrentFilePath(), content);

            this.loadNoteByAesKey(sessionService.getCurrentFilePath(), sessionService.getCurrentPassword());
        } catch (DocumentException e) {
            throw new SPassException("XML文件解析出错", e);
        } catch (Exception e) {
            throw new SPassException("添加文件出错", e);
        }
    }


    public Set<String> queryTags() {
        return sessionService.getCurrentTags();
    }

    public List<Account> queryAccounts(Set<String> tags) {

        List<Account> accounts = new ArrayList<Account>();
        List<Account> sessionAccounts = sessionService.getCurrentAccounts();

        for (Account account : sessionAccounts) {

            Set<String> tagSet = account.getTag();

            if(tags == null || tags.size() == 0) {
                accounts.add(account);
            } else if(tagSet == null || tagSet.size() == 0) {
                continue;
            } else {
                for(String tag : tags) {
                    if(tagSet.contains(tag)) {
                        accounts.add(account);
                        break;
                    }
                }
            }
        }

        return accounts;
    }

    public Account queryAccount(String id) {

        List<Account> sessionAccounts = sessionService.getCurrentAccounts();

        for(Account ac : sessionAccounts) {

            if(StringUtils.equals(ac.getId(), id)) {
                return ac;
            }
        }

        return null;
    }

    public void loadNoteByAesKey(String filePath, String password) throws SPassException {
        this.loadNote(filePath, password, true);
    }

    public void loadNote(String filePath, String password) throws SPassException {
        this.loadNote(filePath, password, false);
    }

    public void loadNote(String filePath, String password, boolean isAesKey) throws SPassException {

        String content = null;
        String xml = null;
        String aesKey = null;
        try {
            content = fileStore.read(filePath);
        } catch (IOException e) {
            throw new SPassException("密码本未找到", e);
        }

        try {
            if(isAesKey) {
                aesKey = password;
            } else {
                aesKey = MD5Utils.encodeBySalt(password, password);
            }

            xml = AESUtils.decrypt(content, aesKey);
        } catch (Exception e) {
            throw new SPassException("密码错误，解密失败", e);
        }

        try {
            List<Account> accountList = xmlParser.parse(xml);

            Set<String> tagSet = new HashSet<String>();

            for (Account account : accountList) {
                Set<String> tags = account.getTag();

                for (String tag : tags) {
                    tagSet.add(tag);
                }
            }

            sessionService.loadSession(filePath, xml, accountList, tagSet, password);
        } catch (DocumentException e) {
            throw new SPassException("密码错误，解析失败", e);
        }
    }


}
