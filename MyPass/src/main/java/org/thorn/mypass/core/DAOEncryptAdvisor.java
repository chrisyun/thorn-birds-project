package org.thorn.mypass.core;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.thorn.mypass.entity.User;

@Aspect
public class DAOEncryptAdvisor {
    
    @Pointcut("execution(public * org.thorn.mypass.dao.*DAO.*(..))")
    private void pointcut() {};
    
    @Pointcut("!execution(public * org.thorn.mypass.dao.*DAO.delete*(..))")
    private void noPointcut() {};
    
    @Around("pointcut() && noPointcut()")
    public Object doAround(ProceedingJoinPoint jp) throws Throwable {
        
        Object[] args = jp.getArgs();
        
        Object result = jp.proceed(new Object[] {"aa","bb"});
        
        User u = new User();
        
        u.setUsername("spring");
        
        return u;
    } 
    
    
}
