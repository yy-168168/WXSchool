package com.wxschool.web;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import com.wxschool.dao.*;
import com.wxschool.entity.*;

public class BoardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		BoardDao bDao = new BoardDao();

		if (ac == null) {
		} else if (ac.equals("getBoards")) {
			new AccountDao().updateFiled(wxaccount, "board", 1);
			Page page = new Page(1, 30, 30);
			List<Board> boards = bDao.getBoards(wxaccount, "0", page);

			request.setAttribute("boards", boards);
			request.getRequestDispatcher("/board/list.jsp").forward(request,
					response);
		} else if (ac.equals("listjob")) {
			List<Board> boards = bDao.getBoardsByDay(wxaccount, "2", 10);

			request.setAttribute("boards", boards);
			request.getRequestDispatcher("/board/listjob.jsp").forward(request,
					response);
		} else if (ac.equals("listthing")) {
			List<Board> boards = bDao.getBoardsByDay(wxaccount, "7", 10);

			int totalRecord = bDao.getTotalRecord(wxaccount, "7");
			Page page = new Page(1, 10, totalRecord + 300);

			request.setAttribute("page", page);
			request.setAttribute("boards", boards);
			request.getRequestDispatcher("/board/listthing.jsp").forward(
					request, response);
		}
		bDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		BoardDao bDao = new BoardDao();

		if (ac == null) {
		} else if (ac.equals("addBoard")) {
			String content = request.getParameter("content").trim();
			String way = request.getParameter("way");
			String contact = request.getParameter("contact").trim();
			String cate = request.getParameter("cate");

			Board board = new Board();
			board.setContent(content);
			board.setCate(Integer.parseInt(cate));
			board.setWay(way);
			board.setContact(contact);
			board.setUserwx(userwx);
			board.setWxaccount(wxaccount);

			bDao.addBoard(board);
			return;
		} else if (ac.equals("addThing")) {
			String content = request.getParameter("content");
			String contact = request.getParameter("contact");
			String cate = request.getParameter("cate");

			// 黑名单
			if (contact.indexOf("15663867789") > -1) {
				return;
			}

			Board board = new Board();
			board.setContent(content);
			board.setCate(Integer.parseInt(cate));
			board.setWay("tel");
			board.setContact(contact);
			board.setUserwx(userwx);
			board.setWxaccount(wxaccount);

			bDao.addBoard(board);
			return;
		}
		bDao = null;
	}
}
