package org.thorn.spass.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 下午2:52
 * @Version: 1.0
 */
public class Session {

    private String xml;

    private List<Account> accountList;

    private Set<String> tags;

    private String filePath;

    private String password;

    public Session() {
    }

    public Session(String xml, List<Account> accountList, Set<String> tags, String filePath, String password) {
        this.xml = xml;
        this.accountList = accountList;
        this.tags = tags;
        this.filePath = filePath;
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getXml() {
        return xml;
    }

    public void setXml(String xml) {
        this.xml = xml;
    }

    public List<Account> getAccountList() {
        return accountList;
    }

    public void setAccountList(List<Account> accountList) {
        this.accountList = accountList;
    }

    public Set<String> getTags() {
        return tags;
    }

    public void setTags(Set<String> tags) {
        this.tags = tags;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
