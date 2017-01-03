package com.wxschool.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class VoteFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		String path = ((HttpServletRequest) req).getRequestURI();
		String qs = ((HttpServletRequest) req).getQueryString().replace(
				"&amp;", "&");
		req.getRequestDispatcher(path + "?" + qs).forward(req, res);
		// chain.doFilter(req, res);
	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}
