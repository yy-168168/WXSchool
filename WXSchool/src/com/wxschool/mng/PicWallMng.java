package com.wxschool.mng;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.TopicDao;
import com.wxschool.dao.VoteDao;
import com.wxschool.dpo.BCSService;
import com.wxschool.dpo.BosService;
import com.wxschool.entity.Config;
import com.wxschool.entity.Page;
import com.wxschool.entity.Vote;
import com.wxschool.util.BackJs;

public class PicWallMng extends HttpServlet {

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
		VoteDao voteDao = new VoteDao();

		if (ac.equals("list")) {
			String scurPage = request.getParameter("c_p");
			String s_status = request.getParameter("s_t");

			int curPage = 1;
			if (scurPage != null) {
				curPage = Integer.parseInt(scurPage);
			}

			int status = 0;
			if (s_status == null || s_status.equals("")) {
			} else {
				status = Integer.parseInt(s_status);
			}

			int totalRecord = voteDao.getTotalRecordByStatus(wxid, "-100",
					status);
			Page page = new Page(curPage, 12, totalRecord);

			List<Vote> votes = voteDao.getVotesByStatus(wxid, "-100", "voteId",
					page, status);

			request.setAttribute("page", page);
			request.setAttribute("votes", votes);
			request.getRequestDispatcher("/mng/picWallList.jsp").forward(
					request, response);
		} else if (ac.equals("delete_")) {
			String picId = request.getParameter("picId");
			String picUrl = request.getParameter("picUrl");
			String status = request.getParameter("status");

			boolean isSuccess = false;
			if (status.equals("0")) {// 未审核，彻底删除
				BosService bosService = new BosService();
				isSuccess = bosService.deleteFile(picUrl);
				bosService = null;

				if (isSuccess) {
					isSuccess = voteDao.delete_Forever(picId);
				}
			} else {
				isSuccess = voteDao.changeStatus(picId, -1);
			}

			BackJs.backJs("del" + isSuccess, response);
		} else if (ac.equals("isPass")) {
			String picId = request.getParameter("picId");
			String picUrl = request.getParameter("picUrl");
			String topicId = request.getParameter("topicId");

			TopicDao topicDao = new TopicDao();
			Map<String, String> counts = topicDao.getCountOfEveryTopic(wxid,
					topicId, "2");

			String reply = "false";
			if (counts != null) {
				int capacity = 0, hasUsedCount = 0;
				for (String key : counts.keySet()) {
					capacity += Integer.parseInt(key);
					hasUsedCount += Integer.parseInt(counts.get(key));
				}

				if (capacity >= hasUsedCount) {// 没超过容量，做审核通过操作
					boolean isSuccess = false;
					if (picUrl.indexOf(Config.BCSBUKETURL) > -1) {
						BCSService bcsDao = new BCSService();
						isSuccess = bcsDao.resizeFile(picUrl);
						bcsDao = null;
					} else {
						BosService bosService = new BosService();
						isSuccess = bosService.resizeFile(picUrl);
						bosService = null;
					}

					if (isSuccess) {
						isSuccess = voteDao.changeStatus(picId, 1);
					}
					reply = isSuccess + "";
				} else {
					reply = "over";
				}
			}

			BackJs.backJs(reply, response);
		} else if (ac.equals("search")) {
			String kw = request.getParameter("keyword");

			Page page = new Page(1, 15, 15);
			List<Vote> votes = voteDao.getVotesBySearch(wxid, "-100", kw, page,
					0);

			request.setAttribute("page", page);
			request.setAttribute("votes", votes);
			request.getRequestDispatcher("/mng/picWallList.jsp").forward(
					request, response);
		}
		voteDao = null;
	}
}
