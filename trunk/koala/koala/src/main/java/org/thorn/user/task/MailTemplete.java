package org.thorn.user.task;

import java.io.IOException;
import java.util.Map;

import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.thorn.core.context.SpringContext;
import org.thorn.core.jmail.MailCard;
import org.thorn.core.jmail.MailEntity;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @ClassName: MailTemplete
 * @Description:
 * @author chenyun
 * @date 2012-8-9 下午03:39:19
 */
public class MailTemplete {

	public static String getMailTemplate(String templateName,
			Map<String, Object> data) throws IOException, TemplateException {
		FreeMarkerConfigurer freeMarkerConfigurer = SpringContext
				.getBean("freeMarkerConfigurer");

		Configuration configuration = freeMarkerConfigurer.getConfiguration();

		Template t = configuration.getTemplate(templateName);
		return FreeMarkerTemplateUtils.processTemplateIntoString(t, data);
	}

	public static MailEntity getMailEntity(String templateName,
			Map<String, Object> data, String title, String receiverName,
			String receiver) throws IOException, TemplateException {
		MailEntity mail = new MailEntity();

		MailCard card = new MailCard(receiver, receiverName);
		mail.getReceiver().add(card);

		mail.setSubject(title);
		mail.setContent(getMailTemplate(templateName, data));

		return mail;
	}

}
