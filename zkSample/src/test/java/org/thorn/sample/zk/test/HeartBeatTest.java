package org.thorn.sample.zk.test;

import org.apache.zookeeper.KeeperException;
import org.thorn.sample.zk.HeartBeatService;

import java.io.IOException;

/**
 * @Author: yfchenyun
 * @Since:: 13-11-17 下午3:56
 * @Version: 1.0
 */
public class HeartBeatTest {

    public static void main(String[] args) {

        String zkServers = "192.168.1.103:2181,192.168.1.103:2182,192.168.1.103:2183";

        HeartBeatService heartBeatService = new HeartBeatService();
        try {
            heartBeatService.connect(zkServers);
            heartBeatService.registerService("/heart");

            Thread.sleep(Long.MAX_VALUE);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (InterruptedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (KeeperException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }


    }



}
