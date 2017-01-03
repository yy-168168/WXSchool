package com.wxschool.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wxschool.dao.PicDao;
import com.wxschool.dao.VoteDao;
import com.wxschool.dpo.BosService;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.Pic;
import com.wxschool.entity.Vote;
import com.wxschool.util.BackJs;

public class PicServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		// String wxaccount = request.getParameter("wxaccount");
		PicDao picDao = new PicDao();

		if (ac == null) {
		} else if (ac.equals("updateVisitPerson")) {
			String picId = request.getParameter("picId");
			picDao.updateFiled(picId, "visitPerson");
		} else if (ac.equals("updateSharePerson")) {
			String picId = request.getParameter("picId");
			picDao.updateFiled(picId, "sharePerson");
		} else if (ac.equals("getPic")) {
			String picId = request.getParameter("picId");
			Pic pic = picDao.getPicById(picId);

			request.setAttribute("pic", pic);
			request.getRequestDispatcher("/common/showPic.jsp").forward(
					request, response);
		} else if (ac.equals("uploadImgWeb")) {

			request.getRequestDispatcher("/common/uploadImgWeb.jsp").forward(
					request, response);
		} else if (ac.equals("uploadImgClient")) {
			String picUrl = request.getParameter("picUrl");
			VoteDao voteDao = new VoteDao();
			Vote vote = voteDao.getVoteByFiled(picUrl);

			if (vote == null) {// 出错
				throw new IOException();
			} else if (vote.getVoteId() == 0 || vote.getStatus() == -1) {// 没有
				BackJs
						.backJs(
								"<script type='text/javascript'>alert('照片被删除，或不存在！');</script>",
								response);
			} else {
				request.setAttribute("vote", vote);
				request.getRequestDispatcher("/common/uploadImgClient.jsp")
						.forward(request, response);
			}
			voteDao = null;
		}
		picDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		String userwx = request.getParameter("userwx");
		String wxaccount = request.getParameter("wxaccount");

		if (ac.equals("")) {
		} else if (ac.equals("uploadImgWeb")) {
			String mediaId = request.getParameter("mediaId");
			String topicId = request.getParameter("topicId");
			String content = request.getParameter("content");

			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken("gh_b315c2abe8ce");

			String reply = "wrong";
			if (token != null) {
				byte[] b = wechatService.downloadMedia(token, mediaId);

				if (b != null) {
					BosService bosService = new BosService();
					String fileUrl = bosService.addFile(b, "jpg");

					if (fileUrl != null) {
						Vote vote = new Vote();
						vote.setContent(fileUrl);
						vote.setName(content);
						vote.setTopicId(Integer.parseInt(topicId));
						vote.setWxaccount(wxaccount);
						vote.setUserwx(userwx);
						vote.setStatus(0);
						vote.setSize(0);

						VoteDao voteDao = new VoteDao();
						boolean isSuccess = voteDao.addVote(vote);

						if (isSuccess) {
							reply = "ok";
						} else {
							isSuccess = bosService.deleteFile(fileUrl);
						}
					}
					bosService = null;
				}
			}
			wechatService = null;

			BackJs.backJs(reply, response);
		} else if (ac.equals("uptContentForPic")) {
			String picId = request.getParameter("picId");
			String picUrl = request.getParameter("picUrl");
			String content = request.getParameter("content");

			boolean isSuccess = false;
			if (picId != null) {
				Vote vote = new Vote();
				vote.setVoteId(Integer.parseInt(picId));
				vote.setContent(picUrl);
				vote.setName(content);
				vote.setTopicId(-100);
				vote.setStatus(0);

				VoteDao voteDao = new VoteDao();
				isSuccess = voteDao.updateBoyGirl(vote);
				voteDao = null;
			}

			BackJs.backJs(isSuccess + "", response);
		}
	}
}
