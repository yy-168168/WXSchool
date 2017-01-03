package com.wxschool.web;

import java.util.*;
import java.util.regex.Pattern;
import com.wxschool.dao.*;
import com.wxschool.dpo.*;
import com.wxschool.entity.*;
import com.wxschool.util.CommonUtil;

public class MsgReceiveManagerOld2 {

	private static String url = "http://schoolhand.duapp.com/";
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
			String receiveContent) {
		String wxaccount = developer;

		boolean isNum = Pattern.compile("[0-9]*").matcher(receiveContent)
				.matches();// 判断发送是否是数字

		String replyContent = "";
		String replyXml = "";

		// 获取密钥
		if (receiveContent.toLowerCase().equals("getkey")) {
			replyContent = getKey(wxaccount, user);
			return msm.replyText(user, developer, replyContent);
		}

		// 翻译功能
		if (receiveContent.indexOf("翻译") >= 0) {
			replyContent = "翻译的格式为：@您要翻译的词。如：@我爱你";
			return msm.replyText(user, developer, replyContent);
		}
		if (receiveContent.startsWith("@")) {
			replyContent = "翻译的格式为：@您要翻译的词。如：@我爱你";
			String word = receiveContent.substring(1);
			if (!word.equals("")) {
				AccountDao aDao = new AccountDao();
				aDao.updateFiled(wxaccount, "translate", 1);
				aDao = null;
				TranslateService tDao = new TranslateService();
				replyContent = tDao.translate(word);
				tDao = null;
			}
			return msm.replyText(user, developer, replyContent);
		}

		// 天气功能
		if (receiveContent.indexOf("天气") >= 0) {
			AccountDao aDao = new AccountDao();
			aDao.updateFiled(wxaccount, "weather", 1);
			aDao = null;
			WeatherService wDao = new WeatherService();
			String city = "";
			if (receiveContent.equals("天气")
					|| receiveContent.matches(".*天气.*查.*")
					|| receiveContent.matches(".*查.*天气.*")) {
				city = "哈尔滨";
			} else if (receiveContent.startsWith("天气")) {
				city = receiveContent.substring(2).trim();
			} else if (receiveContent.endsWith("天气")) {
				city = receiveContent.substring(0, receiveContent.length() - 2)
						.trim();
			} else {
				city = "哈尔滨";
			}
			replyContent = wDao.getWeather(city);
			wDao = null;
			return msm.replyText(user, developer, replyContent);
		}

		// 快递功能
		if (receiveContent.indexOf("快递") >= 0) {
			replyContent = "查快递的格式为：\n快递公司名  运单号"
					+ "\n如：圆通  3230169980\n\n支持的快递公司有："
					+ "\n全峰  申通  顺丰  天天\n圆通  韵达  中铁  中通"
					+ "\n中邮  汇通  国通  优速\nEMS 邮政小包 邮政平邮"
					+ "\n\n<a href='http://m.kuaidi100.com/uc/index.html'>点此使用网址查询</a>";
			return msm.replyText(user, developer, replyContent);
		}
		String com = null;
		if (receiveContent.matches(".*邮政.*小包.*")) {
			com = "pingyou";
		} else if (receiveContent.matches(".*邮政.*平邮.*")) {
			com = "pingyou";
		} else if (receiveContent.toLowerCase().matches(".*ems.*")
				|| receiveContent.matches(".*邮政.*")) {
			com = "ems";
		} else if (receiveContent.length() >= 2) {
			com = ExpressService.getENname(receiveContent.substring(0, 2));
		}
		if (com != null) {
			String ex = "";
			String num = "";
			AccountDao aDao = new AccountDao();
			aDao.updateFiled(wxaccount, "express", 1);
			aDao = null;
			if (receiveContent.matches(".*邮政.*小包.*")) {
				num = receiveContent.substring(receiveContent.indexOf("包") + 1)
						.trim();
			} else if (receiveContent.matches(".*邮政.*平邮.*")) {
				num = receiveContent
						.substring(receiveContent.indexOf("平邮") + 2).trim();
			} else if (receiveContent.toLowerCase().matches(".*ems.*")) {
				num = receiveContent.substring(3).trim();
			} else {
				num = receiveContent.substring(2).trim();

			}
			ExpressService expressDpo = new ExpressService();
			ex = expressDpo.getExpress(developer, com, num);
			expressDpo = null;
			if (ex.matches(".*错误.*") || ex.matches(".*不存在.*")) {
				ex += ",格式如:\n圆通  3230169980\n邮政分:EMS  邮政小包  邮政平邮\n\n"
						+ "<a href='http://m.kuaidi100.com/uc/index.html'>点此使用网址查询</a>";
			}
			replyContent = ex;
			return msm.replyText(user, developer, replyContent);
		}

		// 文本自定义回复
		TextDao textDao = new TextDao();
		List<Text> texts = textDao.getTexts(wxaccount);
		if (texts != null && texts.size() > 0) {
			boolean flag = false;
			for (int i = 0, len1 = texts.size(); !flag && i < len1; i++) {
				Text text = texts.get(i);
				String[] key = text.getKey().split("\\|");
				for (int j = 0, len2 = key.length; !flag && j < len2; j++) {
					if ((isNum && receiveContent.equals(key[j]))
							|| (!isNum && receiveContent.indexOf(key[j]) >= 0)) {
						replyContent = text.getValue();
						flag = true;
					}
				}
				key = null;
				text = null;
			}
			texts = null;
			textDao = null;
			if (flag) {
				return msm.replyText(user, developer, replyContent);
			}
		}

		// 图文自定义回复
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
				List<News> nsl = new ArrayList<News>();

				for (int i = 0, len = articles.size(); i < len; i++) {
					Article article = articles.get(i);
					News ns = new News();
					String locUrl = article.getLocUrl();
					// if (locUrl.matches(".*apiwx.*")) {
					// ns.setUrl(locUrl.replace("fromUsername", user));
					// } else
					if (locUrl.indexOf("http") >= 0) {
						ns.setUrl(url + "articles?ac=getArticleDt&wxaccount="
								+ wxaccount + "&userwx=" + user + "&aId="
								+ article.getArticleId());
					} else if (locUrl.indexOf("?") >= 0) {
						ns.setUrl(url + locUrl + "&wxaccount=" + wxaccount
								+ "&userwx=" + user + "&aId="
								+ article.getArticleId());
					} else {
						ns.setUrl(url + locUrl + "?wxaccount=" + wxaccount
								+ "&userwx=" + user + "&aId="
								+ article.getArticleId());
					}

					ns.setTitle(article.getTitle());
					ns.setDescription(article.getDesc());
					ns.setPicUrl(article.getPicUrl());

					nsl.add(ns);
					article = null;
					if (nsl.size() > 9) {
						break;
					}
				}

				articles = null;
				if (nsl != null && nsl.size() > 0) {
					replyXml = msm.replyNewsList(user, developer, nsl);
					nsl = null;
					return replyXml;
				}
			}
		}

		// 图灵接口
		TuringService turingDpo = new TuringService();
		replyXml = turingDpo.compute(user, developer, receiveContent);
		turingDpo = null;
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
	 */
	public String computeImage(String user, String developer, String picUrl) {
		// AccountDao aDao = new AccountDao();

		return msm.replyText(user, developer, "照片已经收到，稍后为您处理。");
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
			String locationX, String locationY, String scale, String label) {
		AccountDao aDao = new AccountDao();
		aDao.updateFiled(developer, "location", 1);
		aDao = null;
		News ns = new News();
		ns.setTitle("开启定位模式");
		ns.setPicUrl("http://t2.qpic.cn"
				+ "/mblogpic/a89ba66cf577b0e04c26/2000");
		ns.setDescription("查找周围的公厕，银行，网吧，超市，酒店，商场，"
				+ "火车票代售点，旅游景点，公交站，地铁站，麦当劳，肯德基，德克士。。。");
		ns.setUrl(url + "map/searchRound.jsp?px=" + locationX + "&py="
				+ locationY + "&tar=wc");
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
			String description, String url) {
		return null;
	}

	/**
	 * 事件推送消息处理
	 * 
	 * @param developer
	 *            接收方微信号
	 * @param user
	 *            发送方微信号，若为普通用户，则是一个OpenID
	 * @param Event
	 *            事件类型，subscribe(订阅)、unsubscribe(取消订阅)、CLICK(自定义菜单点击事件)
	 * @param EventKey
	 *            事件KEY值，与自定义菜单接口中KEY值对应
	 */
	public String computeEvent(String user, String developer, String event,
			String eventKey) {
		String wxaccount = developer;
		String replyXml = "";

		if (event.equals("subscribe")) {// 关注
			AccountDao aDao = new AccountDao();
			aDao.updateFiled(developer, "fans", 1);
			aDao = null;
			List<Article> articles = new ArticleDao().getArticlesByKeyword(
					wxaccount, "主页");
			if (articles != null && articles.size() > 0) {
				News ns = new News();
				Article article = articles.get(0);
				ns.setTitle("感谢您的关注.点击进入【微主页】");
				ns.setDescription("回复【主页】进入微网站\n回复【反馈+您的话】说说您的idea");
				ns.setPicUrl(article.getPicUrl());
				ns.setUrl(url + article.getLocUrl() + "?wxaccount=" + wxaccount
						+ "&userwx=" + user + "&aId=" + article.getArticleId());

				articles = null;
				article = null;
				replyXml = msm.replyNews(user, developer, ns);
				ns = null;
				return replyXml;
			}
		} else if (event.equals("unsubscribe")) {// 取消关注
			AccountDao aDao = new AccountDao();
			aDao.updateFiled(developer, "fans", -1);
			aDao = null;
		} else if (event.equals("CLICK")) {// 自定义菜单
			List<Article> articles = new ArticleDao().getArticlesByKeyword(
					wxaccount, eventKey);
			List<News> nsList = new ArrayList<News>();

			for (int i = 0, len = articles.size(); i < len; i++) {
				News ns = new News();
				Article article = articles.get(i);
				String locUrl = article.getLocUrl();
				// if (locUrl.matches(".*apiwx.*")) {
				// ns.setUrl(locUrl.replace("fromUsername", user));
				// } else
				if (locUrl.indexOf("http") >= 0) {
					ns.setUrl(url + "articles?ac=getArticleDt&wxaccount="
							+ wxaccount + "&userwx=" + user + "&aId="
							+ article.getArticleId());
				} else if (locUrl.indexOf("?") >= 0) {
					ns.setUrl(url + locUrl + "&wxaccount=" + wxaccount
							+ "&userwx=" + user + "&aId="
							+ article.getArticleId());
				} else {
					ns.setUrl(url + locUrl + "?wxaccount=" + wxaccount
							+ "&userwx=" + user + "&aId="
							+ article.getArticleId());
				}

				ns.setTitle(article.getTitle());
				ns.setDescription(article.getDesc());
				ns.setPicUrl(article.getPicUrl());

				nsList.add(ns);
				ns = null;
				article = null;
			}
			replyXml = msm.replyNewsList(user, developer, nsList);
			articles = null;
			nsList = null;
			return replyXml;
		}
		return msm.replyText(user, developer, "亲，机器貌似卡壳了，请稍后再试");
	}

	private String getKey(String wxaccount, String userwx) {
		String key = "出错咯，请重试";
		AdminDao adminDao = new AdminDao();
		Admin admin = adminDao.getAdminByUserwx(userwx);
		if (admin != null) {
			int length = (int) Math.random() * 3 + 8;// 长度可以为8、9、10位
			key = CommonUtil.getRandomStr(length);// 生成密钥
			admin.setKey(key);
			boolean isSuccess;
			if (admin.getWxaccount() == null) {// add
				admin.setWxaccount(wxaccount);
				admin.setUserwx(userwx);
				admin.setType("bns");

				length = (int) Math.random() * 3 + 13;// 长度可以为13、14、15位
				String token = CommonUtil.getRandomStr(length);// 生成token
				admin.setToken(token);
				isSuccess = adminDao.addAdmin(admin);
			} else {// update
				isSuccess = adminDao.updateAdmin(admin);
			}
			if (isSuccess) {// 回复密钥
				key = "你的密钥为:" + key + "\n登录网址为:\n" + Config.SITEURL
						+ "/mng\n请不要泄露，如果忘记，重新回复getkey即可";
			} else {
				key = "出错咯，请重试";
			}
		}
		admin = null;
		adminDao = null;
		return key;
	}

	// 权限验证
	public String checkPermission(String user, String developer) {
		AccountDao aDao = new AccountDao();
		String isValid = aDao.isAccessOfClient(developer);
		String replyContent = "";
		String replyXml = "";

		if (isValid.equals("illegal")) {
			replyContent = "对不起，你无权使用该接口！如想使用，请联系管理员微信yy_168168.";
			replyXml = msm.replyText(user, developer, replyContent);
		} else if (isValid.equals("error")) {
			replyContent = "亲，你真幸运，刚好机器怠机，请稍后再试.";
			replyXml = msm.replyText(user, developer, replyContent);
		} else {
			replyXml = "allow";
		}
		aDao = null;
		return replyXml;
	}
}
