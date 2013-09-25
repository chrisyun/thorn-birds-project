package org.thorn.humpback.codebuilder.entity;

/**
 * @Author: yfchenyun
 * @Since: 13-9-22 下午1:23
 * @Version: 1.0
 */
public class RenderConfig {

    private String output;

    private String name;

    private String pkg;

    private String template;

    public RenderConfig() {
    }

    public RenderConfig(String output, String name, String pkg, String template) {
        this.output = output;
        this.name = name;
        this.pkg = pkg;
        this.template = template;
    }

    public String getOutput() {
        return output;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPkg() {
        return pkg;
    }

    public void setPkg(String pkg) {
        this.pkg = pkg;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }
}
