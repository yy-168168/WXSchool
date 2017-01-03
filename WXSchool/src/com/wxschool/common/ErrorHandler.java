package com.wxschool.common;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.LogDao;

public class ErrorHandler extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		Throwable throwable = (Throwable) request
				.getAttribute("javax.servlet.error.exception");
		Integer statusCode = (Integer) request
				.getAttribute("javax.servlet.error.status_code");
		// String servletName = (String)
		// request.getAttribute("javax.servlet.error.servlet_name");
		String message = (String) request
				.getAttribute("javax.servlet.error.message");
		Class<Exception> exceptionType = (Class<Exception>) request
				.getAttribute("javax.servlet.error.exception_type");
		// String uri = (String)
		// request.getAttribute("javax.servlet.error.request_uri");

		StringBuffer sb = new StringBuffer();
		if (statusCode == 404) {
			sb.append(message + " not found");

			LogDao.getLog().addNorLog(sb.toString());
			response.sendRedirect("/common/error_notFound.html");
		} else {
			sb.append(exceptionType.getName());
			sb.append(": ");
			sb.append(message);

			sb.append("栈信息：");
			StackTraceElement[] ste = throwable.getStackTrace();
			for (int i = 0; i < ste.length && i < 10; i++) {
				sb.append(ste[i].getClassName());
				sb.append(".");
				sb.append(ste[i].getMethodName());
				sb.append("-");
				sb.append(ste[i].getLineNumber());
				sb.append("; ");
			}

			LogDao.getLog().addNorLog(sb.toString());
			response.sendRedirect("/common/error_wrong.html");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		this.doGet(request, response);
	}
}
