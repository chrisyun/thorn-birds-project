package org.thorn.humpback.codebuilder.action;

import org.apache.commons.lang.StringUtils;
import org.thorn.humpback.codebuilder.entity.*;
import org.thorn.humpback.codebuilder.service.DataConverter;
import org.thorn.humpback.codebuilder.service.TemplateHandler;
import org.thorn.humpback.codebuilder.view.RenderTemplatePanel;
import org.thorn.humpback.frame.action.AbsAction;
import org.thorn.humpback.frame.service.Context;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-9-22 下午1:13
 * @Version: 1.0
 */
public class RenderTemplateAction extends AbsAction {

    private RenderTemplatePanel templatePanel;

    public RenderTemplateAction(RenderTemplatePanel templatePanel) {
        super(templatePanel);
        this.templatePanel = templatePanel;
    }

    @Override
    public void action(ActionEvent e) throws Exception {
        RenderConfig config = templatePanel.getFormData();

        if (StringUtils.isEmpty(config.getName())) {
            JOptionPane.showMessageDialog(templatePanel, "请输入模块名", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(config.getPkg())) {
            JOptionPane.showMessageDialog(templatePanel, "请输入包名", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(config.getTemplate())) {
            JOptionPane.showMessageDialog(templatePanel, "请选择模板目录", "错误", JOptionPane.WARNING_MESSAGE);
        } else if (StringUtils.isEmpty(config.getOutput())) {
            JOptionPane.showMessageDialog(templatePanel, "请选择输出目录", "错误", JOptionPane.WARNING_MESSAGE);
        } else {
            Context.put(RenderConfig.class.getName(), config);

            List<TemplateFile> templateFileList = new ArrayList<TemplateFile>();

            TemplateHandler templateHandler = new TemplateHandler(new File(config.getTemplate()));
            templateHandler.listFile(templateHandler.getTempFolder(), templateFileList);

            TableConfig tableConfig = (TableConfig) Context.get(TableConfig.class.getName());
            List<Field> fieldList = (List) Context.get(Field.class.getName());

            RenderData renderData = DataConverter.convert(tableConfig, config, fieldList);

            //输出目录的根目录
            File outputRoot = new File(config.getOutput(), config.getPkg().replaceAll("\\.", "/"));

            if(!outputRoot.exists()) {
                outputRoot.mkdirs();
            }

            for(TemplateFile templateFile : templateFileList) {

                String fileName = renderData.getNameFirLetterUc() + templateFile.getName() + "." + templateFile.getType();

                File folder = new File(outputRoot, templateFile.getFolder());
                if(!folder.exists()) {
                    folder.mkdirs();
                }

                File outputFile = new File(folder, fileName);
                outputFile.createNewFile();

                templateHandler.applyTemplate(renderData, templateFile, outputFile);
            }

            JOptionPane.showMessageDialog(templatePanel, "代码生成成功", "成功", JOptionPane.INFORMATION_MESSAGE);
        }
    }
}
