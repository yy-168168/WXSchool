package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.AccountDao;
import com.wxschool.entity.Account;
import com.wxschool.entity.Page;
import com.wxschool.util.BackJs;

public class AccountMng extends HttpServlet {

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
		AccountDao accountDao = new AccountDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = accountDao.getTotalRecord();
			Page page = new Page(curPage, 20, totalRecord);
			List<Account> accounts = accountDao.getAccounts(page);

			request.setAttribute("page", page);
			request.setAttribute("accounts", accounts);
			request.getRequestDispatcher("/mng/accountList.jsp").forward(
					request, response);
		} else if (ac.equals("index")) {
			request.getRequestDispatcher("/mng/home.jsp").forward(request,
					response);
		} else if (ac.equals("info")) {
			Account account = accountDao.getAccount(wxid);

			request.setAttribute("account", account);
			request.getRequestDispatcher("/mng/accountInfo.jsp").forward(
					request, response);
		} else if (ac.equals("uptAccount")) {
			String accountId = request.getParameter("accountId");
			String wxAccount = request.getParameter("wxAccount");
			String wxNum = request.getParameter("wxNum");
			String wxName = request.getParameter("wxName");
			String guideUrl = request.getParameter("guideUrl");

			Account account = new Account();
			account.setAccountId(Integer.parseInt(accountId));
			account.setGuideUrl(guideUrl);
			account.setWxAccount(wxAccount);
			account.setWxName(wxName);
			account.setWxNum(wxNum);

			boolean isSuccess = accountDao.updateAccountInfo(account);
			BackJs.backJs("upt" + isSuccess, response);
		} else if (ac.equals("openOrClose")) {
			String accountId = request.getParameter("accountId");
			String filed = request.getParameter("filed");

			boolean isSuccess = accountDao.updateFiled(accountId, filed);
			BackJs.backJs("upt" + isSuccess, response);
		}
	}
}
