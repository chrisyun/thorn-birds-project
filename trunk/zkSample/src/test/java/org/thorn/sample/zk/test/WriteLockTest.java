package org.thorn.sample.zk.test;

import org.apache.zookeeper.*;
import org.apache.zookeeper.recipes.lock.WriteLock;

import java.io.IOException;
import java.util.concurrent.CountDownLatch;

/**
 * @Author: yfchenyun
 * @Since:: 13-11-17 下午7:28
 * @Version: 1.0
 */
public class WriteLockTest {

    public static void main(String[] args) throws IOException, InterruptedException {

        final CountDownLatch latch = new CountDownLatch(1);

        ZooKeeper zooKeeper = new ZooKeeper("192.168.1.103:2181,192.168.1.103:2182,192.168.1.103:2183", 3000, new Watcher() {
            @Override
            public void process(WatchedEvent watchedEvent) {
                latch.countDown();
            }
        });
        latch.await();

        WriteLock writeLock = new WriteLock(zooKeeper, "/lock", ZooDefs.Ids.OPEN_ACL_UNSAFE);

        try {
            writeLock.lock();

            while (true) {
                if(writeLock.isOwner()) {
                   break;
                }
            }

            writeLock.unlock();

        } catch (KeeperException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }




    }


}
