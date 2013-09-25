package org.thorn.humpback.frame.service;

import org.omg.IOP.TAG_CODE_SETS;
import org.thorn.humpback.frame.view.MainFrame;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-9-13 上午11:53
 * @Version: 1.0
 */
public class Context {

    private final static Map<String, Object> CONTEXT_MAP = new HashMap<String, Object>();

    public static MainFrame MAIN_FRAME = null;

    private static final String SELECTED_TAGS = "SELECTED_TAGS";

    public static void clearSelectedTags() {
        Set<String> selectedTags = (Set<String>) CONTEXT_MAP.get(SELECTED_TAGS);
        if(selectedTags != null) {
            selectedTags.clear();
        }
    }

    public static void addSelectedTags(String tag) {
        Set<String> selectedTags = (Set<String>) CONTEXT_MAP.get(SELECTED_TAGS);
        if(selectedTags != null) {
            selectedTags.add(tag);
        } else {
            selectedTags = new HashSet<String>();
            selectedTags.add(tag);
            CONTEXT_MAP.put(SELECTED_TAGS, selectedTags);
        }
    }

    public static void removeSelectedTags(String tag) {
        Set<String> selectedTags = (Set<String>) CONTEXT_MAP.get(SELECTED_TAGS);
        if(selectedTags != null) {
            selectedTags.remove(tag);
        }
    }

    public static Set<String> getSelectedTags() {
        Set<String> selectedTags = (Set<String>) CONTEXT_MAP.get(SELECTED_TAGS);

        return selectedTags;
    }

    public static Object get(String key) {
        return CONTEXT_MAP.get(key);
    }

    public static void put(String key, Object value) {
        CONTEXT_MAP.put(key, value);
    }

}
