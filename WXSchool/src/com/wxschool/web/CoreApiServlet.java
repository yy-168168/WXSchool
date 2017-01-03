package com.wxschool.web;

import java.io.*;
import java.security.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import org.dom4j.*;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;

public class CoreApiServlet extends HttpServlet {

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

		String[] arrTmp = { TOKEN, timestamp, nonce };
		Arrays.sort(arrTmp);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < arrTmp.length; i++) {
			sb.append(arrTmp[i]);
		}
		String pwd = encrypt(sb.toString());

		if (pwd.equalsIgnoreCase(signature)) {
			out.print(echostr);
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

		StringBuffer sb = new StringBuffer();
		String line;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			Document document = DocumentHelper.parseText(sb.toString());

			Element root = document.getRootElement();

			String resultStr = operateMsgType(root);

			out.print(resultStr);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String operateMsgType(Element root) throws Exception {

		String msgType = root.elementText("MsgType");
		String user = root.elementText("FromUserName");
		String developer = root.elementText("ToUserName");

		MsgReceiveManager mrm = new MsgReceiveManager();

		LogDao.getLog().addNorLog("该接口将作废，账号：" + developer);

		String result = checkPermission(user, developer);// 权限验证
		if (result.equals("allow")) {
			if (msgType.equals("event")) {
				String event = root.elementText("Event");
				String eventKey = root.elementText("EventKey");

				if (event.equals("pic_photo_or_album")) {// 弹出拍照或者相册发图的事件推送
					// Element sendPicsInfo = root.element("SendPicsInfo");
					// String count = sendPicsInfo.elementText("Count");
				}

				result = mrm.computeEvent(user, developer, event, eventKey);
			} else if (msgType.equals("text")) {
				String receiveContent = root.elementTextTrim("Content").trim();
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
		}

		mrm = null;
		return result;
	}

	// 权限验证
	private String checkPermission(String user, String developer) {
		AccountDao aDao = new AccountDao();
		String isValid = aDao.isAccessOfClient(developer);
		String replyContent = "";
		String replyXml = "";

		if (isValid.equals("illegal")) {
			replyContent = "接口有效时间已到，请告知管理员！";
			replyXml = MsgSendManager.instance().replyText(user, developer,
					replyContent);
		} else if (isValid.equals("error")) {
			replyContent = "亲，你真幸运，刚好机器怠机，请稍后再试.";
			replyXml = MsgSendManager.instance().replyText(user, developer,
					replyContent);
		} else {
			replyXml = "allow";
		}
		aDao = null;
		return replyXml;
	}

	private String encrypt(String strSrc) {
		String strDes = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			strDes = byte2hexString(md.digest(strSrc.getBytes()));
		} catch (NoSuchAlgorithmException e) {
		}
		return strDes;
	}

	private final String byte2hexString(byte[] bytes) {
		StringBuffer buf = new StringBuffer(bytes.length * 2);
		for (int i = 0; i < bytes.length; i++) {
			if (((int) bytes[i] & 0xff) < 0x10) {
				buf.append("0");
			}
			buf.append(Long.toString((int) bytes[i] & 0xff, 16));
		}
		return buf.toString().toUpperCase();
	}
}
