package org.thorn.spass.view;

import org.thorn.core.swing.GlobalSettingUtils;
import org.thorn.core.swing.ImageUtils;
import org.thorn.spass.listener.TagSearchAction;

import javax.swing.*;
import java.awt.*;

/**
 * @Author: yfchenyun
 * @Since: 13-8-26 下午2:58
 * @Version: 1.0
 */
public class MFrame extends JFrame {

    public static MFrame MAIN_FRAME = null;

    private JPanel contentPane;

    public MFrame() throws HeadlessException {
        super();

        MAIN_FRAME = this;

        GlobalSettingUtils.initGlobalFontSetting(new Font("微软雅黑", Font.PLAIN, 13));

        this.setTitle("LocalPass");
        this.setIconImage(ImageUtils.getIconFromCls("/icons/logo.png").getImage());
        this.setBounds(300, 100, 620, 500);

        this.contentPane = new JPanel();
        this.contentPane.setLayout(new BorderLayout(0, 0));
        this.setContentPane(this.contentPane);

        JMenuBar menuBar = new TopMenuBar();
        this.setJMenuBar(menuBar);
    }

    public void setMainPane(JPanel contentPane) {

        TagSearchAction.clearSelectedTags();

        this.contentPane.removeAll();
        this.contentPane.add(contentPane);
        this.contentPane.updateUI();
    }

    public void removeMainPane() {
        TagSearchAction.clearSelectedTags();

        this.contentPane.removeAll();
        this.contentPane.updateUI();
    }
}
