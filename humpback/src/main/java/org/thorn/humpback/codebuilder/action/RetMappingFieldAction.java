package org.thorn.humpback.codebuilder.action;

import org.thorn.humpback.codebuilder.view.MappingFieldPanel;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;
import org.thorn.humpback.frame.view.MainFrame;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-22 下午1:11
 * @Version: 1.0
 */
public class RetMappingFieldAction extends AbsAction {

    public RetMappingFieldAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        MainFrame frame = Context.MAIN_FRAME;
        JPanel mappingPanel = new MappingFieldPanel();
        frame.setMainPane(mappingPanel);
    }
}
