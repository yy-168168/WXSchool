package com.wxschool.web;

import java.util.ArrayList;
import java.util.List;

import com.wxschool.dao.*;
import com.wxschool.dpo.*;
import com.wxschool.entity.*;

public class MsgReceiveManagerOld1 {

	private static String url = "http://hsdwechat.duapp.com/";
	private MsgSendManager msm = MsgSendManager.instance();
	private AccountDao aDao = new AccountDao();

	// private static int counter = 0;

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
		String reply = "";

		if (receiveContent.matches("格子铺测试")) {
			reply = "<a href=\"" + url + "bns?ac=box&wxaccount=" + developer
					+ "&userwx=" + user + "\">测试</a>";
			return msm.replyText(user, developer, reply);
		}

		if (receiveContent.matches("外卖测试2")) {
			reply = "<a href=\"" + url + "fs?ac=getress&wxaccount=" + developer
					+ "&userwx=" + user + "\">测试2</a>";
			return msm.replyText(user, developer, reply);
		}

		// 智能聊天
		if (receiveContent.equals("2")) {
			boolean b = true;// aDao.addState(developer, user, "chat");
			if (b) {
				reply = "您已开启智能聊天模式，它是一个智能机器人，它喜欢骂人，喜欢瞎说，喜欢扯淡，您不要介意。如果您是屌丝，请前来调戏.\n\n回复【取消】退出此模式";
			} else {
				reply = "开启智能聊天模式失败，请重试";
			}
			return msm.replyText(user, developer, reply);
		}

		// 翻译功能
		if (receiveContent.matches(".*翻译.*")) {
			reply = "翻译的格式为：@您要翻译的词。如：@我爱你";
			if (!check(developer, "translate")) {
				reply = "暂不支持此功能";
			}
			return msm.replyText(user, developer, reply);
		}
		if (receiveContent.startsWith("@")) {
			reply = "翻译的格式为：@您要翻译的词。如：@我爱你";
			if (!check(developer, "translate")) {
				reply = "暂不支持此功能";
			} else {
				String word = receiveContent.substring(1);
				if (!word.equals("")) {
					aDao.updateFiled(developer, "translate", 1);
					TranslateService tDao = new TranslateService();
					reply = tDao.translate(word);
				}
			}
			return msm.replyText(user, developer, reply);
		}

		// 天气功能
		if (receiveContent.matches(".*天气.*")) {
			if (!check(developer, "weather")) {
				reply = "暂不支持此功能";
			} else {
				aDao.updateFiled(developer, "weather", 1);
				WeatherService wDao = new WeatherService();
				String city = "";
				if (receiveContent.equals("天气")
						|| receiveContent.matches(".*天气.*查.*")
						|| receiveContent.matches(".*查.*天气.*")) {
					city = "哈尔滨";
				} else {
					city = receiveContent.substring(0,
							receiveContent.length() - 2).trim();
				}
				reply = wDao.getWeather(city);
			}
			return msm.replyText(user, developer, reply);
		}

		if (receiveContent.matches(".*参与.*")
				|| receiveContent.matches(".*舌尖.*")) {
			News ns = new News();
			ns.setTitle("点击进入【舌尖上的师大】");
			ns.setPicUrl("http://t2.qpic.cn/mblogpic/621a4d8d4da7661ae3a2/460");
			ns.setUrl(url + "vote?ac=isVote&wxaccount=" + developer + "&userwx="
					+ user + "&voteId=703");

			return msm.replyNews(user, developer, ns);
		}

		// 快递功能
		if (receiveContent.matches(".*快递.*")) {
			reply = "查快递的格式为：\n快递公司名(两字) 运单号\n如：圆通  3230169980\n\n支持的快递公司有：\n邮政  申通  顺丰  天天\n"
					+ "圆通  韵达  中铁  中通\n中邮  汇通  国通  优速\n全峰\n\n如果没有您要使用的快递，请反馈给我们\n快递分布在主菜单攻略板块";
			if (!check(developer, "express")) {
				reply = "暂不支持此功能";
			}
			return msm.replyText(user, developer, reply);
		}
		String com = null;
		if (receiveContent.length() >= 2) {
			com = ExpressService.getENname(receiveContent.substring(0, 2));
		}
		if (com != null) {
			if (!check(developer, "express")) {
				reply = "暂不支持此功能";
			} else {
				String num = receiveContent.substring(2).trim();
				aDao.updateFiled(developer, "express", 1);
				String ex = new ExpressService().getExpress(developer, com, num);
				if (ex.matches(".*错误.*") || ex.matches(".*不存在.*")) {
					ex += "，格式如：\n圆通  3230169980";
				}
				reply = ex + "\n\n数据来源：爱查快递";
			}
			return msm.replyText(user, developer, reply);
		}

