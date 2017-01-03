package com.wxschool.web;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.*;
import javax.servlet.http.*;
import com.wxschool.dao.*;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.*;
import com.wxschool.util.CommonUtil;

public class ReplyServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		ReplyDao rDao = new ReplyDao();

		if (ac == null) {
		} else if (ac.equals("listshit")) {
			String topicId = request.getParameter("topicId");
			String orderBy = request.getParameter("orderBy");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			int totalRecord = rDao.getTotalRecord_ques(wxaccount, topicId);
			Page page = new Page(curPage, 25, totalRecord);

			List<Question> shits = null;
			if (orderBy == null || orderBy.equals("null")
					|| orderBy.equals("1")) {
				shits = rDao.getQuess(wxaccount, topicId, "uptTime", page);
			} else if (orderBy.equals("2")) {
				shits = rDao.getQuess(wxaccount, topicId, "quesId", page);
			} else if (orderBy.equals("3")) {
				shits = rDao.getQuess(wxaccount, topicId, "replyNum", page);
			} else if (orderBy.equals("4")) {
				shits = rDao.getQuess(wxaccount, topicId, "visitPerson", page);
			}

			request.setAttribute("page", page);
			request.setAttribute("shits", shits);
			request.getRequestDispatcher("/reply/listShit.jsp").forward(
					request, response);
		} else if (ac.equals("listshitreply")) {
			String shitId = request.getParameter("shitId");

			rDao.updateFiled(shitId, "visitPerson");// 访问量+1

			Question ques = rDao.getQues(shitId);

			Page page = new Page(1, 1000, 1000);
			List<Reply> replys = rDao.getReplys(shitId, 1, page);

			request.setAttribute("ques", ques);
			request.setAttribute("replys", replys);
			request.getRequestDispatcher("/reply/listShitReply.jsp").forward(
					request, response);
		} else if (ac.equals("myShit")) {
			String topicId = request.getParameter("topicId");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			int totalRecord = rDao.getTotalRecordByUserwx_ques(wxaccount,
					userwx, topicId);
			Page page = new Page(curPage, 25, totalRecord);

			List<Question> shits = rDao.getQuessByUserwx(wxaccount, topicId,
					userwx, page);

			request.setAttribute("page", page);
			request.setAttribute("shits", shits);
			request.getRequestDispatcher("/reply/listShit.jsp").forward(
					request, response);
		} else if (ac.equals("infoCol")) {
			Map<Question, List<Reply>> infoCols = new HashMap<Question, List<Reply>>();

			Page page = new Page(1, 1000, 1000);
			List<Question> quess = rDao.getQuessByUserwx(wxaccount, "-66",
					userwx, page);

			for (int i = 0; quess != null && i < quess.size(); i++) {
				Question ques = quess.get(i);
				List<Reply> replys = rDao.getReplys(ques.getQuesId() + "", 3,
						page);

				infoCols.put(ques, replys);
			}

			request.setAttribute("infoCols", infoCols);
			request.getRequestDispatcher("/reply/infoCol.jsp").forward(request,
					response);
		} else if (ac.equals("infoColAdmin")) {
			Map<Question, List<Reply>> infoCols = new HashMap<Question, List<Reply>>();

			Page page = new Page(1, 1000, 1000);
			List<Question> quess = rDao.getQuess(wxaccount, "-66", "quesId",
					page);

			for (int i = 0; quess != null && i < quess.size(); i++) {
				Question ques = quess.get(i);
				List<Reply> replys = rDao.getReplys(ques.getQuesId() + "", 3,
						page);

				infoCols.put(ques, replys);
				try {
					Thread.sleep(50);
				} catch (InterruptedException e) {
				}
			}

			request.setAttribute("infoCols", infoCols);
			request.getRequestDispatcher("/reply/infoColAdmin.jsp").forward(
					request, response);
		}
		rDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		String ac = request.getParameter("ac");

		ReplyDao rDao = new ReplyDao();

		if (ac == null) {
		} else if (ac.equals("addQues")) {
			String topicId = request.getParameter("topicId");
			String content = request.getParameter("content");
			String other = request.getParameter("other");

			Question ques = new Question();
			ques.setContent(content);
			ques.setWxaccount(wxaccount);
			ques.setOther(other);
			ques.setTopicId(Integer.parseInt(topicId));

			if (userwx != null && userwx.equals("rand")) {
				userwx = UUID.randomUUID().toString();
			}
			ques.setUserwx(userwx);

			int num = rDao.getMaxNum_ques(wxaccount, topicId);
			ques.setNum(num + 1);

			rDao.addQues(ques);
			return;
		} else if (ac.equals("addReply")) {
			String content = request.getParameter("content");
			String shitId = request.getParameter("shitId");
			String other = request.getParameter("other");
			String parentUserwx = request.getParameter("parentUserwx");

			Reply reply = new Reply();
			reply.setContent(content);
			reply.setQuesId(Integer.parseInt(shitId));
			reply.setWxaccount(wxaccount);
			reply.setOther(other);
			reply.setType(1);

			if (userwx != null && userwx.equals("rand")) {
				userwx = UUID.randomUUID().toString();
			}
			reply.setUserwx(userwx);

			int num = rDao.getMaxNum_reply(shitId, 1);
			reply.setNum(num + 1);

			boolean b = rDao.addReply(reply);
			if (b) {
				rDao.updateFiled(shitId, "replyNum");// 评论数+1

				// 发送客服消息通知楼主
				WechatService wechatService = new WechatService();
				String token = wechatService.getAccessToken(wxaccount);

				if (token != null) {
					News news = new News();
					news.setTitle("有一个小伙伴儿评论了您的信息");
					news.setPicUrl("");
					news.setDescription("该消息来自【树洞】");
					news.setUrl(Config.SITEURL
							+ "/mobile/reply?ac=listshitreply&wxaccount="
							+ wxaccount + "&userwx=" + parentUserwx
							+ "&shitId=" + shitId);
					wechatService.sendCustomMsg_news(token, wxaccount, parentUserwx,
							news);
				}
			}
			return;
		} else if (ac.equals("addInfoColReply")) {
			String content = request.getParameter("content").trim();
			String infoId = request.getParameter("infoId");

			Reply reply = new Reply();
			reply.setContent(content);
			reply.setQuesId(Integer.parseInt(infoId));
			reply.setUserwx(userwx);
			reply.setWxaccount(wxaccount);
			reply.setOther("");
			reply.setType(3);

			int num = rDao.getMaxNum_reply(infoId, 3);
			reply.setNum(num + 1);

			boolean b = rDao.addReply(reply);
			if (b) {
				rDao.updateFiled(infoId, "replyNum");// 评论数+1
			}
			return;
		}
		rDao = null;
	}
}
