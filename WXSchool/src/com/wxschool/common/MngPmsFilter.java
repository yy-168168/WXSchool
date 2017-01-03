package com.wxschool.common;

import java.io.IOException;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.*;
import com.wxschool.entity.*;

public class MngPmsFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		if (request.getRequestURI().indexOf("login") > -1) {
			chain.doFilter(request, response);
			return;
		}

		String token = request.getParameter("token");
		String menuId = request.getParameter("mId");

		if (token == null || token.equals("")) {
			response.sendRedirect("/mng/");
			return;
		}

		AdminDao adminDao = new AdminDao();
		Admin admin = adminDao.getAdminByToken(token);

		if (admin == null || admin.getWxaccount() == null
				|| admin.getStatus() != 1) {
			response.sendRedirect("/mng/");
			return;
		} else {
			String wxid = admin.getUserwx();

			ModuleDao moduleDao = new ModuleDao();
			List<Module> modules = moduleDao.getModules(wxid);
			moduleDao = null;

			String edit = "false";
			for (int i = 0; i < modules.size(); i++) {
				Module m = modules.get(i);
				if ((m.getModuleId() + "").equals(menuId)) {
					edit = m.getEdit();
				}
			}

			request.setAttribute("edit", edit);
			request.setAttribute("wxid", wxid);
			request.setAttribute("modules", modules);
			chain.doFilter(request, response);
		}
		adminDao = null;
	}

	public void init(FilterConfig arg0) throws ServletException {

	}
}
