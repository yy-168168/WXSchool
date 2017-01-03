package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.VoteDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Vote;
import com.wxschool.util.BackJs;

public class BoyGirlMng extends HttpServlet {

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
			String topicId = request.getParameter("topicId");
			String scurPage = request.getParameter("c_p");
			String orderBy = request.getParameter("orderBy");
			String s_status = request.getParameter("s_t");

			if (orderBy == null) {
				orderBy = "voteId";
			} else {
				orderBy = "supportNum";
			}

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int status = 1;
			if (s_status == null || s_status.equals("")) {
			} else {
				status = Integer.parseInt(s_status);
			}

			int totalRecord = voteDao.getTotalRecordByStatus(wxid, topicId,
					status);
			Page page = new Page(curPage, 12, totalRecord);
			List<Vote> votes = voteDao.getVotesByStatus(wxid, topicId, orderBy,
					page, status);

			request.setAttribute("page", page);
			request.setAttribute("votes", votes);
			request.getRequestDispatcher("/mng/bgList.jsp").forward(request,
					response);
		} else if (ac.equals("getBg")) {
			String voteId = request.getParameter("voteId");
			String topicId = request.getParameter("topicId");
			Vote vote = voteDao.getVote(voteId);

			request.setAttribute("vote", vote);
			request.getRequestDispatcher(
					"/mng/bgAddorUpt.jsp?ac=uptBg&topicId=" + topicId).forward(
					request, response);
		} else if (ac.equals("addBg_")) {
			String topicId = request.getParameter("topicId");

			request.getRequestDispatcher(
					"/mng/bgAddorUpt.jsp?ac=addBg&topicId=" + topicId).forward(
					request, response);
		} else if (ac.equals("uptBg") || ac.equals("addBg")) {
			String voteId = request.getParameter("voteId");
			String desc = request.getParameter("desc".trim());
			String picUrl = request.getParameter("picUrl").trim();
			String topicId = request.getParameter("topicId");
			String remark = request.getParameter("remark").trim();
			String status = request.getParameter("status");

			Vote vote = new Vote();
			vote.setContent(picUrl);
			vote.setName(desc);
			vote.setRemark(remark);
			vote.setTopicId(Integer.parseInt(topicId));

			boolean isSuccess = false;
			if (ac.equals("uptBg")) {
				vote.setVoteId(Integer.parseInt(voteId));
				vote.setStatus(Integer.parseInt(status));

				isSuccess = voteDao.updateBoyGirl(vote);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addBg")) {
				vote.setWxaccount(wxid);
				vote.setStatus(1);

				isSuccess = voteDao.addVote(vote);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");
			String topicId = request.getParameter("topicId");

			Page page = new Page(1, 16, 16);
			List<Vote> votes = voteDao.searchByKeyword(wxid, kw, page, topicId);

			request.setAttribute("page", page);
			request.setAttribute("votes", votes);
			request.getRequestDispatcher("/mng/bgList.jsp").forward(request,
					response);
		}
		voteDao = null;
	}
}
