package com.wxschool.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.BlackDao;
import com.wxschool.dao.ChatTextDao;
import com.wxschool.dao.WxUserDao;
import com.wxschool.dpo.ChatMsgSendTimer;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Config;
import com.wxschool.entity.Page;
import com.wxschool.entity.WxUser;
import com.wxschool.util.BackJs;

public class ChatTextServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		if (ac == null) {
		} else if (ac.equals("updateWxUserInfo")) {
			boolean isSuccess = false;

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);

			if (token != null) {
				WxUser user = wechatService.getUserInfo(token, userwx);

				if (user != null) {
					user.setWxaccount(wxaccount);
					WxUserDao wxUserDao = new WxUserDao();
					isSuccess = wxUserDao.updateUser(user);
					wxUserDao = null;
				}
			}
			wechatService = null;
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("beSearch")) {
			String status = request.getParameter("status");

			WxUserDao wxUserDao = new WxUserDao();
			boolean isSuccess = wxUserDao.updateField(wxaccount, userwx,
					"beSearch", status);
			wxUserDao = null;
			BackJs.backJs(isSuccess + "", response);
		} else if (ac.equals("chat")) {
			String to = request.getParameter("to");
			String userId = to.substring(36);
			WxUserDao wxUserDao = new WxUserDao();
			wxUserDao.updateFieldByUserId(wxaccount, userId, "countOfSee");// 被查看
			String[] user = wxUserDao.getUser_detail_userId(wxaccount, userId,
					1);
			wxUserDao = null;

			request.setAttribute("user", user);
			request.getRequestDispatcher("/reply/chatOne.jsp").forward(request,
					response);
		} else if (ac.equals("list")) {
			String to = request.getParameter("to");
			String userId = to.substring(36);

			WxUserDao wxUserDao = new WxUserDao();
			String[] user = wxUserDao.getUser_detail_userId(wxaccount, userId,
					1);
			wxUserDao = null;

			request.setAttribute("user", user);
			request.getRequestDispatcher("/reply/chatTwo.jsp").forward(request,
					response);
		} else if (ac.equals("oldRecord")) {
			String msgId = request.getParameter("msgId");
			String to = request.getParameter("to");

			ChatTextDao chatDao = new ChatTextDao();
			chatDao.changeStatus(wxaccount, userwx, to);
			List<ChatRecord> records = chatDao.getReadRecords(wxaccount,
					userwx, to, msgId, 20);
			chatDao = null;

			BackJs.backJs(JSONArray.toJSONString(records), response);
		} else if (ac.equals("curRecord")) {
			String msgId = request.getParameter("msgId");
			String to = request.getParameter("to");

			ChatTextDao chatDao = new ChatTextDao();
			List<ChatRecord> records = chatDao.getUnreadRecords(wxaccount,
					userwx, to, msgId);
			chatDao.changeStatus(wxaccount, userwx, to);
			chatDao = null;

			BackJs.backJs(JSONArray.toJSONString(records), response);
		} else if (ac.equals("wxInfo")) {
			WxUserDao wxUserDao = new WxUserDao();
			WxUser user = wxUserDao.getUser_simple(wxaccount, userwx);
			wxUserDao = null;

			request.setAttribute("user", user);
			request.getRequestDispatcher("/reply/wxInfo.jsp").forward(request,
					response);
		} else if (ac.equals("chatList")) {// 纸条记录
			String s_curPage = request.getParameter("c_p");

			Page page = new Page(Integer.parseInt(s_curPage), 16, 0);

			ChatTextDao chatDao = new ChatTextDao();
			List<ChatRecord> chatList = chatDao.getChatList(wxaccount, userwx,
					page);
			chatDao = null;

			BackJs.backJs(JSONArray.toJSONString(chatList), response);
		} else if (ac.equals("chatUser")) {// 随机匹配
			WxUserDao wxUserDao = new WxUserDao();
			WxUser wxUser = wxUserDao.getUser_simple(wxaccount, userwx);

			List<ChatRecord> chatUsers = new ArrayList<ChatRecord>();
			if (wxUser != null) {
				int sex = wxUser.getSex();
				sex = sex == 0 ? 0 : sex == 1 ? 2 : 1;
				int level = Math.random() > 0.4 ? 1 : 0;
				chatUsers = wxUserDao.getChatUsers(wxaccount, sex,
						Config.WECHATCUSTOMMSGVALIDTIME, level, 30);
			}
			wxUser = null;
			wxUserDao = null;

			request.setAttribute("chatUsers", chatUsers);
			request.getRequestDispatcher("/reply/chatUser.jsp").forward(
					request, response);
		} else if (ac.equals("searchUser")) {// 查找
			String keyword = request.getParameter("keyword");

			WxUserDao wxUserDao = new WxUserDao();
			String[][] chatUsers = wxUserDao.searchUsersByStuinfo(wxaccount,
					keyword, 30);
			wxUserDao = null;

			BackJs.backJs(JSONArray.toJSONString(chatUsers), response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		if (ac == null) {
		} else if (ac.equals("addRecord")) {
			String content = request.getParameter("content");
			String to = request.getParameter("to");
			String isFirstSend = request.getParameter("isFirstSend");

			BlackDao blackDao = new BlackDao();
			boolean isBlack = blackDao.isBlack(wxaccount, userwx, "1");

			String result = "";
			if (isBlack) {
				result = "black";
			} else {
				ChatRecord record = new ChatRecord();
				record.setContent(content);
				record.setFrom(userwx);
				record.setTo(to);
				record.setStatus(21);
				record.setWxaccount(wxaccount);

				ChatTextDao chatDao = new ChatTextDao();
				result = chatDao.addRecord(record) + "";
				chatDao = null;

				if (isFirstSend == null || isFirstSend.equals("true")) {
					// 发送客服消息
					Timer timer = new Timer();
					ChatMsgSendTimer task = new ChatMsgSendTimer(record);
					timer.schedule(task, 60 * 1000);// 延时60秒执行
				}
			}
			blackDao = null;

			BackJs.backJs(result, response);
		}
	}
}
