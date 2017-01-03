package com.wxschool.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.WdUserDao;

public class WdOrderFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		String token = req.getParameter("token");
		WdUserDao userDao = new WdUserDao();
		String uid = userDao.getUidByToken(token);

		if (uid == null || uid.equals("")) {
			((HttpServletResponse) res).sendRedirect("/wd");
			return;
		} else {
			req.setAttribute("uid", uid);
		}
		userDao = null;
		chain.doFilter(req, res);
	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}
