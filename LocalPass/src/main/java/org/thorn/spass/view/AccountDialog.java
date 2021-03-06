package org.thorn.spass.view;

import org.apache.commons.lang.StringUtils;
import org.thorn.core.context.SpringContext;
import org.thorn.core.swing.PositionUtils;
import org.thorn.spass.entity.Account;
import org.thorn.spass.enums.AccountOperateEnum;
import org.thorn.spass.listener.AccountOperateAction;
import org.thorn.spass.listener.TagAddAction;
import org.thorn.spass.listener.TagSearchAction;
import org.thorn.spass.service.AccountService;

import javax.swing.*;
import java.awt.*;
import java.util.HashSet;
import java.util.Set;

/**
 * @Author: yfchenyun
 * @Since: 13-9-4 上午10:17
 * @Version: 1.0
 */
public class AccountDialog extends JDialog {

    private JTextField address;

    private JTextField username;

    private JTextField password;

    private JTextField tag;

    private JTextArea remark;

    private Account account;

    private static Dimension labelDimension = new Dimension(60, 27);

    private static Dimension textDimension = new Dimension(260, 27);

    public AccountDialog() {
        this(null);
    }

    public AccountDialog(Account account) {
        super(MFrame.MAIN_FRAME, true);
        this.setBounds(PositionUtils.locationInCenter(MFrame.MAIN_FRAME.getBounds(), 370, 350));

        this.account = account;

        String title = "修改账号";
        if (account == null) {
            title = "添加账号";
        }

        this.setTitle(title);

        JPanel contentPanel = new JPanel();

        Box formBox = Box.createVerticalBox();
        formBox.setBorder(BorderFactory.createEmptyBorder(5, 10, 5, 10));

        Box columnBox = Box.createHorizontalBox();
        JLabel label = new JLabel("地  址：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        address = new JTextField();
        address.setPreferredSize(textDimension);
        columnBox.add(address);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("账  号：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        username = new JTextField();
        username.setPreferredSize(textDimension);
        columnBox.add(username);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("密  码：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        password = new JTextField();
        password.setPreferredSize(textDimension);
        columnBox.add(password);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        columnBox = Box.createHorizontalBox();
        label = new JLabel("标  签：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        tag = new JTextField();
        tag.setPreferredSize(textDimension);
        columnBox.add(tag);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        AccountService accountService = SpringContext.getBean(AccountService.class);
        Set<String> tagSet = accountService.queryTags();

        if (tagSet != null && tagSet.size() > 0) {

            JPanel tagPanel = new JPanel();
            tagPanel.setLayout(new FlowLayout(FlowLayout.LEFT));
            tagPanel.setBorder(BorderFactory.createTitledBorder("选择已有标签"));

            for (String tag : tagSet) {
                JCheckBox checkBox = new JCheckBox(tag);

                checkBox.addItemListener(new TagAddAction(this.tag));
                tagPanel.add(checkBox);
            }

            JScrollPane scrollPane = new JScrollPane(tagPanel);
            scrollPane.setPreferredSize(new Dimension(320, 90));
            scrollPane.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
            formBox.add(scrollPane);
            formBox.add(Box.createVerticalStrut(10));
        }


        columnBox = Box.createHorizontalBox();
        label = new JLabel("备  注：");
        label.setPreferredSize(labelDimension);
        columnBox.add(label);

        remark = new JTextArea(4, 20);
        remark.setLineWrap(true);
        JScrollPane scrollPane = new JScrollPane(remark);
        columnBox.add(scrollPane);

        formBox.add(columnBox);
        formBox.add(Box.createVerticalStrut(10));

        Box rowBox = Box.createVerticalBox();
        scrollPane = new JScrollPane(formBox);
        scrollPane.setPreferredSize(new Dimension(370, 250));
        scrollPane.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
        rowBox.add(scrollPane);
        rowBox.add(Box.createVerticalStrut(15));

        columnBox = Box.createHorizontalBox();

        if (account == null) {
            JButton button = new JButton("创  建");
            button.addActionListener(new AccountOperateAction(this, AccountOperateEnum.ADD));
            columnBox.add(button);
        } else {
            JButton button = new JButton("修  改");
            button.addActionListener(new AccountOperateAction(this, AccountOperateEnum.MODIFY));
            columnBox.add(button);
            columnBox.add(Box.createHorizontalStrut(30));
            button = new JButton("删  除");
            button.addActionListener(new AccountOperateAction(this, AccountOperateEnum.DELETE));
            columnBox.add(button);

            address.setText(account.getAddress());
            username.setText(account.getUsername());
            password.setText(account.getPassword());
            remark.setText(account.getRemark());

            String tags = "";
            for (String str : account.getTag()) {
                tags += str + "#";
            }
            tag.setText(tags);
        }
        rowBox.add(columnBox);
        contentPanel.add(rowBox);

        this.setContentPane(contentPanel);
        this.setResizable(false);
        this.setVisible(true);
    }

    public Account getFormData() {
        Account ac = new Account();

        if (this.account != null) {
            ac.setId(this.account.getId());
        }

        String tags = this.tag.getText();
        String[] tagArray = StringUtils.split(tags, "#");

        ac.setAddress(this.address.getText());
        ac.setUsername(this.username.getText());
        ac.setPassword(this.password.getText());
        ac.setTag(new HashSet<String>());
        ac.setRemark(this.remark.getText());

        for (String tag : tagArray) {

            if (StringUtils.isNotBlank(tag)) {
                ac.getTag().add(tag);
            }
        }

        return ac;
    }


}
