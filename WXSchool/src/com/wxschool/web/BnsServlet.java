package com.wxschool.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.*;
import com.wxschool.entity.*;
import com.wxschool.util.CommonUtil;

public class BnsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		BnsDao bDao = new BnsDao();

		if (ac == null) {
		} else if (ac.equals("isExist")) {
			Menber menber = bDao.getMenber(wxaccount, userwx);

			request.setAttribute("menber", menber);
			request.getRequestDispatcher("/bns/showcard.jsp").forward(request,
					response);
		} else if (ac.equals("card")) {
			List<Merchant> merchants = bDao.getMerchants(wxaccount);

			request.setAttribute("merchants", merchants);
			request.getRequestDispatcher("/bns/showbns.jsp").forward(request,
					response);
		} else if (ac.equals("updateVisitPerson")) {
			String mcId = request.getParameter("mcId");
			bDao.updateVisitPerson_goods(mcId);
		} else if (ac.equals("list")) {
			String cate = request.getParameter("cate");
			String type = request.getParameter("type");
			String scurPage = request.getParameter("c_p");

			int curPage = CommonUtil.parseInt(scurPage, 1);

			List<Goods> goodses;
			Page page;
			if (cate == null || cate.equals("null")) {
				int totalRecord = bDao.getTotalRecord(wxaccount, type);
				page = new Page(curPage, 10, totalRecord);
				goodses = bDao.getGoodsesByVp(wxaccount, page, type);
			} else {
				int totalRecord = bDao.getTotalRecordByCate(wxaccount, cate,
						type);
				page = new Page(curPage, 10, totalRecord);
				goodses = bDao.getGoodsesByCate(wxaccount, cate, page, type);
			}

			request.setAttribute("page", page);
			request.setAttribute("goodses", goodses);

			if (type != null && type.equals("1")) {
				request.getRequestDispatcher("/bns/showUsed.jsp").forward(
						request, response);
			} else {
				request.getRequestDispatcher("/bns/showBox.jsp").forward(
						request, response);
			}
		} else if (ac.equals("getGs")) {
			String gsId = request.getParameter("gsId");
			String type = request.getParameter("type");
			bDao.updateVisitPerson_goods(gsId);
			Goods goods = bDao.getGoods(gsId);

			request.setAttribute("goods", goods);
			if (type != null && type.equals("1")) {
				request.getRequestDispatcher("/bns/showUseddt.jsp").forward(
						request, response);
			} else {
				request.getRequestDispatcher("/bns/showBoxdt.jsp").forward(
						request, response);
			}
		} else if (ac.equals("search")) {
			String keyword = request.getParameter("keyword");
			String type = request.getParameter("type");

			Page page = new Page(1, 20, 20);
			List<Goods> goodses = bDao.getGoodsesByKeyword(wxaccount, keyword,
					type, page);

			request.setAttribute("page", page);
			request.setAttribute("goodses", goodses);
			if (type != null && type.equals("1")) {
				request.getRequestDispatcher("/bns/showUsed.jsp").forward(
						request, response);
			} else {
				request.getRequestDispatcher("/bns/showBox.jsp").forward(
						request, response);
			}
		}
		bDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html");

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		BnsDao bDao = new BnsDao();

		if (ac == null) {
		} else if (ac.equals("addMenber")) {
			String menberName = request.getParameter("menberName").trim();
			String tel = request.getParameter("tel").trim();

			Menber mb = bDao.getMenber(wxaccount, userwx);

			if (mb == null) {
				mb = new Menber();
				mb.setMenberName(menberName);
				mb.setTel(tel);
				mb.setUserwx(userwx);
				mb.setWxaccount(wxaccount);

				boolean b = bDao.addMenber(mb);
				if (b) {
					response.sendRedirect("/mobile/bns?ac=isExist&wxaccount="
							+ wxaccount + "&userwx=" + userwx);
				} else {
					response.sendRedirect("/bns/register.jsp?wxaccount="
							+ wxaccount + "&userwx=" + userwx);
				}
			} else {
				response.sendRedirect("/mobile/bns?ac=isExist&wxaccount="
						+ wxaccount + "&userwx=" + userwx);
			}
		}
		bDao = null;
	}
}
