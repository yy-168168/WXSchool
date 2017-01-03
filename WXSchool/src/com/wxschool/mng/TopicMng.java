package com.wxschool.mng;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.TopicDao;
import com.wxschool.entity.Topic;
import com.wxschool.util.BackJs;

public class TopicMng extends HttpServlet {

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
		TopicDao topicDao = new TopicDao();

		if (ac.equals("listPic")) {
			List<Topic> topics = topicDao.getTopics(wxid, "2", false);

			request.setAttribute("topics", topics);
			request.getRequestDispatcher("/mng/topicList_pic.jsp").forward(
					request, response);
		} else if (ac.equals("listText")) {
			List<Topic> topics = topicDao.getTopics(wxid, "3", false);

			request.setAttribute("topics", topics);
			request.getRequestDispatcher("/mng/topicList_text.jsp").forward(
					request, response);
		} else if (ac.equals("getTopic")) {
			String topicId = request.getParameter("topicId");
			Topic topic = topicDao.getTopic(topicId);

			request.setAttribute("topic", topic);
			request.getRequestDispatcher(
					"/mng/topicAddorUpt_pic.jsp?ac=uptTopic").forward(request,
					response);
		} else if (ac.equals("addTopic_")) {
			request.getRequestDispatcher(
					"/mng/topicAddorUpt_pic.jsp?ac=addTopic").forward(request,
					response);
		} else if (ac.equals("delete_")) {
			String topicId = request.getParameter("topicId");
			topicDao.delete(topicId);
			return;
		} else if (ac.equals("uptTopic") || ac.equals("addTopic")) {
			String topicId = request.getParameter("topicId");
			String desc = request.getParameter("desc".trim());
			String overTime = request.getParameter("overTime".trim());
			String title = request.getParameter("title").trim();
			String info = request.getParameter("info").trim();
			String isAllValid = request.getParameter("isAllValid").trim();

			Topic topic = new Topic();
			topic.setDesc(desc);
			topic.setTitle(title);
			topic.setInfo(info);

			if (isAllValid.equals("true")) {
				topic.setOverTime("3000-01-01 00:00:00");
			} else {
				topic.setOverTime(overTime);
			}

			boolean isSuccess = false;
			if (ac.equals("uptTopic")) {
				topic.setTopicId(Integer.parseInt(topicId));

				isSuccess = topicDao.updateTopic(topic);
				BackJs.backJs("upt" + isSuccess, response);
			} else if (ac.equals("addTopic")) {
				topic.setCate(21);
				topic.setWxaccount(wxid);

				isSuccess = topicDao.addTopic(topic);
				BackJs.backJs("add" + isSuccess, response);
			}
		} else if (ac.equals("getTopicsOfPic")) {
			List<Topic> topics = topicDao.getTopics(wxid, "2", true);
			BackJs.backJs(JSONObject.toJSONString(topics), response);
		}
		topicDao = null;
	}
}
