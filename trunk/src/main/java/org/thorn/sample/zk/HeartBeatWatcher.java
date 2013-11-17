package org.thorn.sample.zk;

import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;

import java.io.UnsupportedEncodingException;

/**
 * @Author: yfchenyun
 * @Since:: 13-11-17 下午3:31
 * @Version: 1.0
 */
public class HeartBeatWatcher implements Watcher {

    private HeartBeatService heartBeatService;

    public HeartBeatWatcher(HeartBeatService heartBeatService) {
        this.heartBeatService = heartBeatService;
    }

    @Override
    public void process(WatchedEvent watchedEvent) {

        if(watchedEvent.getType() == Event.EventType.NodeDeleted) {
            // register again
            try {
                heartBeatService.registerService(heartBeatService.getNode());
            } catch (InterruptedException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            } catch (KeeperException e) {
                e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
            System.out.println("Master shutdown, slave replace");
        } else {
            System.out.println("Other operation : " + watchedEvent.getType());
        }
    }
}
