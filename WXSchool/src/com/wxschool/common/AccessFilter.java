package com.wxschool.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.AccountDao;

public class AccessFilter implements Filter {

	public void destroy() {
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String wxaccount = request.getParameter("wxaccount");

		if (req.getMethod().equalsIgnoreCase("POST")) {
			AccountDao accountDao = new AccountDao();
			boolean isAccessOfWeb = accountDao.isAccessOfWeb(req, wxaccount);
			accountDao = null;

			if (!isAccessOfWeb) {
				res.sendRedirect("/common/error_illegal.html");
				return;
			}
		}

		chain.doFilter(request, response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {

	}

}