		if (receiveContent.matches(".*笑话.*")
				|| receiveContent.matches(".*常识.*")
				|| receiveContent.matches(".*/:.*")) {
			reply = new FunDao().getFun(receiveContent);
			return msm.replyText(user, developer, reply);
		}

		// 文本自定义回复
		List<Text> texts = new TextDao().getTexts(developer);
		if (texts != null) {
			for (int i = 0; i < texts.size(); i++) {
				Text text = texts.get(i);
				String[] key = text.getKey().split("\\|");
				for (int j = 0; j < key.length; j++) {
					if (receiveContent.matches(".*" + key[j] + ".*")) {
						reply = text.getValue();
						if (Math.random() < 0.6) {// 广告
							// reply += "\n\n亲,请关注caimeidedian\n在微信等你/::)";
						}
						return msm.replyText(user, developer, reply);
					}
				}
			}
		}

		// 图文自定义回复
		List<Article> articles = new ArticleDao()
				.getKeywordsOfArticle(developer);
		if (articles != null) {
			List<News> nsl = new ArrayList<News>();
			News home = new News();
			for (int i = 0; i < articles.size(); i++) {
				Article article = articles.get(i);
				String[] key = article.getKeyword().split("\\|");
				for (int j = 0; j < key.length; j++) {
					if (receiveContent.matches(".*" + key[j] + ".*")) {
						News ns = new News();
						if (article.getLocUrl().matches(".*http.*")) {
							ns.setUrl(url
									+ "articles?ac=getArticleDt&wxaccount="
									+ developer + "&aId="
									+ article.getArticleId());
						} else {
							ns.setUrl(url + article.getLocUrl() + "&wxaccount="
									+ developer + "&userwx=" + user + "&aId="
									+ article.getArticleId());
						}

						ns.setTitle(article.getTitle());
						ns.setDescription(article.getDesc());
						ns.setPicUrl(article.getPicUrl());

						nsl.add(ns);
					} else if (key[j].matches(".*主页.*")) {
						home.setTitle(article.getTitle());
						home.setDescription(article.getDesc());
						home.setPicUrl(article.getPicUrl());
						home.setUrl(url + article.getLocUrl() + "&wxaccount="
								+ developer + "&userwx=" + user + "&aId="
								+ article.getArticleId());
					}
				}
				if (nsl.size() >= 9) {
					break;
				}
			}
			if (nsl == null || nsl.size() == 0) {
				nsl.add(home);
			}
			return msm.replyNewsList(user, developer, nsl);
		}

