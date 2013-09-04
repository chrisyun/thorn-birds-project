package org.thorn.spass.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.spass.storage.LocationManager;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 上午10:55
 * @Version: 1.0
 */
@Service
public class LocationService {

    private final int MAX_NOTES_NUMBER = 5;

    @Autowired
    private LocationManager locationManager;

    public String[] getRecentNotes() {
        String paths = locationManager.getLocation();
        return StringUtils.split(paths, ";");
    }

    public void addOpenedNote(String notePath) {
        String paths = locationManager.getLocation();
        String[] notes = StringUtils.split(paths, ";");

        String[] newNotes = new String[MAX_NOTES_NUMBER];

        newNotes[0] = notePath;
        int i = 1;
        for(String note : notes) {

            if(i >= MAX_NOTES_NUMBER) {
                break;
            }

            if(!StringUtils.equals(note, notePath)) {
                newNotes[i] = note;
                i++;
            }
        }

        locationManager.setLocation(StringUtils.join(newNotes, ";"));
    }


}
