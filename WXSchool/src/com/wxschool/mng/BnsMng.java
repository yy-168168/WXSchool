package com.wxschool.mng;

import java.io.*;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.AdminDao;
import com.wxschool.dao.BnsDao;
import com.wxschool.entity.*;
import com.wxschool.util.BackJs;

public class BnsMng extends HttpServlet {

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
		BnsDao bnsDao = new BnsDao();

		if (ac.equals("listU")) {
			String scurPage = request.getParameter("c_p");
			String type = request.getParameter("type");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			if (type == null) {
				type = "1";
			}

			int totalRecord = bnsDao.getTotalRecordByUserwx(wxid, type);
			Page page = new Page(curPage, 10, totalRecord);

			List<Goods> goodses = bnsDao.getGoodsesByUserwx(wxid, page, type);

			request.setAttribute("page", page);
			request.setAttribute("goodses", goodses);
			request.getRequestDispatcher("/mng/gsListU.jsp").forward(request,
					response);
		} else if (ac.equals("getGsU")) {
			String gsId = request.getParameter("gsId");
			Goods goods = bnsDao.getGoods(gsId);
			request.setAttribute("goods", goods);

			if (goods.getType() == 1) {
				request.getRequestDispatcher("/mng/gs_used.jsp?ac=uptGs")
						.forward(request, response);
			} else {
				request.getRequestDispatcher("/mng/gs_box.jsp?ac=uptGs")
						.forward(request, response);
			}
		} else if (ac.equals("addGsU_")) {
			String type = request.getParameter("type");

			if (type.equals("1")) {
				request.getRequestDispatcher(
						"/mng/gs_used.jsp?ac=addGs&type=" + type).forward(
						request, response);
			} else {
				request.getRequestDispatcher(
						"/mng/gs_box.jsp?ac=addGs&type=" + type).forward(
						request, response);
			}
		} else if (ac.equals("deleteGs")) {
			String artId = request.getParameter("gsId");
			bnsDao.deleteGs(artId, -1);
			return;
		} else if (ac.equals("uptGs") || ac.equals("addGs")) {
			String gsId = request.getParameter("gsId");
			String simDesc = request.getParameter("simDesc").trim();
			String dtlDesc = request.getParameter("dtlDesc").trim();
			String picUrl = request.getParameter("picUrl").trim();
			String tel = request.getParameter("tel").trim();
			String cate = request.getParameter("cate");
			String wxin = request.getParameter("wxin").trim();
			String price = request.getParameter("price").trim();
			String old = request.getParameter("old");

			Goods goods = new Goods();
			goods.setGoodsId(Integer.parseInt(gsId));
			goods.setSimDesc(simDesc);
			goods.setDtlDesc(dtlDesc);
			goods.setPicUrl(picUrl);
			goods.setTel(tel);
			goods.setWxin(wxin);
			goods.setCate(Integer.parseInt(cate));
			goods.setPrice(Integer.parseInt(price));
			goods.setOld(Integer.parseInt(old));
			goods.setUid(wxid);

			boolean isSuccess = false;
			if (ac.equals("uptGs")) {
				isSuccess = bnsDao.updateGoods(goods);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addGs")) {
				String type = request.getParameter("type");
				goods.setType(Integer.parseInt(type));

				int totalRecord = bnsDao.getTotalRecordByUserwx(wxid, type);
				int maxNum = 0;
				if (type != null && type.equals("1")) {
					// maxNum = new AdminDao().getMaxNum(wxid, "maxUsedNum");
				} else {
					// maxNum = new AdminDao().getMaxNum(wxid, "maxBoxNum");
				}

				if (totalRecord >= maxNum) {
					BackJs.backJs("overMaxNum", response);
				} else {
					Admin admin = new AdminDao().getAdminByUserwx(wxid);
					goods.setWxaccount(admin.getWxaccount());
					isSuccess = bnsDao.addGoods(goods);
					BackJs.backJs("add" + isSuccess, response);
				}
			}
		} else if (ac.equals("getmn")) {
			String type = request.getParameter("type");

			int totalRecord = bnsDao.getTotalRecordByUserwx(wxid, type);
			int maxNum = 0;
			if (type != null && type.equals("1")) {
				// maxNum = new AdminDao().getMaxNum(wxid, "maxUsedNum");
			} else {
				// maxNum = new AdminDao().getMaxNum(wxid, "maxBoxNum");
			}

			if (totalRecord >= maxNum) {
				BackJs.backJs("overMaxNum", response);
			}
			BackJs.backJs("ok", response);
		} else if (ac.equals("usedNum")) {
			String type = request.getParameter("type");
			String wxin = request.getParameter("wxin");
			String tel = request.getParameter("tel");

			int maxNum = 0;
			if (type != null && type.equals("1")) {
				// maxNum = new AdminDao().getMaxNum(wxid, "maxUsedNum");
			} else {
				// maxNum = new AdminDao().getMaxNum(wxid, "maxBoxNum");
			}

			int usedNumOfWxin = bnsDao.getUsedNumOfWxin(wxin, type);
			int usedNumOfTel = bnsDao.getUsedNumOfTel(tel, type);

			if (usedNumOfWxin > maxNum) {
				BackJs.backJs("wxinOverMaxNum", response);
			} else if (usedNumOfTel > maxNum) {
				BackJs.backJs("telOverMaxNum", response);
			}
			BackJs.backJs("ok", response);
		} else if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");
			String type = request.getParameter("type");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			if (type == null) {
				type = "1";
			}

			int totalRecord = bnsDao.getTotalRecord(wxid, type);
			Page page = new Page(curPage, 10, totalRecord);

			List<Goods> goodses = bnsDao.getGoodses(wxid, page, type);

			request.setAttribute("page", page);
			request.setAttribute("goodses", goodses);
			request.getRequestDispatcher("/mng/gsList.jsp").forward(request,
					response);
		} else if (ac.equals("getGs")) {
			String gsId = request.getParameter("gsId");
			Goods goods = bnsDao.getGoods(gsId);

			request.setAttribute("goods", goods);
			request.getRequestDispatcher("/mng/gsAddorUpt.jsp?ac=uptGs")
					.forward(request, response);
		}
		bnsDao = null;
	}
}
