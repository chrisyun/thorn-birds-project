package org.thorn.spass.listener;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.spass.service.LocationService;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-5 下午3:08
 * @Version: 1.0
 */
public class SettingNotesFolderAction extends AbsAction {

    private JTextField folder;

    private JDialog settingDialog;

    public SettingNotesFolderAction(Component parentComp, JTextField folder) {
        super(parentComp);
        this.folder = folder;
        this.settingDialog = (JDialog) parentComp;
    }

    @Override
    public void action(ActionEvent e) throws Exception {

        String folderPath = folder.getText();

        if (StringUtils.isEmpty(folderPath)) {
            JOptionPane.showMessageDialog(settingDialog, "请选择目录", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            LocationService locationService = SpringContext.getBean(LocationService.class);
            locationService.setNotesSaveFolder(folderPath);

            settingDialog.setVisible(false);
        }

    }
}
