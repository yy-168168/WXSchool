package com.wxschool.dpo;

import java.util.*;
import org.dom4j.*;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;
import com.wxschool.util.*;

public class TranslateService {

	public String computeReceive(String wxaccount, String receiveContent) {
		String replyContent = "翻译的格式为：#您要翻译的词。如：#我爱你  or #I love you";
		String word = receiveContent.substring(1);
		if (!word.equals("")) {
			AccountDao aDao = new AccountDao();
			aDao.updateFiled(wxaccount, "translate", 1);
			aDao = null;

			replyContent = translate(word);
		}
		return replyContent;
	}

	public String translate(String word) {

		String content = "翻译失败\n可能出现原因：翻译的文本过长，输入无效字符，不支持的语言类型，没有网络\n\n数据来源：有道翻译";
		String url = "http://fanyi.youdao.com/openapi.do";
		String paras = "keyfrom=hsdwechat&key=1622274335&type=data&doctype=xml&version=1.1&q="
				+ word;
		try {
			String xml = HttpUtils.doGet(url, paras, "UTF-8");
			content = analysisXml(xml);
		} catch (DocumentException e) {
		} catch (NullPointerException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "word:" + word);
		}
		return content;
	}

	@SuppressWarnings("unchecked")
	private String analysisXml(String xml) throws DocumentException,
			NullPointerException {

		StringBuffer sb = new StringBuffer("基本释义：\n");
		Document document = null;
		document = DocumentHelper.parseText(xml);

		Element root = document.getRootElement();

		Element basic = root.element("basic").element("explains");
		Iterator<Element> els1 = basic.elementIterator("ex");
		while (els1.hasNext()) {
			String ex = els1.next().getText();
			sb.append(ex + "\n");
		}

		sb.append("网络释义：\n");
		Element web = root.element("web").element("explain").element("value");
		Iterator<Element> els2 = web.elementIterator("ex");
		while (els2.hasNext()) {
			String ex = els2.next().getText();
			sb.append(ex + "\n");
		}
		sb.append("\n数据来源：有道翻译");

		return sb.toString();
	}

	public static void main(String[] args) {
		System.out.println(new TranslateService().translate("我是你问"));
	}
}
