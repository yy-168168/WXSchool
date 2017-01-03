package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ReplyDao;
import com.wxschool.dao.TopicDao;
import com.wxschool.dao.VoteDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Reply;
import com.wxschool.entity.Topic;
import com.wxschool.entity.Vote;

public class BiaobaiMng extends HttpServlet {

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
		VoteDao voteDao = new VoteDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");
			String orderBy = request.getParameter("orderBy");
			if (orderBy == null) {
				orderBy = "voteId";
			} else if (orderBy.equals("spn")) {
				orderBy = "supportNum";
			} else {
				orderBy = "opposeNum";
			}

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			TopicDao topicDao = new TopicDao();
			Topic topic = topicDao.getTopic(wxid, "1");
			String topicId = topic.getTopicId() + "";
			topicDao = null;

			int totalRecord = voteDao.getTotalRecordByStatus(wxid, topicId, 1);
			Page page = new Page(curPage, 10, totalRecord);
			List<Vote> bbs = voteDao.getVotesByStatus(wxid, topicId, orderBy,
					page, 1);

			request.setAttribute("page", page);
			request.setAttribute("bbs", bbs);
			request.getRequestDispatcher("/mng/bbList.jsp?topicId=" + topicId)
					.forward(request, response);
		} else if (ac.equals("listReply")) {
			String voteId = request.getParameter("voteId");
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			ReplyDao replyDao = new ReplyDao();
			int totalRecord = replyDao.getTotalRecord_reply(voteId, 2);
			Page page = new Page(curPage, 15, totalRecord);

			List<Reply> replys = replyDao.getReplys(voteId, 2, page);
			replyDao = null;

			request.setAttribute("page", page);
			request.setAttribute("replys", replys);
			request.getRequestDispatcher("/mng/bbReplyList.jsp").forward(
					request, response);
		} else if (ac.equals("deleteBb")) {
			String voteId = request.getParameter("voteId");
			voteDao.changeStatus(voteId, -1);
		}
		voteDao = null;
	}
}
