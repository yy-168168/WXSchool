package com.wxschool.web;

import java.io.*;
import java.security.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import org.dom4j.*;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Account;
import com.wxschool.entity.OperateRecord;
import com.wxschool.util.CommonUtil;

public class CoreServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/*
	 * 加密/校验流程如下：
	 * 
	 * @1.将token、timestamp、nonce三个参数进行字典序排序
	 * 
	 * @2.将三个参数字符串拼接成一个字符串进行sha1加密
	 * 
	 * @3.开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String TOKEN = "wxschool";

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");

		if (signature == null || timestamp == null || nonce == null
				|| echostr == null) {
			out.print("");
		} else {
			String[] arrTmp = { TOKEN, timestamp, nonce };
			Arrays.sort(arrTmp);
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < arrTmp.length; i++) {
				sb.append(arrTmp[i]);
			}

			String pwd = "";
			try {
				// pwd = encrypt(sb.toString());
				pwd = CommonUtil.encryptAHA1(sb.toString());
			} catch (NoSuchAlgorithmException e) {
				LogDao.getLog().addExpLog(e, "加密/校验出错");
			}

			if (pwd.equalsIgnoreCase(signature)) {
				out.print(echostr);
			} else {
				out.print("");
			}
		}

		out.flush();
		out.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String resultStr = null;

		try {
			StringBuffer sb = new StringBuffer();
			BufferedReader reader = request.getReader();

			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}

			Document document = DocumentHelper.parseText(sb.toString());

			Element root = document.getRootElement();

			resultStr = operateMsgType(root);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "返回消息出错");
		}
		
		out.print(resultStr);
		out.flush();
		out.close();
	}

	private String operateMsgType(Element root) throws Exception {

		String msgType = root.elementText("MsgType");
		String user = root.elementText("FromUserName");
		String developer = root.elementText("ToUserName");

		AccountDao accountDao = new AccountDao();
		Account account = accountDao.getAccount(developer);

		String result = "";
		if (account == null) {// 出错
			result = MsgSendManager.instance().replyText(user, developer,
					"出错啦，请稍后重试");
		} else if (account.getWxAccount() == null) {// 没有此账号
			result = MsgSendManager.instance().replyText(user, developer,
					"没有接口权限");
		} else {
			MsgReceiveManager mrm = new MsgReceiveManager();

			String operateContent = "";
			if (msgType.equals("event")) {
				String event = root.elementText("Event");
				String eventKey = root.elementText("EventKey");

				if (event == null) {
					LogDao.getLog().addNorLog("event为空" + root.asXML());
				}

				if (event.equals("pic_photo_or_album")) {// 弹出拍照或者相册发图的事件推送
					// Element sendPicsInfo = root.element("SendPicsInfo");
					// String count = sendPicsInfo.elementText("Count");
				}

				operateContent = event + "  " + eventKey;
				result = mrm.computeEvent(user, developer, event, eventKey);
			} else if (msgType.equals("text")) {
				String receiveContent = root.elementTextTrim("Content").trim();
				operateContent = receiveContent;
				result = mrm.computeText(user, developer, receiveContent);
			} else if (msgType.equals("image")) {
				String picUrl = root.elementText("PicUrl");
				String mediaId = root.elementText("MediaId");
				result = mrm.computeImage(user, developer, picUrl, mediaId);
			} else if (msgType.equals("voice")) {
				String format = root.elementText("Format");
				String mediaId = root.elementText("MediaId");
				result = mrm.computeVoice(user, developer, format, mediaId);
			} else if (msgType.equals("video")) {
				String thumbMediaId = root.elementText("ThumbMediaId");
				String mediaId = root.elementText("MediaId");
				result = mrm.computeVideo(user, developer, thumbMediaId,
						mediaId);
			} else if (msgType.equals("location")) {
				String location_X = root.elementText("Location_X");
				String location_Y = root.elementText("Location_Y");
				String scale = root.elementText("Scale");
				String label = root.elementText("Label");
				result = mrm.computeLocation(user, developer, location_X,
						location_Y, scale, label);
			} else if (msgType.equals("link")) {
				String title = root.elementText("Title");
				String description = root.elementText("Description");
				String url = root.elementText("Url");
				result = mrm.computeLink(user, developer, title, description,
						url);
			}

			OperateRecord record = new OperateRecord();
			record.setWxaccount(developer);
			record.setUserwx(user);
			record.setType(msgType);
			record.setContent(operateContent);
			mrm.afterCompute(record, account.isAuth());
			mrm = null;
		}

		accountDao = null;
		return result;
	}

}
