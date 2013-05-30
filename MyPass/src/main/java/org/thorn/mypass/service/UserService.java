package org.thorn.mypass.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.thorn.core.util.AESUtils;
import org.thorn.core.util.MD5Utils;
import org.thorn.dao.exception.DBAccessException;
import org.thorn.mypass.core.Configuration;
import org.thorn.mypass.core.Session;
import org.thorn.mypass.dao.UserDAO;
import org.thorn.mypass.entity.CommonResult;
import org.thorn.mypass.entity.User;

@Service("userService")
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public String[] getUserCombo() throws Exception {

        List<String> users = userDAO.getAllUserName();

        if (users != null && users.size() > 0) {

            String[] combo = new String[users.size()];

            for (int i = 0; i < users.size(); i++) {
                combo[i] = AESUtils.decrypt(users.get(i), Configuration.CORE_PASSWORD);
            }

            return combo;
        }

        return null;
    }
    
    public CommonResult<User> register(String username, String password) throws DBAccessException {
        
        CommonResult<User> result = new CommonResult<User>();
        username = username.toUpperCase();
        
        try {
            List<String> users = userDAO.getAllUserName();
            String encryptUsername = AESUtils.encrypt(username, Configuration.CORE_PASSWORD);
            String encryptPassword = MD5Utils.encodeByBASE64(password);
            encryptPassword = MD5Utils.encodeBySalt(encryptPassword, username);
            
            if(users.contains(encryptUsername)) {
                result.setSuccess(false);
                result.setMsg("该账号已经存在！");
            } else {
                // insert
                User user = new User();
                user.setPassword(encryptPassword);
                user.setUsername(encryptUsername);
                user.setUsedVersion(Configuration.BEGIN_VERSION);
                userDAO.saveUser(user);
                
                result.setSuccess(true);
                result.setData(user);
            }
        } catch (Exception e) {
            throw new DBAccessException(e);
        }
        
        return result;
    }
    
    
    public CommonResult<User> login(String username, String password) throws DBAccessException {

        CommonResult<User> result = new CommonResult<User>();

        username = username.toUpperCase();

        try {
            String encryptPassword = MD5Utils.encodeByBASE64(password);
            encryptPassword = MD5Utils.encodeBySalt(encryptPassword, username);

            String encryptUsername = AESUtils.encrypt(username, Configuration.CORE_PASSWORD);

            User user = userDAO.getUserByNameAndPassword(encryptUsername, encryptPassword);

            if (user != null) {
                user.setUsername(username);
                result.setSuccess(true);
                result.setData(user);

                // add Session
                Session.setSession(user, MD5Utils.encodeBySalt(password, username));

                // update time
                userDAO.modifyLoginTime(encryptUsername);
            } else {
                result.setSuccess(false);
                result.setMsg("登录密码错误！");
            }
        } catch (Exception e) {
            throw new DBAccessException(e);
        }

        return result;
    }
}
