package com.wxschool.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class BackJs {

	public static void backJs(String s, HttpServletResponse response) {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			writer.print(s);
			writer.flush();
		} catch (Exception e) {

		} finally {
			writer.close();
		}
	}
}
