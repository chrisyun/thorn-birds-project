package org.thorn.humpback.frame.view;

import org.thorn.core.context.SpringContext;
import org.thorn.humpback.frame.action.ExitAction;
import org.thorn.humpback.frame.action.OpenDialogAction;
import org.thorn.humpback.localpass.action.*;
import org.thorn.humpback.localpass.service.LocationService;
import org.thorn.humpback.localpass.view.AccountDialog;
import org.thorn.humpback.localpass.view.ModifyPwdDialog;
import org.thorn.humpback.localpass.view.NotesFolderSettingDialog;
import org.thorn.humpback.qrcode.action.LoadQrPanelAction;
import org.thorn.humpback.reader.action.LoadReaderPanelAction;

import javax.swing.*;
import java.awt.event.ActionListener;

/**
 * @Author: yfchenyun
 * @Since: 13-8-28 下午1:35
 * @Version: 1.0
 */
public class TopMenuBar extends JMenuBar {

    private JMenu startMenu;

    private JMenu helpMenu;

    private JMenu operationMenu;

    private JMenu toolMenu;

    public TopMenuBar() {
        super();

        startMenu = new JMenu();
        startMenu.setText("菜单");

        JMenuItem menuItem = new JMenuItem();
        menuItem.setText("创建新密码本...    ");
        menuItem.addActionListener(new NoteMenuAction(null, true));
        startMenu.add(menuItem);

        startMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("打开密码本...    ");
        menuItem.addActionListener(new NoteMenuAction(null, false));
        startMenu.add(menuItem);

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
        startMenu.add(recentNote);
        startMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("设置密码本目录...    ");
        menuItem.setActionCommand(NotesFolderSettingDialog.class.getName());
        menuItem.addActionListener(new OpenDialogAction());
        startMenu.add(menuItem);
        startMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("退出");
        menuItem.addActionListener(new ExitAction());
        startMenu.add(menuItem);

        this.add(startMenu);

        toolMenu = new JMenu();
        toolMenu.setText("工具");

        menuItem = new JMenuItem();
        menuItem.setText("电子书转换    ");
        menuItem.addActionListener(new LoadReaderPanelAction());
        toolMenu.add(menuItem);

        toolMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("二维码生成    ");
        menuItem.addActionListener(new LoadQrPanelAction());
        toolMenu.add(menuItem);

        this.add(toolMenu);

        helpMenu = new JMenu();
        helpMenu.setText("帮助");
        menuItem = new JMenuItem();
        menuItem.setText("关于humpback");
        helpMenu.add(menuItem);

        this.add(helpMenu);
    }

    public void addOperationMenus() {

        if (this.operationMenu != null) {
            return;
        }

        operationMenu = new JMenu();
        operationMenu.setText("操作");

        JMenuItem menuItem = new JMenuItem();
        menuItem.setText("添加账号...    ");
        menuItem.setActionCommand(AccountDialog.class.getName());
        menuItem.addActionListener(new OpenDialogAction());
        operationMenu.add(menuItem);

        operationMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("修改密码...    ");
        menuItem.setActionCommand(ModifyPwdDialog.class.getName());
        menuItem.addActionListener(new OpenDialogAction());
        operationMenu.add(menuItem);

        operationMenu.addSeparator();

        menuItem = new JMenuItem();
        menuItem.setText("注销    ");
        menuItem.addActionListener(new LogoutAction());
        operationMenu.add(menuItem);

        this.removeAll();
        this.add(startMenu);
        this.add(operationMenu);
        this.add(toolMenu);
        this.add(helpMenu);
    }

    public void removeOperationMenus() {
        this.operationMenu = null;
        this.removeAll();
        this.add(startMenu);
        this.add(toolMenu);
        this.add(helpMenu);
    }

}
