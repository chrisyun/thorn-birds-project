package org.thorn.spass.storage;

import org.springframework.stereotype.Service;

import java.util.prefs.Preferences;

/**
 * @Author: yfchenyun
 * @Since: 13-8-26 下午3:40
 * @Version: 1.0
 */
@Service
public class LocationManager {

    private final static String KEY_LAST_FILE_PATH = "location";

    private final static String KEY_NODE = "org/thorn/spass";

    private Preferences preferences = Preferences.userRoot().node(KEY_NODE);

    public String getLocation() {
        return preferences.get(KEY_LAST_FILE_PATH, "");
    }

    public void setLocation(String path) {
        preferences.put(KEY_LAST_FILE_PATH, path);
    }
}
