package org.thorn.mypass.view;

import javax.swing.JPasswordField;

/** 
 * @ClassName: ModifyPasswordDialog 
 * @Description: 
 * @author chenyun
 * @date 2013-5-14 下午10:16:23 
 */
public class ModifyPasswordDialog extends CommonDialog {
    
    private JPasswordField oldPwdField;
    
    private JPasswordField pwdField;

    private JPasswordField pwdRpField;
    
    public ModifyPasswordDialog() {
	super(320, 200);
    }
    
}

