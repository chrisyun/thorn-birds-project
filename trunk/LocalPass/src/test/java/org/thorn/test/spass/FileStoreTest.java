package org.thorn.test.spass;

import junit.framework.TestCase;
import org.thorn.spass.storage.FileStore;

import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-8-28 上午10:25
 * @Version: 1.0
 */
public class FileStoreTest extends TestCase {

    private FileStore fileStore = new FileStore();

    public void testWrite() throws Exception {
        fileStore.write("D:\\Document\\d.dat", "chenyun我是人");
    }

    public void testRead() throws Exception {
        System.out.println(fileStore.read("D:\\Document\\d.dat"));
    }

    public void testFileRName() {

        File file = new File("D:\\opt\\parrot_log\\parrot.log.2013-09-05.log");

        file.renameTo(new File("D:\\opt\\parrot_log\\data\\parrot.log.2013-08-26.log.bak"));
    }

}
