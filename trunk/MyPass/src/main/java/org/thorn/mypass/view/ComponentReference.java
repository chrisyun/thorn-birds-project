package org.thorn.mypass.view;

import java.util.HashMap;
import java.util.Map;

public class ComponentReference {

    private static ThreadLocal<Map<String, Object>> local = new ThreadLocal<Map<String, Object>>();

    static {
        local.set(new HashMap<String, Object>());
    }

    public static void setMainFrame(MainFrame frame) {
        local.get().put("mainFrame", frame);
    }

    public static MainFrame getMainFrame() {
        return (MainFrame) local.get().get("mainFrame");
    }

}
