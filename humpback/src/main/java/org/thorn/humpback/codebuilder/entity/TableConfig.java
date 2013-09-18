package org.thorn.humpback.codebuilder.entity;

/**
 * @Author: yfchenyun
 * @Since: 13-9-18 下午2:52
 * @Version: 1.0
 */
public class TableConfig {

    private String sql;

    private String tableName;

    private Boolean override;

    public TableConfig() {
    }

    public TableConfig(String sql, String tableName, Boolean override) {
        this.sql = sql;
        this.tableName = tableName;
        this.override = override;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Boolean getOverride() {
        return override;
    }

    public void setOverride(Boolean override) {
        this.override = override;
    }
}
