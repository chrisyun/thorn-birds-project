package org.thorn.mypass.test;

import java.util.Map;

import org.thorn.core.util.ReflectUtils;
import org.thorn.mypass.entity.Group;

import junit.framework.TestCase;

public class ReflectTest extends TestCase {

    public void testReflect() {
        Group group = new Group("a", "b");
        
        Map<String, Object> map = ReflectUtils.object2Map(group);
        
        for (String key : map.keySet()) {
            System.out.println(key + "---" + map.get(key));
        }
        
        
    }
    
    
}
