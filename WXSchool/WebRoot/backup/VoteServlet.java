package com.wxschool.web;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONArray;
import com.wxschool.dao.*;
import com.wxschool.dpo.WechatService;
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
			if (userwx != null) {
				String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
				token = CommonUtil.getRandomStr(6) + token;

				request
						.getRequestDispatcher(
								"/vote/listpic.jsp?token=" + token).forward(
								request, response);
			}
		} else if (ac.equals("picwall")) {
			String topicId = request.getParameter("topicId");
			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			int totalRecord = vDao
					.getTotalRecordByStatus(wxaccount, topicId, 1);
			request.setAttribute("totalRecord", totalRecord);

			request.getRequestDispatcher("/vote/picwall.jsp?token=" + token)
					.forward(request, response);
		} else if (ac.equals("listbiaobai")) {
			String topicId = request.getParameter("topicId");
			String orderBy = request.getParameter("orderBy");
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = vDao.getTotalRecord(wxaccount, topicId, 1);
			Page page = new Page(curPage, 20, totalRecord);

			List<Vote> vs = null;
			if (orderBy == null || orderBy.equals("null")
					|| orderBy.equals("1")) {
				vs = vDao.getVotesByStatus(wxaccount, topicId, "voteId", page,
						1);
			} else if (orderBy.equals("2")) {
				vs = vDao.getVotesByStatus(wxaccount, topicId, "supportNum",
						page, 1);
			} else if (orderBy.equals("3")) {
				vs = vDao.getVotesByStatus(wxaccount, topicId, "opposeNum",
						page, 1);
			} else if (orderBy.equals("4")) {
				vs = vDao.getVotesByStatus(wxaccount, topicId, "replyNum",
						page, 1);
			}

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			request.setAttribute("page", page);
			request.setAttribute("vs", vs);
			request
					.getRequestDispatcher(
							"/vote/listbiaobai.jsp?token=" + token).forward(
							request, response);
		} else if (ac.equals("mybb")) {
			String topicId = request.getParameter("topicId");
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = vDao.getTotalRecordByUserwx(wxaccount, userwx,
					topicId);
			Page page = new Page(curPage, 25, totalRecord);

			List<Vote> vs = vDao.getVotesByUserwx(wxaccount, userwx, topicId,
					page);

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			request.setAttribute("page", page);
			request.setAttribute("vs", vs);
			request
					.getRequestDispatcher(
							"/vote/listbiaobai.jsp?token=" + token).forward(
							request, response);
		} else if (ac.equals("listbreply")) {
			String voteId = request.getParameter("voteId");

			Vote vote = vDao.getVote(voteId);

			Page page = new Page(1, 1000, 1000);
			ReplyDao replyDao = new ReplyDao();
			List<Reply> replys = replyDao.getReplys(voteId, 2, page);
			replyDao = null;

			String token = new BASE64Encoder().encode(userwx.getBytes());// 加密
			token = CommonUtil.getRandomStr(6) + token;

			request.setAttribute("vote", vote);
			request.setAttribute("replys", replys);
			request.getRequestDispatcher("/vote/listbreply.jsp?token=" + token)
					.forward(request, response);
		} else if (ac.equals("listboyandgirl")) {
			String orderBy = request.getParameter("orderBy");
			String s_page = request.getParameter("cpg");
			String topicId = request.getParameter("topicId");
			int cur_page = Integer.parseInt(s_page);

			Page page = new Page(cur_page, 16, 100);
			List<Vote> votes = null;
			if (orderBy == null || orderBy.equals("null")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "uptTime",
						page, 1);
			} else if (orderBy.equals("1")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "voteId",
						page, 1);
			} else if (orderBy.equals("2")) {
				votes = vDao.getVotesByStatus(wxaccount, topicId, "supportNum",
						page, 1);
			}

			BackJs.backJs(JSONArray.toJSONString(votes), response);
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
		} else if (ac.equals("getContentForPic")) {
			String picUrl = request.getParameter("picUrl");
			Vote vote = vDao.getVoteByFiled(picUrl);

			if (vote == null) {// 出错
				throw new IOException();
			} else if (vote.getVoteId() == 0 || vote.getStatus() == -1) {// 没有
				BackJs
						.backJs(
								"<script type='text/javascript'>alert('照片被删除，或不存在！');</script>",
								response);
			} else {
				request.setAttribute("vote", vote);
				request.getRequestDispatcher("/common/contentForPic.jsp")
						.forward(request, response);
			}
		} else if (ac.equals("listpicwall")) {
			String orderBy = request.getParameter("orderBy");
			String s_page = request.getParameter("cpg");
			String topicId = "-100";
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
		} else if (ac.equals("search_pic")) {
			String topicId = request.getParameter("topicId");
			String keyword = request.getParameter("keyword").trim();

			Page page = new Page(1, 10, 10);
			List<Vote> votes = vDao.searchByKeyword(wxaccount, keyword, page,
					topicId);
			BackJs.backJs(JSONArray.toJSONString(votes), response);
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

			if (topicId != null) {
				Vote v = new Vote();
				v.setContent(content);
				v.setName(name);
				v.setTopicId(Integer.parseInt(topicId));
				v.setUserwx(userwx);
				v.setWxaccount(wxaccount);
				v.setStatus(1);

				int num = vDao.getMaxNum(wxaccount, topicId);
				v.setNum(num + 1);

				vDao.addVote(v);
				return;
			}
		} else if (ac.equals("addBReply")) {
			String content = request.getParameter("content");
			String voteId = request.getParameter("voteId");
			String receiver = request.getParameter("receiver");

			if (voteId == null) {
				return;
			}

			Reply reply = new Reply();
			reply.setContent(content);
			reply.setQuesId(Integer.parseInt(voteId));
			reply.setUserwx(userwx);
			reply.setWxaccount(wxaccount);
			reply.setOther("fff");
			reply.setType(2);

			ReplyDao replyDao = new ReplyDao();
			int num = replyDao.getMaxNum_reply(voteId, 2);
			reply.setNum(num + 1);

			boolean b = replyDao.addReply(reply);
			replyDao = null;
			if (b) {
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
								+ "/mobile/vote?ac=listbreply&wxaccount="
								+ wxaccount + "&userwx=" + receiver
								+ "&voteId=" + voteId);
						wechatService.sendCustomMsg(token, receiver, news);
					}
				}
			}
			return;
		} else if (ac.equals("uptContentForPic")) {
			String picId = request.getParameter("picId");
			String picUrl = request.getParameter("picUrl");
			String content = request.getParameter("content");

			boolean isSuccess = false;
			if (picId != null) {
				Vote vote = new Vote();
				vote.setVoteId(Integer.parseInt(picId));
				vote.setContent(picUrl);
				vote.setName(content);
				vote.setTopicId(-100);
				vote.setStatus(0);

				isSuccess = vDao.updateBoyGirl(vote);
			}

			BackJs.backJs(isSuccess + "", response);
		}
		vDao = null;
	}
}
