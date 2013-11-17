package org.thorn.sample.zk;

import org.apache.zookeeper.*;
import org.apache.zookeeper.data.Stat;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.concurrent.CountDownLatch;

/**
 * @Author: yfchenyun
 * @Since:: 13-11-17 下午3:23
 * @Version: 1.0
 */
public class HeartBeatService implements Watcher {

    private ZooKeeper zooKeeper;

    private static int SESSION_TIME_OUT = 2000 * 3;

    private CountDownLatch latch = new CountDownLatch(1);

    private String node;

    public void connect(String host) throws IOException, InterruptedException {
        zooKeeper = new ZooKeeper(host, SESSION_TIME_OUT, this);
        latch.await();
    }

    public void registerService(String node) throws InterruptedException, KeeperException {
        this.node = node;

        Stat stat = zooKeeper.exists(node, false);

        if(stat == null) {
            zooKeeper.create(node, null, ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
            System.out.println("Master Service register in zookeeper.");
        } else {
            zooKeeper.exists(node, new HeartBeatWatcher(this));
            System.out.println("Master work normally, i'm waiting.");
        }
    }

    public String getNode() {
        return node;
    }

    @Override
    public void process(WatchedEvent watchedEvent) {
        if(watchedEvent.getState() == Event.KeeperState.SyncConnected) {
            System.out.println("connect to zookeeper...");
            latch.countDown();
        }
    }
}
