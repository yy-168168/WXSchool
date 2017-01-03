package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.OperateRecordDao;
import com.wxschool.entity.OperateRecord;
import com.wxschool.entity.Page;

public class OperateRecordMng extends HttpServlet {

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
		OperateRecordDao operateRecordDao = new OperateRecordDao();

		if (ac.equals("lista")) {
			Object[][] accounts = operateRecordDao.getAccountData();

			request.setAttribute("accounts", accounts);
			request.getRequestDispatcher("/mng/operate_accountList.jsp")
					.forward(request, response);
		} else if (ac.equals("listr")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			Page page = new Page(curPage, 20);
			List<OperateRecord> operateRecords = operateRecordDao
					.getOperateRecords(wxaccount, page);
			page.setCurPageCount(operateRecords.size());

			request.setAttribute("page", page);
			request.setAttribute("operateRecords", operateRecords);
			request.getRequestDispatcher("/mng/operateRecordList.jsp").forward(
					request, response);
		} else if (ac.equals("listru")) {
			String scurPage = request.getParameter("c_p");
			String wxaccount = request.getParameter("wxaccount");
			String userwx = request.getParameter("userwx");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = operateRecordDao.getTotalRecord_user(wxaccount,
					userwx);
			Page page = new Page(curPage, 20, totalRecord);

			List<OperateRecord> operateRecords = operateRecordDao
					.getOperateRecords_user(wxaccount, userwx, page);

			request.setAttribute("page", page);
			request.setAttribute("operateRecords", operateRecords);
			request.getRequestDispatcher("/mng/operateRecordList_user.jsp")
					.forward(request, response);
		}
	}
}
