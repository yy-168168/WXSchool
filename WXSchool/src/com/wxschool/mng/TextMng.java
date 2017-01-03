package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.TextDao;
import com.wxschool.entity.Page;
import com.wxschool.entity.Text;
import com.wxschool.util.BackJs;

public class TextMng extends HttpServlet {

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
		TextDao textDao = new TextDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int totalRecord = textDao.getTotalRecord(wxid);
			Page page = new Page(curPage, 10, totalRecord);

			List<Text> texts = textDao.getTextsByPage(wxid, page);

			request.setAttribute("page", page);
			request.setAttribute("texts", texts);
			request.getRequestDispatcher("/mng/textList.jsp").forward(request,
					response);
		} else if (ac.equals("getText")) {
			String textId = request.getParameter("textId");
			Text text = textDao.getText(textId);

			request.setAttribute("text", text);
			request.getRequestDispatcher("/mng/textAddorUpt.jsp?ac=uptText")
					.forward(request, response);
		} else if (ac.equals("addText_")) {
			request.getRequestDispatcher("/mng/textAddorUpt.jsp?ac=addText")
					.forward(request, response);
		} else if (ac.equals("uptText") || ac.equals("addText")) {
			String textId = request.getParameter("textId");
			String key = request.getParameter("key").trim();
			String value = request.getParameter("value").trim();

			Text text = new Text();
			text.setKey(key);
			text.setValue(value);
			text.setWxaccount(wxid);

			boolean isSuccess = false;
			if (ac.equals("uptText")) {
				text.setTextId(Integer.parseInt(textId));
				isSuccess = textDao.updateText(text);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addText")) {
				isSuccess = textDao.addText(text);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("changeStatus")) {
			String textId = request.getParameter("textId");
			String status = request.getParameter("status");
			textDao.changeStatusById(textId, status);
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");

			Page page = new Page(1, 15, 15);
			List<Text> texts = textDao.searchByKeyword(wxid, kw, page);

			request.setAttribute("page", page);
			request.setAttribute("texts", texts);
			request.getRequestDispatcher("/mng/textList.jsp").forward(request,
					response);
		}
		textDao = null;
	}
}
