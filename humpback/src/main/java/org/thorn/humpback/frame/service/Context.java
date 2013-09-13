package org.thorn.humpback.frame.service;

import org.thorn.humpback.frame.view.MainFrame;

import java.util.HashSet;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-9-13 上午11:53
 * @Version: 1.0
 */
public class Context {

    public static MainFrame MAIN_FRAME = null;

    private static Set<String> SELECTED_TAGS = new HashSet<String>();

    public static void clearSelectedTags() {
        SELECTED_TAGS.clear();
    }

    public static void addSelectedTags(String tag) {
        SELECTED_TAGS.add(tag);
    }

    public static void removeSelectedTags(String tag) {
        SELECTED_TAGS.remove(tag);
    }

    public static Set<String> getSelectedTags() {
        return SELECTED_TAGS;
    }

}
