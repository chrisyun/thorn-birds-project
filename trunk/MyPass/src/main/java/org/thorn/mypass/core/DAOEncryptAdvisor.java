package org.thorn.mypass.core;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.thorn.core.util.AESUtils;
import org.thorn.core.util.ReflectUtils;
import org.thorn.mypass.entity.BaseEntity;

@Aspect
public class DAOEncryptAdvisor {

    @Pointcut("execution(public * org.thorn.mypass.dao.*DAO.*(..))")
    private void pointcut() {
    };

    @Pointcut("!execution(public * org.thorn.mypass.dao.*DAO.delete*(..)) " +
            "&& !execution(public * org.thorn.mypass.dao.UserDAO.*(..))")
    private void noPointcut() {
    };

    @Around("pointcut() && noPointcut()")
    public Object doAround(ProceedingJoinPoint jp) throws Throwable {

        Object[] args = jp.getArgs();
        args = encryptParameters(args);

        Object result = jp.proceed(args);

        return decryptString(result);
    }

    private Object[] encryptParameters(Object[] args) throws Exception {

        if (args == null || args.length == 0) {
            return args;
        }

        for (int i = 0; i < args.length; i++) {
            args[i] = encryptString(args[i]);
        }

        return args;
    }

    private Object decryptString(Object result) throws Exception {

        if (result == null || result instanceof Integer) {
            return result;
        }

        if (result instanceof String) {
            String encrypt = Session.getCurrentSession().getEncrypt();
            return AESUtils.decrypt((String) result, encrypt);
        }

        if (result instanceof List) {

            List<Object> list = (List<Object>) result;

            for (int i = 0; i < list.size(); i++) {
                Object obj = list.get(i);
                obj = decryptString(obj);
                list.set(i, obj);
            }

            return list;
        }

        if (result instanceof BaseEntity) {

            Map<String, Object> map = ReflectUtils.object2Map(result);

            Set<String> keys = map.keySet();
            for (String key : keys) {
                map.put(key, decryptString(map.get(key)));
            }

            return ReflectUtils.map2Object(map, result.getClass());
        }

        return result;
    }

    private Object encryptString(Object obj) throws Exception {

        if (obj == null || obj instanceof Integer) {
            return obj;
        }

        if (obj instanceof String) {
            String encrypt = Session.getCurrentSession().getEncrypt();
            return AESUtils.encrypt((String) obj, encrypt);
        }

        if (obj instanceof BaseEntity) {

            Map<String, Object> map = ReflectUtils.object2Map(obj);

            Set<String> keys = map.keySet();
            for (String key : keys) {
                map.put(key, encryptString(map.get(key)));
            }

            return ReflectUtils.map2Object(map, obj.getClass());
        }

        return obj;
    }

}
