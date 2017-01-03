package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.BoardDao;
import com.wxschool.dao.TopicDao;
import com.wxschool.entity.Board;
import com.wxschool.entity.Page;
import com.wxschool.entity.Topic;

public class BoardMng extends HttpServlet {

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
		BoardDao boardDao = new BoardDao();

		if (ac.equals("listThing")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = boardDao.getTotalRecord(wxid, "7");
			Page page = new Page(curPage, 10, totalRecord);
			List<Board> boards = boardDao.getBoards(wxid, "7", page);

			TopicDao topicDao = new TopicDao();
			Topic topic = topicDao.getTopic(wxid, "4");
			topicDao = null;

			request.setAttribute("topicId", topic.getTopicId());
			request.setAttribute("page", page);
			request.setAttribute("boards", boards);
			request.getRequestDispatcher("/mng/boardThingList.jsp").forward(
					request, response);
		} else if (ac.equals("deleteBt")) {
			String boardId = request.getParameter("boardId");
			boardDao.changeStatus(boardId);
			return;
		}
		boardDao = null;
	}
}
