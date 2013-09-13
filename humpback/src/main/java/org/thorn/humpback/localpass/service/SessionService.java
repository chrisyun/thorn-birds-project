package org.thorn.humpback.localpass.service;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.thorn.humpback.localpass.entity.Account;
import org.thorn.humpback.localpass.entity.Session;

import java.util.List;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 下午2:53
 * @Version: 1.0
 */
@Service
public class SessionService {

    private static Session session = null;

    public synchronized void loadSession(String filePath, String xml,
                                         List<Account> accountList, Set<String> tags, String password) {
        session = new Session(xml, accountList, tags, filePath, password);
    }

    public void clearSession() {
        session = null;
    }

    public String getCurrentXml() {
        Assert.notNull(session);
        return session.getXml();
    }

    public List<Account> getCurrentAccounts() {
        Assert.notNull(session);
        return session.getAccountList();
    }

    public Set<String> getCurrentTags() {
        Assert.notNull(session);
        return session.getTags();
    }

    public String getCurrentFilePath() {
        Assert.notNull(session);
        return session.getFilePath();
    }

    public String getCurrentPassword() {
        Assert.notNull(session);
        return session.getPassword();
    }

}
