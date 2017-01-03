package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.LogDao;
import com.wxschool.entity.Log;
import com.wxschool.entity.Page;
import com.wxschool.util.BackJs;

public class LogMng extends HttpServlet {

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
		// String wxid = (String) request.getAttribute("wxid");
		LogDao logDao = LogDao.getLog();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}
			int totalRecord = logDao.getTotalRecord();
			Page page = new Page(curPage, 20, totalRecord);
			List<Log> logs = logDao.getLogsByPage(page);

			request.setAttribute("page", page);
			request.setAttribute("logs", logs);
			request.getRequestDispatcher("/mng/logList.jsp").forward(request,
					response);
		} else if (ac.equals("deleteLog")) {
			String logId = request.getParameter("logId");
			boolean result = logDao.delete(logId);
			BackJs.backJs(result+"", response);
		} else if (ac.equals("deleteByKey")) {
			String keyword = request.getParameter("keyword");
			boolean result = logDao.deleteByKeyword(keyword);
			BackJs.backJs(result+"", response);
		}
	}

}
