package org.thorn.humpback.frame.service;

import org.springframework.stereotype.Service;

import java.io.File;
import java.util.prefs.Preferences;

/**
 * @Author: yfchenyun
 * @Since: 13-9-13 下午3:42
 * @Version: 1.0
 */
@Service
public class Registry {

    private final static String KEY_NODE = "org/thorn/humpback";

    private Preferences preferences = Preferences.userRoot().node(KEY_NODE);

    private final static String APP_DIR = "location";

    private final static String DEFAULT_APP_DIR = "d:\\humpback\\";

    public void put(String key, String value) {
        preferences.put(key, value);
    }

    public String get(String key, String defaultValue) {
        return preferences.get(key, defaultValue);
    }

    public String get(String key) {
        return get(key, "");
    }

    public String getLocation() {
        String folder = get(APP_DIR, DEFAULT_APP_DIR);

        File file = new File(folder);
        if (!file.exists()) {
            file.mkdirs();
        }

        return folder;
    }

    public void setLocation(String path) {
        put(APP_DIR, path);
    }


}
