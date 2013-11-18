package org.thorn.octopus.core;

import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;

/**
 * @Author: yfchenyun
 * @Since: 13-11-18 下午4:09
 * @Version: 1.0
 */
public class ZooKeeperFactory {

    static Logger logger = LoggerFactory.getLogger(ZooKeeperFactory.class);

    private String host;

    private int sessionTimeout;

    public ZooKeeper getZooKeeper() throws InterruptedException, IOException {
        final CountDownLatch latch = new CountDownLatch(1);

        ZooKeeper zooKeeper = new ZooKeeper(host, sessionTimeout, new Watcher() {
            @Override
            public void process(WatchedEvent event) {
                if(event.getState() == Event.KeeperState.SyncConnected) {
                    latch.countDown();
                    logger.info("Connected on zookeeper.");
                }
            }
        });

        latch.await();
        return zooKeeper;
    }

    public ZooKeeperFactory(String host, int sessionTimeout) {
        this.host = host;
        this.sessionTimeout = sessionTimeout;
    }
}
