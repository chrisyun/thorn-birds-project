package org.thorn.test.excel;

import java.io.Serializable;
import java.util.Date;

public class Student implements Serializable {
    
    /**
     * 
     */
    private static final long serialVersionUID = 7694285544956491441L;

    private String name;
    
    private Integer age;
    
    private Date birthday;
    
    private String sex;
    
    public Student(String name, String sex, Integer age, Date birthday) {
        this.name = name;
        this.sex = sex;
        this.age = age;
        this.birthday = birthday;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
