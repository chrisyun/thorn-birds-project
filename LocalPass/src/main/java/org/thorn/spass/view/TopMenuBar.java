package org.thorn.spass.view;

import org.thorn.core.context.SpringContext;
import org.thorn.spass.listener.NoteMenuAction;
import org.thorn.spass.listener.ExitAction;
import org.thorn.spass.listener.OpenAccountDialogAction;
import org.thorn.spass.service.LocationService;

import javax.swing.*;

/**
 * @Author: yfchenyun
 * @Since: 13-8-28 下午1:35
 * @Version: 1.0
 */
public class TopMenuBar extends JMenuBar {

    public TopMenuBar() {
        super();

        JMenu menu = new JMenu();
        menu.setText("菜单");

        JMenuItem menuItem = new JMenuItem();
        menuItem.setText("创建新密码本...    ");
        menuItem.addActionListener(new NoteMenuAction(null, true));
        menu.add(menuItem);

        menu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("打开密码本...    ");
        menuItem.addActionListener(new NoteMenuAction(null, false));
        menu.add(menuItem);

        JMenu recentNote = new JMenu();
        recentNote.setText("打开最近密码本    ");

        LocationService locationService = SpringContext.getBean(LocationService.class);
        String[] recentNotes = locationService.getRecentNotes();

        for (String note : recentNotes) {
            menuItem = new JMenuItem();
            menuItem.setText(note);
            menuItem.addActionListener(new NoteMenuAction(note, false));
            recentNote.add(menuItem);
        }
        menu.add(recentNote);

        menu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("退出");
        menuItem.addActionListener(new ExitAction(MFrame.MAIN_FRAME));
        menu.add(menuItem);

        this.add(menu);
    }

    public void addOperationMenus() {

        if(this.getMenuCount() > 1) {
            return ;
        }

        JMenu menu = new JMenu();
        menu.setText("操作");

        JMenuItem menuItem = new JMenuItem();
        menuItem.setText("添加账号...    ");
        menuItem.addActionListener(new OpenAccountDialogAction());
        menu.add(menuItem);

        this.add(menu);
    }

}
