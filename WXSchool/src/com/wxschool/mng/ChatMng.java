package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ChatTextDao;
import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Page;

public class ChatMng extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String ac = request.getParameter("ac");
		ChatTextDao chatDao = new ChatTextDao();

		if (ac.equals("lista")) {
			Object[][] accounts = chatDao.getAccountData();

			request.setAttribute("accounts", accounts);
			request.getRequestDispatcher("/mng/chatMsg_accountList.jsp")
					.forward(request, response);
		} else if (ac.equals("listm")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = chatDao.getTotalRecord(wxaccount);
			Page page = new Page(curPage, 20, totalRecord);

			List<ChatRecord> chatRecords = chatDao.getMsgRecords(wxaccount,
					page);

			request.setAttribute("page", page);
			request.setAttribute("chatRecords", chatRecords);
			request.getRequestDispatcher("/mng/chatMsgList.jsp").forward(
					request, response);
		} else if (ac.equals("listmu")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");
			String userwx = request.getParameter("userwx");
			String to = request.getParameter("to");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = chatDao
					.getTotalRecord_user(wxaccount, userwx, to);
			Page page = new Page(curPage, 20, totalRecord);

			List<ChatRecord> chatRecords = chatDao.getMsgRecords_user(
					wxaccount, userwx, to, page);

			request.setAttribute("page", page);
			request.setAttribute("chatRecords", chatRecords);
			request.getRequestDispatcher("/mng/chatMsgList_user.jsp").forward(
					request, response);
		} else if (ac.equals("listmus")) {
			String wxaccount = request.getParameter("wxaccount");
			String userwx = request.getParameter("userwx");

			List<ChatRecord> chatRecords = chatDao.getChatList_mng(wxaccount,
					userwx);

			request.setAttribute("chatRecords", chatRecords);
			request.getRequestDispatcher("/mng/chatMsgList_users.jsp").forward(
					request, response);
		}
	}
}
