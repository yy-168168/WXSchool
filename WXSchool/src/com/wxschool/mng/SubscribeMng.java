package com.wxschool.mng;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ArticleDao;
import com.wxschool.dao.TextDao;
import com.wxschool.entity.Article;
import com.wxschool.entity.Text;

public class SubscribeMng extends HttpServlet {

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
		ArticleDao articleDao = new ArticleDao();
		TextDao textDao = new TextDao();

		if (ac.equals("get")) {
			Article article = articleDao.getSubscribe(wxid);
			Text text = textDao.getSubscribe(wxid);

			/*
			 * if (text != null && text.getValue() == null) {
			 * text.setKey("subscribe"); text.setValue("感谢您的关注！");
			 * text.setWxaccount(wxid); text.setStatus(-1);
			 * textDao.addText(text); }*
			 */

			request.setAttribute("article", article);
			request.setAttribute("text", text);
			request.getRequestDispatcher("/mng/subscribe.jsp").forward(request,
					response);
		} else if (ac.equals("updateSubscribe")) {
			String title = request.getParameter("title");
			String picUrl = request.getParameter("picUrl");
			String locUrl = request.getParameter("locUrl");
			String desc = request.getParameter("desc");
			String cont = request.getParameter("cont");

			Article article = new Article();
			article.setTitle(title);
			article.setPicUrl(picUrl);
			article.setLocUrl(locUrl);
			article.setDesc(desc);
			article.setWxaccount(wxid);
			articleDao.updateSubscribe(article);

			Text text = new Text();
			text.setValue(cont);
			text.setWxaccount(wxid);
			textDao.updateSubscribe(text);
		} else if (ac.equals("changeType")) {
			String type = request.getParameter("type");
			if (type.equals("news")) {
				articleDao.changeStatusOfSubscribe(wxid, 1);
			} else {
				articleDao.changeStatusOfSubscribe(wxid, -1);
			}
		}
		articleDao = null;
		textDao = null;
	}
}
