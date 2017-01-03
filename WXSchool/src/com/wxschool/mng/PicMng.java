package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.PicDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Pic;
import com.wxschool.util.BackJs;

public class PicMng extends HttpServlet {

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
		PicDao picDao = new PicDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = picDao.getTotalRecord(wxid, 1);
			Page page = new Page(curPage, 10, totalRecord);

			List<Pic> pics = picDao.getPicsByPage(wxid, page, 1, "picId");

			request.setAttribute("page", page);
			request.setAttribute("pics", pics);
			request.getRequestDispatcher("/mng/picList.jsp").forward(request,
					response);
		} else if (ac.equals("getPic")) {
			String picId = request.getParameter("picId");
			Pic pic = picDao.getPicById(picId);

			request.setAttribute("pic", pic);
			request.getRequestDispatcher("/mng/picAddorUpt.jsp?ac=uptPic")
					.forward(request, response);
		} else if (ac.equals("addPic_")) {
			request.getRequestDispatcher("/mng/picAddorUpt.jsp?ac=addPic")
					.forward(request, response);
		} else if (ac.equals("uptPic") || ac.equals("addPic")) {
			String picId = request.getParameter("picId");
			String keyword = request.getParameter("keyword").trim();
			String title = request.getParameter("title").trim();
			String desc = request.getParameter("desc").trim();
			String picUrl = request.getParameter("picUrl").trim();

			Pic pic = new Pic();
			pic.setWxaccount(wxid);
			pic.setType(1);
			pic.setPicUrl(picUrl);
			pic.setTitle(title);
			pic.setKeyword(keyword);
			pic.setDesc(desc);

			boolean isSuccess = false;
			if (ac.equals("uptPic")) {
				pic.setPicId(Integer.parseInt(picId));
				isSuccess = picDao.updatePic(pic);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addPic")) {
				isSuccess = picDao.addPic(pic);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("delete_")) {
			String picId = request.getParameter("picId");
			picDao.changeStatus(picId, -1);
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");

			Page page = new Page(1, 15, 15);
			List<Pic> pics = picDao.searchByKeyword(wxid, kw, page, 1);

			request.setAttribute("page", page);
			request.setAttribute("pics", pics);
			request.getRequestDispatcher("/mng/picList.jsp").forward(request,
					response);
		}
		picDao = null;
	}
}
