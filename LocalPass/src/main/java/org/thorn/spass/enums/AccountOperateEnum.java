package org.thorn.spass.enums;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 下午2:56
 * @Version: 1.0
 */
public enum AccountOperateEnum {

    ADD("添加"), MODIFY("修改"), DELETE("删除");

    private String name;

    private AccountOperateEnum(String name) {
        this.name = name;
    }
}
