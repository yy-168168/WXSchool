package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.ArticleDao;
import com.wxschool.entity.Article;
import com.wxschool.entity.Page;
import com.wxschool.util.BackJs;

public class NewsMng extends HttpServlet {

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

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = articleDao.getTotalRecordofMenu(wxid);
			Page page = new Page(curPage, 10, totalRecord);

			List<Article> articles = articleDao.getArticlesofMenu(wxid, page);

			request.setAttribute("page", page);
			request.setAttribute("articles", articles);
			request.getRequestDispatcher("/mng/newsList.jsp").forward(request,
					response);
		} else if (ac.equals("getArt")) {
			String artId = request.getParameter("artId");
			Article article = articleDao.getArticleById(artId);

			request.setAttribute("article", article);
			request.getRequestDispatcher("/mng/newsAddorUpt.jsp?ac=uptArt")
					.forward(request, response);
		} else if (ac.equals("addArt_")) {
			request.getRequestDispatcher("/mng/newsAddorUpt.jsp?ac=addArt")
					.forward(request, response);
		} else if (ac.equals("uptArt") || ac.equals("addArt")) {
			String artId = request.getParameter("artId");
			String keyword = request.getParameter("keyword").trim();
			String title = request.getParameter("title").trim();
			String picUrl = request.getParameter("picUrl").trim();
			String locUrl = request.getParameter("locUrl").trim();
			String desc = request.getParameter("desc").trim();
			String rank = request.getParameter("rank").trim();

			Article article = new Article();
			article.setKeyword(keyword);
			article.setTitle(title);
			article.setPicUrl(picUrl);
			article.setLocUrl(locUrl);
			article.setCate("menu");
			article.setDesc(desc);
			article.setRank(Integer.parseInt(rank));
			article.setWxaccount(wxid);

			boolean isSuccess = false;
			if (ac.equals("uptArt")) {
				article.setArticleId(Integer.parseInt(artId));
				isSuccess = articleDao.updateArt(article);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addArt")) {
				isSuccess = articleDao.addArt(article);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("changeStatus")) {
			String artId = request.getParameter("artId");
			String status = request.getParameter("status"); 
			articleDao.changeStatus(artId, status);
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");

			Page page = new Page(1, 15, 15);
			List<Article> articles = articleDao.searchByKeywordofMenu(wxid, kw,
					page);

			request.setAttribute("page", page);
			request.setAttribute("articles", articles);
			request.getRequestDispatcher("/mng/newsList.jsp").forward(request,
					response);
		}
		articleDao = null;
	}
}
