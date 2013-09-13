package org.thorn.humpback.localpass.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.humpback.frame.service.Registry;

import java.io.File;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 上午10:55
 * @Version: 1.0
 */
@Service
public class LocationService {

    private final int MAX_NOTES_NUMBER = 5;

    private final static String RECENT_NOTES = "recentNotes";

    @Autowired
    private Registry registry;

    public String[] getRecentNotes() {
        String paths = registry.get(RECENT_NOTES);
        return StringUtils.split(paths, ";");
    }

    public void addOpenedNote(String notePath) {
        String paths = registry.get(RECENT_NOTES);
        String[] notes = StringUtils.split(paths, ";");

        String[] newNotes = new String[MAX_NOTES_NUMBER];

        newNotes[0] = notePath;
        int i = 1;
        for (String note : notes) {

            if (i >= MAX_NOTES_NUMBER) {
                break;
            }

            if (!StringUtils.equals(note, notePath)) {
                newNotes[i] = note;
                i++;
            }
        }

        registry.put(RECENT_NOTES, StringUtils.join(newNotes, ";"));
    }

    public void setNotesSaveFolder(String folder) {
        registry.setLocation(folder);
    }

    public String getNotesSaveFolder() {
        return registry.getLocation();
    }

}
