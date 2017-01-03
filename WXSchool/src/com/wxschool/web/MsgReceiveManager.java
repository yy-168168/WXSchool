package com.wxschool.web;

import java.util.*;
import java.util.regex.Pattern;
import com.wxschool.dao.*;
import com.wxschool.dpo.*;
import com.wxschool.entity.*;
import com.wxschool.util.CommonUtil;

public class MsgReceiveManager {

	private MsgSendManager msm = MsgSendManager.instance();

	/**
	 * 文本消息处理
	 * 
	 * @param developer
	 *            开发者微信号
	 * @param user
	 *            发送方帐号（一个OpenID）
	 * @param Content
	 *            文本消息内容
	 */
	public String computeText(String user, String developer,
			String receiveContent) throws Exception {

		String wxaccount = developer;

		boolean isNum = Pattern.compile("[0-9]*").matcher(receiveContent)
				.matches();// 判断发送是否是数字

		String replyContent = "";
		String replyXml = "";

		// 助手鲜果
		if (receiveContent.equals("报名")) {
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken("gh_b315c2abe8ce");
			wechatService
					.sendCustomMsg_text(token, wxaccount, user,
							"请按照语音提示，完成报名操作。助手君会在所有的报名者中随机抽取幸运者，送上免费的拼盘果切，敬请期待。\n\n回复【福利】查看活动详情");
			return msm.replyVoice(user, developer,
					"d4hpDJaomTmFvz62Fy8XMVHoaOgKxRvybpUSPwtynEA");
		}

		// 翻译功能
		if (receiveContent.startsWith("#")) {
			TranslateService tDao = new TranslateService();
			replyContent = tDao.computeReceive(wxaccount, receiveContent);
			tDao = null;
			return msm.replyText(user, developer, replyContent);
		}

		// 天气功能
		if (receiveContent.indexOf("天气") > -1) {
			WeatherService wDao = new WeatherService();
			replyContent = wDao.computeReceive(wxaccount, receiveContent);
			wDao = null;
			return msm.replyText(user, developer, replyContent);
		}

		// 课表功能
		if (receiveContent.indexOf("fdfsdfds") > -1) {
			CourseDao courseDao = new CourseDao();
			replyContent = courseDao.computeReceive(wxaccount, user);
			courseDao = null;
			return msm.replyText(user, developer, replyContent);
		}

		// 搭讪功能
		if (receiveContent.indexOf("搭讪") > -1
				|| receiveContent.indexOf("纸条") > -1) {
			return chatText(wxaccount, user);
		}

		// 拒绝对方语音消息
		if (receiveContent.equals("你走开")) {
			ChatVoiceDao chatDao = new ChatVoiceDao();

			ChatRecord record = chatDao
					.getLastChatRecord(developer, null, user);
			if (record != null && record.getMsgId() != 0) {
				boolean isSuccess = chatDao.setRecordStatusToRefuse(developer,
						record.getFrom(), user);
				if (isSuccess) {
					WechatService wechatService = new WechatService();
					String token = wechatService
							.getAccessToken("gh_b315c2abe8ce");
					if (token != null) {
						wechatService.sendCustomMsg_text(token, developer,
								record.getFrom(),
								"你的语音消息被对方拒绝，重新发送语音将随机给另一个人，祝好运");
					}
				}
			}
			record = null;
			chatDao = null;
			return "success";
		}

		// 接入多客服功能
		if (receiveContent.equals("客服")) {
			// WechatService wechatService = new WechatService();
			// String token = wechatService.getAccessToken(wxaccount);
			// wechatService.sendCustomMsg(token, user, "正在为您接入客服系统，请稍后...");
			// return msm.replyCustomerService(user, developer);
		}

		// 快递功能
		String com = ExpressService.getENname(receiveContent);
		if (com != null) {
			ExpressService expressDpo = new ExpressService();
			News ns = expressDpo.computeReceive(wxaccount, receiveContent);
			expressDpo = null;

			return msm.replyNews(user, developer, ns);
		}

		// 图文自定义回复
		List<News> nsl = new ArrayList<News>();

		ArticleDao articleDao = new ArticleDao();
		List<Article> keywords = articleDao.getKeywordsOfArticle(wxaccount);
		if (keywords != null && keywords.size() > 0) {
			StringBuffer ids = new StringBuffer();
			for (int i = 0, len1 = keywords.size(); i < len1; i++) {
				Article article = keywords.get(i);
				String[] key = article.getKeyword().split("\\|");
				for (int j = 0, len2 = key.length; j < len2; j++) {
					if ((isNum && receiveContent.equals(key[j]))
							|| (!isNum && receiveContent.indexOf(key[j]) >= 0)) {
						ids.append(article.getArticleId() + ",");
						break;
					}
				}
				key = null;
				article = null;
			}
			keywords = null;

			if (ids.length() > 0) {
				ids.deleteCharAt(ids.length() - 1);// 去掉最后一个逗号
				List<Article> articles = articleDao.getArticlesByIds(ids
						.toString());
				ids = null;

				for (int i = 0, len = articles.size(); i < len && i <= 9; i++) {
					Article article = articles.get(i);
					News ns = new News();
					String locUrl = article.getLocUrl();

					if (locUrl.indexOf("http") < 0) {
						locUrl = Config.SITEURL + locUrl;
					}

					if (locUrl.indexOf("jwc.hrbnu.edu.cn") >= 0) {// 哈师大教务平台
						locUrl += user.substring(6);
					} else {
						if (locUrl.indexOf(Config.SITEURL) < 0) {// 非本网站的网址
							locUrl = Config.SITEURL
									+ "/mobile/article?ac=getArticleDt";
						}

						locUrl += locUrl.indexOf("?") > -1 ? "&" : "?";

						if (locUrl.indexOf("wxaccount") < 0) {
							locUrl += "wxaccount=" + wxaccount;
						}

						if (locUrl.indexOf("userwx") < 0) {
							locUrl += "&userwx=" + user;
						}

						locUrl += "&aId=" + article.getArticleId()+"&t=";
					}

					ns.setUrl(locUrl);
					ns.setTitle(article.getTitle());
					ns.setDescription(article.getDesc());
					ns.setPicUrl(article.getPicUrl());

					nsl.add(ns);
					article = null;
				}

				articles = null;
				if (nsl.size() > 9) {
					replyXml = msm.replyNewsList(user, developer, nsl);
					nsl = null;
					return replyXml;
				}
			}
		}

		// 图片自定义回复
		PicDao picDao = new PicDao();
		List<Pic> pics = picDao.getPics(wxaccount);
		if (pics != null && pics.size() > 0) {
			for (int i = 0, len1 = pics.size(); i < len1; i++) {
				if (nsl.size() > 9) {
					break;
				}

				Pic pic = pics.get(i);
				String[] key = pic.getKeyword().split("\\|");
				for (int j = 0, len2 = key.length; j < len2; j++) {
					if ((isNum && receiveContent.equals(key[j]))
							|| (!isNum && receiveContent.indexOf(key[j]) >= 0)) {
						int picId = pic.getPicId();

						News ns = new News();
						ns.setTitle(pic.getTitle());
						String locUrl = Config.SITEURL
								+ "/mobile/pic?ac=getPic&wxaccount="
								+ wxaccount + "&picId=" + picId+"&t=";
						ns.setUrl(locUrl);
						ns.setPicUrl("");
						ns.setDescription(pic.getDesc());

						nsl.add(ns);
						break;
					}
				}
				key = null;
				pic = null;
			}
			pics = null;
			picDao = null;

			if (nsl.size() > 9) {
				replyXml = msm.replyNewsList(user, developer, nsl);
				nsl = null;
				return replyXml;
			}
		}

		// 文本自定义回复
		int nslSize = nsl.size();
		TextDao textDao = new TextDao();
		List<Text> texts = textDao.getTexts(wxaccount);
		if (texts != null && texts.size() > 0) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0, len1 = texts.size(); i < len1; i++) {
				if (nsl.size() > 9) {
					break;
				}

				Text text = texts.get(i);
				String[] key = text.getKey().split("\\|");
				for (int j = 0, len2 = key.length; j < len2; j++) {
					if ((isNum && receiveContent.equals(key[j]))
							|| (!isNum && receiveContent.indexOf(key[j]) >= 0)) {
						String val = text.getValue();

						News ns = new News();
						ns.setTitle(val);
						ns.setUrl("");
						ns.setDescription("");
						ns.setPicUrl("");
						nsl.add(ns);

						if (sb.length() > 0) {
							sb.append("\n\n");
						}
						sb.append(val);
						break;
					}
				}
				key = null;
				text = null;
			}
			texts = null;
			textDao = null;
			replyContent = sb.toString();
			sb = null;
		}

		if (nslSize == 0) {// 回复文字
			if (replyContent.length() > 0) {
				return msm.replyText(user, developer, replyContent);
			}
		} else {// 回复图文
			replyXml = msm.replyNewsList(user, developer, nsl);
			nsl = null;
			return replyXml;
		}

		// 图灵接口
		AccountDao accountDao = new AccountDao();
		String chat = accountDao.getContent(wxaccount, "robotChat");
		if (chat.equals("") || Integer.parseInt(chat) > 0) {
			TuringService turingDpo = new TuringService();
			replyXml = turingDpo.compute(user, developer, receiveContent);
			turingDpo = null;
		}
		accountDao = null;
		return replyXml;
	}

	/**
	 * 图片消息处理
	 * 
	 * @param developer
	 *            开发者微信号
	 * @param user
	 *            发送方帐号（一个OpenID）
	 * @param PicUrl
	 *            图片链接
	 * @param mediaId
	 *            图片消息媒体id，可以调用多媒体文件下载接口拉取数据
	 */
	public String computeImage(String user, String developer, String picUrl,
			String mediaId) throws Exception {
		String replyContent = "亲，照片上传失败，请重试/::)";

		BosService bosService = new BosService();
		String fileUrl = bosService.addFile(picUrl);

		if (fileUrl != null) {
			Vote vote = new Vote();
			vote.setContent(fileUrl);
			vote.setName("");
			vote.setTopicId(-100);
			vote.setWxaccount(developer);
			vote.setUserwx(user);
			vote.setStatus(0);
			vote.setSize(0);

			VoteDao voteDao = new VoteDao();
			boolean isSuccess = voteDao.addVote(vote);
			if (isSuccess) {
				News news = new News();
				news.setTitle("点此为图片提供相关信息");
				news.setPicUrl(vote.getContent());
				String locUrl = Config.SITEURL
						+ "/mobile/pic?ac=uploadImgClient&wxaccount="
						+ developer + "&userwx=" + user + "&picUrl="
						+ vote.getContent()+"&t=";
				news.setUrl(locUrl);
				return msm.replyNews(user, developer, news);
			} else {
				// BCSService bcsDao = new BCSService();
				isSuccess = bosService.deleteFile(fileUrl);
				// bcsDao = null;
			}

		}
		bosService = null;
		return msm.replyText(user, developer, replyContent);
	}

	/**
	 * 语音消息处理
	 * 
	 * @param developer
	 *            开发者微信号
	 * @param user
	 *            发送方帐号（一个OpenID）
	 * @param format
	 *            语音格式，如amr，speex等
	 * @param mediaId
	 *            图片消息媒体id，可以调用多媒体文件下载接口拉取数据
	 */
	public String computeVoice(String user, String developer, String format,
			String mediaId) throws Exception {

		// 语音权限验证
		AccountDao accountDao = new AccountDao();
		String chat = accountDao.getContent(developer, "voiceChat");
		accountDao = null;
		if (chat.equals("") || Integer.parseInt(chat) == -1) {
			return "success";
		}

		String replyContent = "语音发送失败，请重试/::)";

		WechatService wechatService = new WechatService();
		String token = wechatService.getAccessToken("gh_b315c2abe8ce");

		// 查找上次聊天人
		ChatVoiceDao chatDao = new ChatVoiceDao();
		ChatRecord lastRecordFromOther = chatDao.getLastChatRecord(developer,
				null, user);
		if (lastRecordFromOther != null) {
			// 没有人与自己聊过，或对方不在线，或我拒绝了对方最后一条消息，将随机发送
			if (lastRecordFromOther.getMsgId() == 0
					|| !lastRecordFromOther.getWxUser().isOnline()
					|| lastRecordFromOther.getStatus() == 2) {
				replyContent = chatVoice(token, developer, user, null, mediaId,
						format, true);
			} else {// 继续回复
				List<ChatRecord> recordsFromMy = chatDao.getChatRecords(
						developer, user, lastRecordFromOther.getFrom(),
						new Page(1, 10, 10), true);
				if (recordsFromMy != null) {
					if (recordsFromMy.size() == 0) {// 没有回复过
						replyContent = chatVoice(token, developer, user,
								lastRecordFromOther.getFrom(), mediaId, format,
								true);
					} else if (recordsFromMy.get(0).getStatus() == 2) {// 我发出的最后一条语音消息被拒绝，将随机发送
						replyContent = chatVoice(token, developer, user, null,
								mediaId, format, true);
					} else {
						boolean isNeedNotice = false;
						// 消息超过6小时
						long diff_s = CommonUtil
								.getDiffSecondOfNow(recordsFromMy.get(0)
										.getAddTime());
						if (diff_s / (60 * 60) >= 6) {
							isNeedNotice = true;
						}
						replyContent = chatVoice(token, developer, user,
								lastRecordFromOther.getFrom(), mediaId, format,
								isNeedNotice);
					}
				}
			}
		}
		chatDao = null;
		wechatService = null;

		if (replyContent.equals("success")) {
			return "success";
		} else {
			return msm.replyText(user, developer, replyContent);
		}
	}

	/**
	 * 视频消息处理
	 * 
	 * @param developer
	 *            开发者微信号
	 * @param user
	 *            发送方帐号（一个OpenID）
	 * @param thumbMediaId
	 *            视频消息缩略图的媒体id，可以调用多媒体文件下载接口拉取数据
	 * @param mediaId
	 *            图片消息媒体id，可以调用多媒体文件下载接口拉取数据
	 */
	public String computeVideo(String user, String developer,
			String thumbMediaId, String mediaId) throws Exception {
		return msm.replyText(user, developer, "/::<亲，我视力有点差，看不清视频");
	}

	/**
	 * 地理位置消息处理
	 * 
	 * @param developer
	 *            开发者微信号
	 * @param user
	 *            发送方帐号（一个OpenID）
	 * @param Location_X
	 *            地理位置纬度
	 * @param Location_Y
	 *            地理位置经度
	 * @param Scale
	 *            地图缩放大小
	 * @param Label
	 *            地理位置信息
	 */
	public String computeLocation(String user, String developer,
			String locationX, String locationY, String scale, String label)
			throws Exception {
		AccountDao aDao = new AccountDao();
		aDao.updateFiled(developer, "location", 1);
		aDao = null;

		News ns = new News();
		ns.setTitle("开启定位模式");
		ns.setPicUrl("http://t2.qpic.cn"
				+ "/mblogpic/a89ba66cf577b0e04c26/2000");
		ns.setDescription("查找周围的公厕，银行，网吧，超市，酒店，商场，"
				+ "火车票代售点，旅游景点，公交站，地铁站，麦当劳，肯德基，德克士。。。");
		ns.setUrl(Config.SITEURL + "/map/searchRound.jsp?px=" + locationX
				+ "&py=" + locationY + "&tar=wc");

		return msm.replyNews(user, developer, ns);
	}

	/**
	 * 链接消息处理
	 * 
	 * @param user
	 *            接收方微信号
	 * @param developer
	 *            发送方微信号，若为普通用户，则是一个OpenID
	 * @param Title
	 *            消息标题
	 * @param Description
	 *            消息描述
	 * @param Url
	 *            消息链接
	 */
	public String computeLink(String user, String developer, String title,
			String description, String url) throws Exception {
		return msm.replyText(user, developer, "亲，您发送此链接的目的是？/::)");
	}

	/**
	 * 事件推送消息处理
	 * 
	 * @param developer
	 *            接收方微信号
	 * @param user
	 *            发送方微信号，若为普通用户，则是一个OpenID
	 * @param Event
	 *            事件类型，subscribe(订阅)、unsubscribe(取消订阅)、CLICK(自定义菜单点击事件)、VIEW(
	 *            自定义菜单网页跳转事件 )
	 * @param EventKey
	 *            事件KEY值，与自定义菜单接口中KEY值对应
	 */
	public String computeEvent(String user, String developer, String event,
			String eventKey) throws Exception {

		String wxaccount = developer;
		String replyContent = "";
		String replyXml = "";

		if (event.equalsIgnoreCase("unsubscribe")) {// 取消关注
			WxUserDao wxUserDao = new WxUserDao();
			wxUserDao.unsubscribe(developer, user);
			wxUserDao = null;

			AccountDao aDao = new AccountDao();
			aDao.updateFiled(developer, "fans", -1);
			aDao = null;
		} else if (event.equalsIgnoreCase("kf_create_session")) {// 创建客服
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);
			if (token != null) {
				wechatService.sendCustomMsg_text(token, developer, user,
						"您好，客服小手为您服务，请问您需要什么帮助/::)");
			}
			wechatService = null;
		} else if (event.equalsIgnoreCase("kf_close_session")) {// 关闭客服
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);
			if (token != null) {
				wechatService.sendCustomMsg_text(token, developer, user,
						"客服系统已关闭，下次有问题请继续回复【客服】/:bye");
			}
			wechatService = null;
		} else if (event.equalsIgnoreCase("user_get_card")) {// 领取卡券

		} else if (event.equalsIgnoreCase("user_del_card")) {

		} else if (event.equalsIgnoreCase("user_consume_card")) {

		} else if (event.equalsIgnoreCase("card_sku_remind")) {

		} else if (event.equalsIgnoreCase("user_enter_session_from_card")) {

		} else if (event.equalsIgnoreCase("MASSSENDJOBFINISH")) {// 群发结果

		} else {
			List<News> nsList = new ArrayList<News>();
			News ns = new News();

			if (event.equalsIgnoreCase("subscribe")) {// 关注
				eventKey = "subscribe";

				AccountDao aDao = new AccountDao();
				aDao.updateFiled(developer, "fans", 1);
				String fans = aDao.getContent(wxaccount, "fans");
				aDao = null;

				ns = new News();
				ns.setTitle("终于等到您，第" + fans + "位关注者");
				ns.setDescription("");
				ns.setPicUrl("");
				ns.setUrl("");

				nsList.add(ns);
			} else if (event.equalsIgnoreCase("CLICK")) {// 自定义菜单
			}

			// 记录eventKey异常
			if (eventKey == null) {
				LogDao.getLog().addNorLog("event:" + event);
				return msm.replyText(user, developer, "");
			}

			// 聊天
			if (eventKey.equals("key_hi")) {
				return chatText(wxaccount, user);
			}

			// 图文回复处理
			ArticleDao articleDao = new ArticleDao();
			List<Article> articles = articleDao.getArticlesByKeyword(wxaccount,
					eventKey);
			articleDao = null;

			if (articles != null && articles.size() > 0) {
				for (int i = 0, len = articles.size(); i < len; i++) {
					Article article = articles.get(i);
					String locUrl = article.getLocUrl();

					if (locUrl.indexOf("http") < 0) {
						locUrl = Config.SITEURL + locUrl;
					}

					if (locUrl.indexOf("jwc.hrbnu.edu.cn") >= 0) {// 哈师大教务平台
						locUrl += user.substring(6);
					} else {
						if (locUrl.indexOf(Config.SITEURL) < 0) {// 非本站网址
							locUrl = Config.SITEURL
									+ "/mobile/article?ac=getArticleDt";
						}

						locUrl += locUrl.indexOf("?") > -1 ? "&" : "?";

						if (locUrl.indexOf("wxaccount") < 0) {
							locUrl += "wxaccount=" + wxaccount;
						}

						if (locUrl.indexOf("userwx") < 0) {
							locUrl += "&userwx=" + user;
						}

						locUrl += "&aId=" + article.getArticleId()+"&t=";
					}

					ns = new News();
					ns.setUrl(locUrl);
					ns.setTitle(article.getTitle());
					ns.setDescription(article.getDesc());
					ns.setPicUrl(article.getPicUrl());

					nsList.add(ns);
					article = null;

					if (nsList.size() >= 10) {
						replyXml = msm.replyNewsList(user, developer, nsList);
						nsList = null;
						return replyXml;
					}
				}
				articles = null;
			}

			// 图片自定义回复
			PicDao picDao = new PicDao();
			List<Pic> pics = picDao.getPicsByKeyword(wxaccount, eventKey);
			picDao = null;

			if (pics != null && pics.size() > 0) {
				for (int i = 0, len1 = pics.size(); i < len1; i++) {

					Pic pic = pics.get(i);
					int picId = pic.getPicId();

					ns = new News();
					ns.setTitle(pic.getTitle());
					String locUrl = Config.SITEURL
							+ "/mobile/pic?ac=getPic&wxaccount=" + wxaccount
							+ "&picId=" + picId+"&t=";
					ns.setUrl(locUrl);
					ns.setPicUrl("");
					ns.setDescription(pic.getDesc());

					nsList.add(ns);
					pic = null;

					if (nsList.size() >= 10) {
						replyXml = msm.replyNewsList(user, developer, nsList);
						nsList = null;
						return replyXml;
					}
				}
				pics = null;
			}

			// 文字回复处理
			int nslSize = nsList.size();
			TextDao textDao = new TextDao();
			List<Text> texts = textDao.getTextsByKeyword(wxaccount, eventKey);
			textDao = null;

			if (texts != null && texts.size() > 0) {
				StringBuffer sb = new StringBuffer();
				for (int i = 0, len = texts.size(); i < len; i++) {
					Text text = texts.get(i);
					String val = text.getValue();

					if (!val.equals("")) {
						if (nslSize == 0) {
							sb.append(val);
							if (i != len - 1) {
								sb.append("\n\n");
							}
						} else {
							ns = new News();
							ns.setTitle(val);
							ns.setDescription("");
							ns.setPicUrl("");
							ns.setUrl("");
							nsList.add(ns);

							if (nsList.size() >= 10) {
								break;
							}
						}
					}
				}
				replyContent = sb.toString();
				sb = null;
			}

			if (!replyContent.equals("")) {
				replyXml = msm.replyText(user, developer, replyContent);
				return replyXml;
			} else {
				if (nsList.size() > 0) {
					replyXml = msm.replyNewsList(user, developer, nsList);
					nsList = null;
					return replyXml;
				}
			}
		}
		return msm.replyText(user, developer, "/::)");
	}

	// 用户操作记录
	public void afterCompute(OperateRecord record, boolean isAuth)
			throws Exception {
		String wxaccount = record.getWxaccount();
		String userwx = record.getUserwx();

		WxUserDao wxUserDao = new WxUserDao();
		WxUser wxUser = wxUserDao.getUser_simple(wxaccount, userwx);

		if (wxUser != null) {
			WechatService wechatService = new WechatService();
			String token = wechatService.getAccessToken(wxaccount);

			if (wxUser.getUserId() == 0) {// 不存在该用户，插入
				if (isAuth) {// 认证账号
					if (token != null) {
						WxUser user = wechatService.getUserInfo(token, userwx);
						if (user != null) {
							user.setWxaccount(wxaccount);
							wxUserDao.addUser(user);
						}
					}
				} else {
					WxUser user = new WxUser();
					user.setLastUsedTime(String.format("%tF %<tT", new Date()
							.getTime()));
					user.setSubscribeTime(String.format("%tF %<tT", new Date()
							.getTime()));
					user.setUserwx(userwx);
					user.setWxaccount(wxaccount);
					wxUserDao.addUser(user);
				}
			} else {
				// 更新最后使用时间
				wxUserDao.updateLastUsedTime(wxaccount, userwx);
			}
			wechatService = null;
		}
		wxUserDao = null;

		// 记录操作
		OperateRecordDao operateRecordDao = new OperateRecordDao();
		operateRecordDao.addRecord(record);
	}

	// 文字聊天
	private String chatText(String wxaccount, String userwx) throws Exception {
		AccountDao accountDao = new AccountDao();
		String chat = accountDao.getContent(wxaccount, "textChat");
		accountDao = null;

		if (chat.equals("") || Integer.parseInt(chat) > 0) {
			WxUserDao wxUserDao = new WxUserDao();
			WxUser wxUser = wxUserDao.getUser_simple(wxaccount, userwx);

			if (wxUser == null || wxUser.getUserId() == 0) {
				wxUserDao = null;
				return msm.replyText(userwx, wxaccount, "亲，请再试一次");
			} else {
				int sex = wxUser.getSex();
				sex = sex == 0 ? 0 : sex == 1 ? 2 : 1;

				List<ChatRecord> users = wxUserDao.getChatUsers(wxaccount, sex,
						Config.WECHATCUSTOMMSGVALIDTIME, 0, 9);
				/*
				 * if (users == null) { users =
				 * wxUserDao.getChatUsers(wxaccount, sex,
				 * Config.WECHATCUSTOMMSGVALIDTIME, 0, 9); } else {
				 * List<ChatRecord> level0Users = wxUserDao.getChatUsers(
				 * wxaccount, sex, Config.WECHATCUSTOMMSGVALIDTIME, 0, 9 -
				 * users.size()); users.addAll(level0Users); }
				 */

				if (users == null || users.size() == 0) {
					users = null;
					return msm.replyText(userwx, wxaccount, "亲，请再试一次");
				} else {
					int countOFOnline = wxUserDao
							.getTotalRecordOfLastUsedUsers(wxaccount, 48);
					wxUserDao = null;

					List<News> nsl = new ArrayList<News>();
					News ns = new News();
					ns.setTitle("随机搭讪--总有新奇在身边！当前有" + countOFOnline
							+ "人在线！(点此设置相关信息及查看所有记录)");
					ns.setPicUrl("");
					ns.setUrl(Config.SITEURL
							+ "/mobile/chat/text?ac=wxInfo&wxaccount="
							+ wxaccount + "&userwx=" + userwx+"&t=");
					nsl.add(ns);

					String[] userwxs = new String[users.size()];// userwx数组

					for (int i = 0; i < users.size(); i++) {
						ns = new News();

						ChatRecord record = users.get(i);
						WxUser wxUser2 = record.getWxUser();
						Student stu = record.getStudent();

						StringBuffer title = new StringBuffer(wxUser2
								.getNickname());
						if (wxUser2.getSex() == 1) {
							title.append("汉纸");
						} else if (wxUser2.getSex() == 2) {
							title.append("妹纸");
						}

						if (!stu.getDepart().equals("")) {
							title.append("--");
							title.append(stu.getGrade());
							title.append("级");
							title.append(stu.getDepart());
							title.append(stu.getMajor());
							title.append("专业");
						}
						ns.setTitle(title.toString());

						String headImgUrl = wxUser2.getHeadImgUrl();
						if (i == 0) {
							ns.setPicUrl(headImgUrl);
						} else {
							int img_i = headImgUrl.lastIndexOf("/");
							if (img_i > -1) {
								ns.setPicUrl(headImgUrl.substring(0, img_i)
										+ "/96");
							} else {
								ns.setPicUrl(headImgUrl);
							}
						}

						ns.setUrl(Config.SITEURL
								+ "/mobile/chat/text?ac=chat&wxaccount="
								+ wxaccount + "&userwx=" + userwx + "&to="
								+ UUID.randomUUID().toString()
								+ wxUser2.getUserId()+"&t=");
						nsl.add(ns);

						userwxs[i] = wxUser2.getUserwx();
					}
					users = null;

					// 启动更新用户微信信息的线程
					UpdateUserInfoThread uuit = new UpdateUserInfoThread(
							wxaccount, userwxs);
					Thread t = new Thread(uuit);
					t.start();

					return msm.replyNewsList(userwx, wxaccount, nsl);
				}
			}
		} else {
			return msm.replyText(userwx, wxaccount, "功能升级中...");
		}
	}

	/**
	 * 
	 * @param token
	 * @param wxaccount
	 * @param userwx
	 * @return
	 */
	private String chatVoice(String token, String wxaccount, String from,
			String to, String mediaId, String format, boolean isNeedNotice)
			throws Exception {
		String replyContent = "语音发送失败，请重试/::)";

		WxUserDao wxUserDao = new WxUserDao();
		WxUser wxUser = wxUserDao.getUser_simple(wxaccount, from);
		if (wxUser == null || wxUser.getUserId() == 0) {
			return replyContent;
		}

		// 获取随机聊天人的openId
		if (to == null) {
			int sex = wxUser.getSex();
			sex = sex == 0 ? 0 : sex == 1 ? 2 : 1;

			List<ChatRecord> users = wxUserDao.getChatUsers(wxaccount, sex,
					Config.WECHATCUSTOMMSGVALIDTIME, 0, 1);
			if (users == null || users.size() == 0) {
			} else {
				to = users.get(0).getWxUser().getUserwx();
			}
			users = null;
		}

		if (to != null) {
			WechatService wechatService = new WechatService();
			// 发送语音客服消息
			if (token != null) {
				String result = wechatService.sendCustomMsg_voice(token,
						wxaccount, to, mediaId);

				if (result.equals("ok")) {
					replyContent = "success";

					// 发送提示客服消息(随机，或者超过6小时)
					if (isNeedNotice) {
						wechatService
								.sendCustomMsg_text(
										token,
										wxaccount,
										to,
										"你收到一条来自"
												+ wxUser.getNickname()
												+ "的语音消息\n\n如想搭讪TA，请继续回复语音\n如若嫌弃，请回复文字:你走开");

						// 四位神秘用户
						/*
						 * if (to.equals("owRT7jtwCxFFIHXm0F_Hc7fa9_go") ||
						 * to.equals("owRT7jnIJiBixRx_AayTXOCtfcMg") ||
						 * to.equals("owRT7jtOkhOHi045tgn2l6RzGd3U") ||
						 * to.equals("owRT7jjuueL2nw6ZW6BLhs4GPCTs")) {
						 * 
						 * WxUser sUser = wxUserDao.getUser_simple(wxaccount,
						 * to); if (sUser != null && sUser.getUserId() != 0) {
						 * // 获奖凭证 List<News> newsList = new ArrayList<News>();
						 * // 第一条 News news = new News();
						 * news.setTitle("恭喜你邂逅四位神秘人之一，获得彩蛋");
						 * news.setPicUrl(sUser.getHeadImgUrl());
						 * newsList.add(news); // 第二条 String anhao = CommonUtil
						 * .getRandomChineseCharacter(2); news = new
						 * News("点击进入扫码添加微信，领奖暗号是：" + anhao);
						 * news.setUrl(Config.SITEURL +
						 * "/mobile/pic?ac=getPic&wxaccount=" + wxaccount +
						 * "&picId=108"); newsList.add(news);
						 * wechatService.sendCustomMsg_newsList(token,
						 * wxaccount, from, newsList); // 管理员凭证
						 * wechatService.sendCustomMsg_text(token, wxaccount,
						 * "owRT7jtwCxFFIHXm0F_Hc7fa9_go", wxUser .getNickname()
						 * + "的领奖暗号是：" + anhao); } }
						 */
					}
				} else if (result.equals("refuse")) {
					replyContent = "语音消息被对方拒收，请重新回复";
				}
			}

			// 下载语音，存储语音资源，保存记录到数据库
			if (token != null) {
				byte[] b = wechatService.downloadMedia(token, mediaId);
				String fileUrl = "";
				if (b != null) {
					BosService bosService = new BosService();
					fileUrl = bosService.addFile(b, format);
					fileUrl = fileUrl == null ? "" : fileUrl;
					bosService = null;
				}

				ChatRecord record = new ChatRecord();
				record.setContent(fileUrl);
				record.setFrom(from);
				record.setTo(to);
				record.setWxaccount(wxaccount);
				record.setMediaId(mediaId);

				ChatVoiceDao chatDao = new ChatVoiceDao();
				chatDao.addRecord(record);
				chatDao = null;
			}
			wechatService = null;
		}

		wxUserDao = null;
		return replyContent;
	}
}
