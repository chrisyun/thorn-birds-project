package org.thorn.mypass.view;

import java.util.HashMap;
import java.util.Map;

import javax.swing.JFrame;

public class ComponentReference {
    
    private static ThreadLocal<Map<String, Object>> local = new ThreadLocal<Map<String,Object>>();
    
    static {
	local.set(new HashMap<String, Object>());
    }
    
    public static void setMianFrame(JFrame frame) {
	local.get().put("mainFrame", frame);
    }
    
    public static JFrame getMainFrame() {
	return (JFrame) local.get().get("mainFrame");
    }
    
}
