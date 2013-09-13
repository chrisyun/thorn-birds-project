package org.thorn.humpback.localpass;

import junit.framework.Assert;
import junit.framework.TestCase;
import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.humpback.localpass.service.LocationService;

/**
 * @Author: yfchenyun
 * @Since: 13-8-29 上午11:35
 * @Version: 1.0
 */
public class LocationServiceTest extends TestCase {

    private LocationService locationService;

    @Override
    protected void setUp() throws Exception {
        super.setUp();

        SpringContext context = new SpringContext();
        context.setApplicationContext(new String[] {"localPass.xml"});

        locationService = SpringContext.getBean(LocationService.class);
    }

    public void testGetRecentNotes() throws Exception {
        String[] notes = locationService.getRecentNotes();
        Assert.assertTrue(notes.length >= 0);
        System.out.println(StringUtils.join(notes, ";"));
    }

    public void testAddOpenedNote() throws Exception {
        locationService.addOpenedNote("d:\\a.xtx");
        locationService.addOpenedNote("d:\\a2.xtx");
        locationService.addOpenedNote("d:\\a3.xtx");
        locationService.addOpenedNote("d:\\a4.xtx");
        locationService.addOpenedNote("d:\\a5.xtx");
        locationService.addOpenedNote("d:\\a6.xtx");
        locationService.addOpenedNote("d:\\a3.xtx");

        String[] notes = locationService.getRecentNotes();
        Assert.assertTrue(notes.length == 5);
        System.out.println(StringUtils.join(notes, ";"));

    }
}
