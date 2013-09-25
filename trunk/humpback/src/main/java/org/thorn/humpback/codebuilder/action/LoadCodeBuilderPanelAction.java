package org.thorn.humpback.codebuilder.action;

import org.thorn.humpback.codebuilder.view.ExecuteSqlPanel;
import org.thorn.humpback.codebuilder.view.RenderTemplatePanel;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import java.awt.event.ActionEvent;

/**
 * @Author: yfchenyun
 * @Since: 13-9-12 下午1:48
 * @Version: 1.0
 */
public class LoadCodeBuilderPanelAction extends AbsAction {

    public LoadCodeBuilderPanelAction() {
        super(Context.MAIN_FRAME);
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        JPanel panel = new ExecuteSqlPanel();
//        JPanel panel = new RenderTemplatePanel();
        Context.MAIN_FRAME.setMainPane(panel);
    }
}
