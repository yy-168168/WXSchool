package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ReplyDao;
import com.wxschool.dao.TopicDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Question;
import com.wxschool.entity.Reply;
import com.wxschool.entity.Topic;

public class ShitMng extends HttpServlet {

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
		String wxid = (String) request.getAttribute("wxid");
		ReplyDao replyDao = new ReplyDao();

		if (ac.equals("list")) {
			// String topicId = request.getParameter("topicId");
			String scurPage = request.getParameter("c_p");
			String orderBy = request.getParameter("orderBy");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			TopicDao topicDao = new TopicDao();
			Topic topic = topicDao.getTopic(wxid, "6");
			String topicId = topic.getTopicId() + "";
			topicDao = null;

			int totalRecord = replyDao.getTotalRecord_ques(wxid, topicId);
			Page page = new Page(curPage, 10, totalRecord);

			List<Question> quess = null;
			if (orderBy == null || orderBy.equals("null")
					|| orderBy.equals("1")) {
				quess = replyDao.getQuess(wxid, topicId, "quesId", page);
			} else if (orderBy.equals("2")) {
				quess = replyDao.getQuess(wxid, topicId, "replyNum", page);
			} else if (orderBy.equals("3")) {
				quess = replyDao.getQuess(wxid, topicId, "visitPerson", page);
			}

			request.setAttribute("page", page);
			request.setAttribute("quess", quess);
			request
					.getRequestDispatcher(
							"/mng/quesList.jsp?topicId=" + topicId).forward(
							request, response);
		} else if (ac.equals("listReply")) {
			String quesId = request.getParameter("quesId");
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = replyDao.getTotalRecord_reply(quesId, 1);
			Page page = new Page(curPage, 15, totalRecord);

			List<Reply> replys = replyDao.getReplys(quesId, 1, page);

			request.setAttribute("page", page);
			request.setAttribute("replys", replys);
			request.getRequestDispatcher("/mng/replyList.jsp").forward(request,
					response);
		} else if (ac.equals("deleteQues")) {
			String quesId = request.getParameter("quesId");

			replyDao.changeStatus_ques(quesId);
			return;
		} else if (ac.equals("deleteReply")) {
			String replyId = request.getParameter("replyId");

			replyDao.changeStatus_reply(replyId);
			return;
		}
		replyDao = null;

	}
}