		return msm.replyText(user, developer, "回复【首页】进入主菜单");
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
		aDao.updateFiled(developer, "location", 1);
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
		if (event.equals("subscribe")) {
			aDao.updateFiled(developer, "fans", 1);
			List<Article> articles = new ArticleDao().getArticlesByKeyword(
					developer, "首页");
			if (articles != null) {
				News home = new News();
				for (int i = 0; i < articles.size(); i++) {
					Article article = articles.get(i);
					home.setTitle("您好,感谢您的关注.点击进入【主菜单】");
					home.setDescription("回复【0】进入主菜单\n回复【反馈+您的话】说说您的idea");
					home.setPicUrl(article.getPicUrl());
					home.setUrl(url + article.getLocUrl() + "&wxaccount="
							+ developer + "&userwx=" + user);
				}
				return msm.replyNews(user, developer, home);
			}
		} else if (event.equals("unsubscribe")) {
			aDao.updateFiled(developer, "fans", -1);
		}
		return msm.replyText(user, developer, "您好,感谢您的关注.回复【首页】进入主菜单");
	}

	/*
	 * private String admin2(String state, String receiveStr, String wxaccount,
	 * String userwx) { String replyStr; AdminDao adminDao = new AdminDao(); int
	 * level = Integer.parseInt(state.substring(5));
	 * 
	 * switch (level) { case 1: // 添加key/value if (receiveStr.equals("12")) {
	 * replyStr = "添加自定义回复的格式为：问题：答案："; return replyStr; } if
	 * (receiveStr.matches("问题：.*答案：.*")) { int in1 = receiveStr.indexOf("问题：");
	 * int in2 = receiveStr.indexOf("答案："); String key =
	 * receiveStr.substring(in1 + 3, in2); String value =
	 * receiveStr.substring(in2 + 3); boolean b =
	 * adminDao.addKeyValue(wxaccount, key, value); replyStr = b ? "添加成功" :
	 * "添加失败"; return replyStr; } // 添加课表 if (receiveStr.equals("13")) { String
	 * u = url + "admin/addCourse1.jsp?wxaccount=" + wxaccount + "&userwx=" +
	 * userwx; replyStr = "点此进入<a href=\"" + u + "\">添加课表</a>"; return replyStr;
	 * } // 表白墙审核 if (receiveStr.equals("14")) { String u = url +
	 * "admin/checklist.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx +
	 * "&type=listbiaobai"; replyStr = "点此进入<a href=\"" + u + "\">表白墙审核</a>";
	 * return replyStr; } // 求助区审核 if (receiveStr.equals("15")) { String u = url
	 * + "admin/checklist.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx +
	 * "&type=listboard"; replyStr = "点此进入<a href=\"" + u + "\">告示板审核</a>";
	 * return replyStr; } // 告示板审核 if (receiveStr.equals("16")) { String u = url
	 * + "admin/checklist.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx +
	 * "&type=listhelp"; replyStr = "点此进入<a href=\"" + u + "\">求助区审核</a>";
	 * return replyStr; } // 发布兼职信息 if (receiveStr.equals("17")) { String u =
	 * url + "admin/pubjob.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx;
	 * replyStr = "点此进入<a href=\"" + u + "\">发布兼职信息</a>"; return replyStr; } //
	 * 删除兼职信息 if (receiveStr.equals("18")) { String u = url +
	 * "admin/checklist.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx +
	 * "&type=admin1listjob"; replyStr = "点此进入<a href=\"" + u + "\">删除兼职信息</a>";
	 * return replyStr; } break; case 6: // 发布兼职信息 if (receiveStr.equals("61"))
	 * { String u = url + "admin/pubjob.jsp?wxaccount=" + wxaccount + "&userwx="
	 * + userwx; replyStr = "点此进入<a href=\"" + u + "\">发布兼职信息</a>"; return
	 * replyStr; } // 删除兼职信息 if (receiveStr.equals("62")) { String u = url +
	 * "admin/checklist.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx +
	 * "&type=admin6listjob"; replyStr = "点此进入<a href=\"" + u + "\">删除兼职信息</a>";
	 * return replyStr; } break; } return null; }
	 * 
	 * private String admin1(String receiveStr, String wxaccount, String userwx)
	 * { String replyStr = ""; StringBuffer sb = new StringBuffer(); AdminDao
	 * adminDao = new AdminDao(); int level = 1;
	 * 
	 * if (level == -1) { replyStr = "卡壳了，请稍后重试"; } else if (level == 0) {
	 * replyStr = "抱歉，你不是管理员！有问题请联系微信yy_168168"; } else { String u = ""; switch
	 * (level) { case 1: // 添加key/value if (receiveStr.equals("12")) { replyStr
	 * = "添加自定义回复的格式为：问题：答案："; return replyStr; } if
	 * (receiveStr.matches("问题：.*答案：.*")) { int in1 = receiveStr.indexOf("问题：");
	 * int in2 = receiveStr.indexOf("答案："); String key =
	 * receiveStr.substring(in1 + 3, in2); String value =
	 * receiveStr.substring(in2 + 3); boolean b =
	 * adminDao.addKeyValue(wxaccount, key, value); replyStr = b ? "添加成功" :
	 * "添加失败"; return replyStr; } // 添加课表 u = url +
	 * "admin/addCourse1.jsp?wxaccount=" + wxaccount + "&userwx=" + userwx;
	 * sb.append("<a href=\"" + u + "\">添加课表</a>\n");
	 * 
	 * // 表白墙审核 u = url + "admin/checklist.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx + "&type=listbiaobai"; sb.append("<a href=\"" + u +
	 * "\">表白墙审核</a>\n");
	 * 
	 * // 求助区审核 u = url + "admin/checklist.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx + "&type=listboard"; sb.append("<a href=\"" + u +
	 * "\">告示板审核</a>\n");
	 * 
	 * // 告示板审核 u = url + "admin/checklist.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx + "&type=listhelp"; sb.append("<a href=\"" + u +
	 * "\">求助区审核</a>\n");
	 * 
	 * // 发布兼职信息 u = url + "admin/pubjob.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx; sb.append("<a href=\"" + u + "\">发布兼职信息</a>\n");
	 * 
	 * // 删除兼职信息 u = url + "admin/checklist.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx + "&type=admin1listjob"; sb.append("<a href=\"" + u +
	 * "\">删除兼职信息</a>\n");
	 * 
	 * break; case 6: // 发布兼职信息 u = url + "admin/pubjob.jsp?wxaccount=" +
	 * wxaccount + "&userwx=" + userwx; sb.append("<a href=\"" + u +
	 * "\">发布兼职信息</a>\n");
	 * 
	 * // 删除兼职信息 u = url + "admin/checklist.jsp?wxaccount=" + wxaccount +
	 * "&userwx=" + userwx + "&type=admin6listjob"; sb.append("<a href=\"" + u +
	 * "\">删除兼职信息</a>"); break; } replyStr = sb.toString(); }
	 * 
	 * return replyStr; }
	 */

	private boolean check(String wxaccount, String type) {
		String s_num = "";
		try {
			int num = Integer.parseInt(s_num);
			if (num < 0) {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
		return true;
	}
}
