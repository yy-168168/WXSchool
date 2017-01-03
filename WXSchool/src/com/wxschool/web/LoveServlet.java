package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.misc.BASE64Encoder;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.BlackDao;
import com.wxschool.dao.ReplyDao;
import com.wxschool.dao.VoteDao;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.*;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class LoveServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		VoteDao vDao = new VoteDao();

		if (ac == null) {
		} else if (ac.equals("list")) {
			String topicId = request.getParameter("topicId");
			String orderBy = request.getParameter("orderBy");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			String s_orderBy = "";
			if (orderBy == null || orderBy.equals("null")
					|| orderBy.equals("1")) {
				s_orderBy = "voteId";
			} else if (orderBy.equals("2")) {
				s_orderBy = "supportNum";
			} else if (orderBy.equals("3")) {
				s_orderBy = "opposeNum";
			} else if (orderBy.equals("4")) {
				s_orderBy = "replyNum";
			}

			int totalRecord = vDao
					.getTotalRecordByStatus(wxaccount, topicId, 1);
			Page page = new Page(curPage, 20, totalRecord);
			request.setAttribute("page", page);

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			AccountDao accountDao = new AccountDao();
			Account account = accountDao.getAccount(wxaccount);

			if (account != null && account.isAuth()) {// 认证
				List<Vote> vs = vDao.getVotesAndWxuser(wxaccount, topicId,
						s_orderBy, page);

				request.setAttribute("vs", vs);
				request.getRequestDispatcher(
						"/vote/listBB_auth.jsp?token=" + token).forward(
						request, response);
			} else {
				List<Vote> vs = vDao.getVotesByStatus(wxaccount, topicId,
						s_orderBy, page, 1);

				request.setAttribute("vs", vs);
				request.getRequestDispatcher(
						"/vote/listbiaobai.jsp?token=" + token).forward(
						request, response);
			}
			accountDao = null;
		} else if (ac.equals("listReply")) {
			String voteId = request.getParameter("voteId");

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			Page page = new Page(1, 1000, 1000);
			ReplyDao replyDao = new ReplyDao();

			AccountDao accountDao = new AccountDao();
			Account account = accountDao.getAccount(wxaccount);

			if (account != null && account.isAuth()) {// 认证
				Vote vote = vDao.getVoteAndWxuser(voteId);
				request.setAttribute("vote", vote);

				List<Reply> replys = replyDao.getReplysAndWxuser(voteId, 2,
						page);
				request.setAttribute("replys", replys);

				request.getRequestDispatcher(
						"/vote/listBBReply_auth.jsp?token=" + token).forward(
						request, response);
			} else {
				Vote vote = vDao.getVote(voteId);
				request.setAttribute("vote", vote);

				List<Reply> replys = replyDao.getReplys(voteId, 2, page);
				request.setAttribute("replys", replys);

				request.getRequestDispatcher(
						"/vote/listbreply.jsp?token=" + token).forward(request,
						response);
			}
			accountDao = null;
			replyDao = null;
		} else if (ac.equals("my")) {
			String topicId = request.getParameter("topicId");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			int totalRecord = vDao.getTotalRecordByUserwx(wxaccount, userwx,
					topicId);
			Page page = new Page(curPage, 20, totalRecord);
			request.setAttribute("page", page);

			AccountDao accountDao = new AccountDao();
			Account account = accountDao.getAccount(wxaccount);

			if (account != null && account.isAuth()) {// 认证
				List<Vote> vs = vDao.getVotesAndWxuserByUserwx(wxaccount,
						userwx, topicId, page);

				request.setAttribute("vs", vs);
				request.getRequestDispatcher(
						"/vote/listBB_auth.jsp?token=" + token).forward(
						request, response);
			} else {
				List<Vote> vs = vDao.getVotesByUserwx(wxaccount, userwx,
						topicId, page);

				request.setAttribute("vs", vs);
				request.getRequestDispatcher(
						"/vote/listbiaobai.jsp?token=" + token).forward(
						request, response);
			}
		}
		vDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		VoteDao vDao = new VoteDao();

		if (ac == null) {
		} else if (ac.equals("addBB")) {
			String content = request.getParameter("content");
			String name = request.getParameter("name");
			String topicId = request.getParameter("topicId");

			if (topicId == null) {
				return;
			}

			String result = "";
			BlackDao blackDao = new BlackDao();
			boolean isBlack = blackDao.isBlack(wxaccount, userwx, "2");

			if (isBlack) {
				result = "black";
			} else {
				Vote v = new Vote();
				v.setContent(content);
				v.setName(name);
				v.setTopicId(Integer.parseInt(topicId));
				v.setUserwx(userwx);
				v.setWxaccount(wxaccount);
				v.setStatus(1);

				int num = vDao.getMaxNum(wxaccount, topicId);
				v.setNum(num + 1);

				result = vDao.addVote(v) + "";
			}
			blackDao = null;

			BackJs.backJs(result, response);
		} else if (ac.equals("addBReply")) {
			String content = request.getParameter("content");
			String voteId = request.getParameter("voteId");
			String receiver = request.getParameter("receiver");
			String isTrueName = request.getParameter("isTrueName");

			if (voteId == null) {
				return;
			}

			isTrueName = isTrueName == null ? "0" : isTrueName;

			Reply reply = new Reply();
			reply.setContent(content);
			reply.setQuesId(Integer.parseInt(voteId));
			reply.setUserwx(userwx);
			reply.setWxaccount(wxaccount);
			reply.setOther(isTrueName);
			reply.setType(2);

			ReplyDao replyDao = new ReplyDao();
			int num = replyDao.getMaxNum_reply(voteId, 2);
			reply.setNum(num + 1);

			boolean result = replyDao.addReply(reply);
			replyDao = null;
			
			if (result) {
				vDao.updateFiled(voteId, "replyNum");// 评论数+1

				if (!receiver.equals(userwx)) {
					// 发送客服消息通知接收人
					WechatService wechatService = new WechatService();
					String token = wechatService.getAccessToken(wxaccount);

					if (token != null) {
						News news = new News();
						news.setTitle("有一个小伙伴儿回复了您的信息");
						news.setPicUrl("");
						news.setDescription("该消息来自【表白墙】");
						news.setUrl(Config.SITEURL
								+ "/mobile/love?ac=listReply&wxaccount="
								+ wxaccount + "&userwx=" + receiver
								+ "&voteId=" + voteId);
						wechatService.sendCustomMsg_news(token, wxaccount, receiver,
								news);
					}
				}
			}
			BackJs.backJs(result+"", response);
		}
		vDao = null;
	}
}
