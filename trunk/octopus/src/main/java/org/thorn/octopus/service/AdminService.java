package org.thorn.octopus.service;

import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooDefs;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.ACL;
import org.apache.zookeeper.data.Id;
import org.apache.zookeeper.data.Stat;
import org.apache.zookeeper.server.auth.DigestAuthenticationProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.thorn.octopus.core.ZooKeeperFactory;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-11-18 下午4:46
 * @Version: 1.0
 */
@Service
public class AdminService {

    @Autowired
    private ZooKeeperFactory factory;

    @Value("#{zk['zookeeper.root.node']}")
    private String rootNode;

    @Value("#{zk['zookeeper.account.node']}")
    private String accountNode;

    @Value("#{zk['zookeeper.config.node']}")
    private String configNode;

    public synchronized boolean hasInit() throws KeeperException, InterruptedException, IOException {
        ZooKeeper zooKeeper = factory.getZooKeeper();

        Stat stat = zooKeeper.exists(rootNode, false);

        if(stat != null) {
            return true;
        }

        return false;
    }

    public synchronized void initSystem(String userId, String password) throws NoSuchAlgorithmException, IOException, InterruptedException {
        ZooKeeper zooKeeper = factory.getZooKeeper();

        List<ACL> acls = new ArrayList<ACL>();
        Id id = new Id("digest", DigestAuthenticationProvider.generateDigest(userId + ":" + password));
        ACL acl = new ACL(ZooDefs.Perms.ALL, id);

        zooKeeper.addAuthInfo();

    }


}
