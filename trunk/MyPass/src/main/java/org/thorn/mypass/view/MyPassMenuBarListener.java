package org.thorn.mypass.view;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import org.apache.commons.lang.StringUtils;

public class MyPassMenuBarListener implements ActionListener {

    public void actionPerformed(ActionEvent e) {
        String menuName = e.getActionCommand();
        
        MainFrame frame = ComponentReference.getMainFrame();
        
        if(StringUtils.equals(menuName, MyPassMenuBar.MENU_FILE_EXIT)) {
            frame.exit();
        } else if (StringUtils.equals(menuName, MyPassMenuBar.MENU_FILE_LOGIN)) {
            frame.doLogin();
        } else if (StringUtils.equals(menuName, MyPassMenuBar.MENU_FILE_LOGOUT)) {
            frame.doLogout();
        } else if (StringUtils.equals(menuName, MyPassMenuBar.MENU_FILE_REGISTER)) {
            frame.doRegister();
        }
        
    }
}
