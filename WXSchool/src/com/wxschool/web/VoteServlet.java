package com.wxschool.web;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.*;
import com.wxschool.entity.*;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class VoteServlet extends HttpServlet {

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
		} else if (ac.equals("addSupportNum")) {
			String reply = "no";// 不能投
			String token = request.getParameter("token");
			if (token == null || token.equals("") || token.equals("null")) {
			} else {
				String topicId = request.getParameter("topicId");
				TopicDao topicDao = new TopicDao();
				boolean isGoon = false;// 是否继续
				if (topicId.equals("-1")) {// 不用判断过期时间的活动
					isGoon = true;
				} else {
					int hasExpire = topicDao.hasExpire(topicId);// 是否过期
					if (hasExpire == 2) {
						reply = "expire";// 过期
					} else if (hasExpire == 1) {
						isGoon = true;
					} else {
						reply = "wrong";// 错误
					}
				}

				if (isGoon) {
					String token_decoder = new String(new BASE64Decoder()
							.decodeBuffer(token.substring(6)));

					if (userwx.equals(token_decoder)) {
						String voteId = request.getParameter("voteId");
						int hasTodayVote = vDao.hasTodayVote(voteId, wxaccount,
								userwx);
						if (hasTodayVote == 0) {// 没投过
							boolean b = vDao.addVotePerson(voteId, wxaccount,
									userwx);
							if (b) {
								vDao.updateFiled(voteId, "supportNum");
								topicDao.updatePersonNum(topicId);
							}
							reply = "yes";// 可投
						} else if (hasTodayVote == -1) {// 当天没投
							boolean b = vDao.updateVoteAccount(voteId,
									wxaccount, userwx);
							if (b) {
								vDao.updateFiled(voteId, "supportNum");
								topicDao.updatePersonNum(topicId);
							}
							reply = "yes";
						} else if (hasTodayVote == 1) {// 当天已投
							reply = "hasVote";// 已投
						}
					}
				}
				topicDao = null;
			}

			BackJs.backJs(reply, response);
		} else if (ac.equals("incOpposeNum")) {
			String reply = "no";
			String token = request.getParameter("token");
			if (token == null || token.equals("")) {
			} else {
				String topicId = request.getParameter("topicId");
				TopicDao topicDao = new TopicDao();
				boolean isGoon = false;
				if (topicId.equals("-1")) {// 不用判断过期时间的活动
					isGoon = true;
				} else {
					int hasExpire = topicDao.hasExpire(topicId);// 是否过期
					if (hasExpire == 2) {
						reply = "expire";// 过期
					} else if (hasExpire == 1) {
						isGoon = true;
					} else {
						reply = "wrong";// 错误
					}
				}

				if (isGoon) {
					String token_decoder = new String(new BASE64Decoder()
							.decodeBuffer(token.substring(6)));
					if (userwx.equals(token_decoder)) {
						String voteId = request.getParameter("voteId");
						int hasTodayVote = vDao.hasTodayVote(voteId, wxaccount,
								userwx);
						if (hasTodayVote == 0) {// 没投过
							boolean b = vDao.addVotePerson(voteId, wxaccount,
									userwx);
							if (b) {
								vDao.updateFiled(voteId, "opposeNum");
								topicDao.updatePersonNum(topicId);
							}
							reply = "yes";
						} else if (hasTodayVote == -1) {// 当天没投
							boolean b = vDao.updateVoteAccount(voteId,
									wxaccount, userwx);
							if (b) {
								vDao.updateFiled(voteId, "opposeNum");
								topicDao.updatePersonNum(topicId);
							}
							reply = "yes";
						} else if (hasTodayVote == 1) {// 当天已投
							reply = "hasVote";// 已投
						}
					}
				}
				topicDao = null;
			}

			BackJs.backJs(reply, response);
		} else if (ac.equals("addVotePerson")) {
			String topicId = request.getParameter("topicId");
			String voteId = request.getParameter("voteId");

			vDao.updateFiled(voteId, "supportNum");
			vDao.addVotePerson(topicId, wxaccount, userwx);

			TopicDao topicDao = new TopicDao();
			topicDao.updatePersonNum(topicId);
			topicDao = null;
		} else if (ac.equals("listpic")) {
			String topicId = request.getParameter("topicId");

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			VoteDao voteDao = new VoteDao();
			int totalRecord = voteDao.getTotalRecordByStatus(wxaccount,
					topicId, 1);

			request.setAttribute("totalRecord", totalRecord);
			request.getRequestDispatcher("/vote/picVote.jsp?token=" + token)
					.forward(request, response);
		} else if (ac.equals("textVote")) {
			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			request.getRequestDispatcher("/vote/textVote.jsp?token=" + token)
					.forward(request, response);
		} else if (ac.equals("act_t")) {
			String topicId = request.getParameter("topicId");

			TopicDao topicDao = new TopicDao();
			Topic topic = topicDao.getTopic(topicId);
			topicDao = null;

			boolean isVote = vDao.hasVote(topicId, wxaccount, userwx);
			List<Vote> votes;
			Page page = new Page(1, 50, 50);
			if (isVote) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "supportNum",
						page, 1);
			} else {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "uptTime",
						page, 1);
			}

			request.setAttribute("isVote", isVote);
			request.setAttribute("topic", topic);
			request.setAttribute("votes", votes);
			request.getRequestDispatcher("/vote/voteAct_text.jsp").forward(
					request, response);
		}
		vDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		VoteDao vDao = new VoteDao();

		if (ac == null) {
		} else if (ac.equals("listVote")) {
			String orderBy = request.getParameter("orderBy");
			String s_page = request.getParameter("cpg");
			String topicId = request.getParameter("topicId");
			int cur_page = Integer.parseInt(s_page);

			Page page = new Page(cur_page, 16, 100);
			List<Vote> votes = null;
			if (orderBy == null || orderBy.equals("null")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "rand()",
						page, 1);
			} else if (orderBy.equals("1")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "voteId",
						page, 1);
			} else if (orderBy.equals("2")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "supportNum",
						page, 1);
			} else if (orderBy.equals("3")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "uptTime",
						page, 1);
			}

			BackJs.backJs(JSONArray.toJSONString(votes), response);
		} else if (ac.equals("searchVote")) {
			String topicId = request.getParameter("topicId");
			String keyword = request.getParameter("keyword").trim();

			Page page = new Page(1, 10, 10);
			List<Vote> votes = vDao.searchByKeyword(wxaccount, keyword, page,
					topicId);
			BackJs.backJs(JSONArray.toJSONString(votes), response);
		}
		vDao = null;
	}
}
