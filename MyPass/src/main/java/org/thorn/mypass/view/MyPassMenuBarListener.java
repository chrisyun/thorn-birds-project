package org.thorn.mypass.view;

import java.awt.event.ActionEvent;

import org.apache.commons.lang.StringUtils;

public class MyPassMenuBarListener extends AbstractListener {

    @Override
    public void action(ActionEvent e) throws Exception {
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
        } else if (StringUtils.equals(menuName, MyPassMenuBar.MENU_SETTING_PASSWORD)) {
            frame.doModifyPassword();
        } else if (StringUtils.equals(menuName, MyPassMenuBar.MENU_TOOL_ACCOUNT)) {
            frame.queryAccount();
        }
    }
}
