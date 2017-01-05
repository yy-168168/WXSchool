package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.*;
import com.wxschool.entity.*;
import com.wxschool.util.BackJs;
import com.wxschool.util.CommonUtil;

public class ArticleServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");
		ArticleDao aDao = new ArticleDao();

		if (ac == null) {
		} else if (ac.equals("updateVisitPerson")) {
			String aId = request.getParameter("aId");
			aDao.updateVisitPerson(aId);
		} else if (ac.equals("getVisitPerson")) {
			String aId = request.getParameter("aId");
			String visitPerson = aDao.getFiled(aId, "visitPerson");

			BackJs.backJs(visitPerson, response);
		} else if (ac.equals("getArt")) {
			String aId = request.getParameter("aId");
			Article article = aDao.getArticleById(aId);
			BackJs.backJs(JSONObject.toJSONString(article), response);
		} else if (ac.equals("getArticles")) {
			String cate = request.getParameter("cate");
			String orderBy = request.getParameter("orderBy");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			List<Article> articles = null;
			Page page = null;
			if (orderBy == null || orderBy.equals("null")) {
				int totalRecord = aDao.getTotalRecord(wxaccount, cate);
				page = new Page(curPage, 16, totalRecord);
				articles = aDao.getArticlesByCate(wxaccount, cate, "articleId",
						page);
			} else if (orderBy.equals("1")) {
				int totalRecord = aDao.getTotalRecordofArt(wxaccount);
				page = new Page(curPage, 16, totalRecord);
				articles = aDao.getArticlesofArt(wxaccount, "default", page);
			} else if (orderBy.equals("2")) {
				int totalRecord = aDao.getTotalRecordofArt(wxaccount);
				page = new Page(curPage, 16, totalRecord);
				articles = aDao
						.getArticlesofArt(wxaccount, "visitPerson", page);
			}

			request.setAttribute("page", page);
			request.setAttribute("articles", articles);
			request.getRequestDispatcher("/common/showArticles.jsp").forward(
					request, response);
		} else if (ac.equals("getArticleDt")) {
			String aId = request.getParameter("aId");
			aDao.updateVisitPerson(aId);

			Article article = aDao.getArticleById(aId);

			if (article.getStatus() != 1) {
				BackJs.backJs("<script>alert('该链接已失效');</script>", response);
			} else {
				/*
				 * if (locUrl.indexOf("jwc.hrbnu.edu.cn") > -1) {// 哈师大教务平台
				 * locUrl += userwx.substring(6); //
				 * response.sendRedirect("/common/error_notFound.html"); }
				 */
				response.sendRedirect(article.getLocUrl());
			}
		}
		aDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		String ac = request.getParameter("ac");

		if (ac == null) {

		}
	}
}