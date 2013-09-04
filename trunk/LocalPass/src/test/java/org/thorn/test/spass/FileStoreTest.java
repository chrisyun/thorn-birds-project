package org.thorn.test.spass;

import junit.framework.TestCase;
import org.thorn.spass.storage.FileStore;

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

}
