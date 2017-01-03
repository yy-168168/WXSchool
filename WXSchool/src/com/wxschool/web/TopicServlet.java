package com.wxschool.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.*;
import com.wxschool.entity.Topic;
import com.wxschool.util.BackJs;

public class TopicServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String ac = request.getParameter("ac");
		// String userwx = request.getParameter("userwx");
		// String wxaccount = request.getParameter("wxaccount");

		TopicDao topicDao = new TopicDao();

		if (ac.equals("getTopic_JSON")) {
			String topicId = request.getParameter("topicId");
			Topic topic = topicDao.getTopic(topicId);

			BackJs.backJs(JSONObject.toJSONString(topic), response);
		} else if (ac.equals("updatePersonNum")) {
			String topicId = request.getParameter("topicId");
			topicDao.updatePersonNum(topicId);
		}
		topicDao = null;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
}
