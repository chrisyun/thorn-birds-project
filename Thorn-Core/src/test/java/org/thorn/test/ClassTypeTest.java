package org.thorn.test;

public class ClassTypeTest {

    /**
     * @param args
     */
    public static void main(String[] args) {
        ClassTypeTest test = new ClassTypeTest();
        
        int a = 3;
        test.test(a);
        
        short c = 9;
        
        Short b = new Short(c);
        test.test(b);
    }
    
    public void test(Object obj) {
        System.out.println(obj instanceof Integer);
        System.out.println(obj.getClass().isPrimitive());
        System.out.println(int.class.isPrimitive());
        System.out.println(Integer.class.isPrimitive());
    }
    
    

}
