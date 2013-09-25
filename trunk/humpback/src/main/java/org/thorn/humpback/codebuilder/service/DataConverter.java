package org.thorn.humpback.codebuilder.service;

import org.thorn.humpback.codebuilder.entity.Field;
import org.thorn.humpback.codebuilder.entity.RenderConfig;
import org.thorn.humpback.codebuilder.entity.RenderData;
import org.thorn.humpback.codebuilder.entity.TableConfig;

import java.util.List;

/**
 * @Author: yfchenyun
 * @Since: 13-9-22 下午1:54
 * @Version: 1.0
 */
public class DataConverter {

    public static RenderData convert(TableConfig tableConfig, RenderConfig renderConfig, List<Field> fieldList) {
        RenderData renderData = new RenderData();

        renderData.setName(renderConfig.getName());
        renderData.setPkg(renderConfig.getPkg());
        renderData.setTableName(tableConfig.getTableName());

        renderData.setFields(fieldList);

        return renderData;
    }

}
