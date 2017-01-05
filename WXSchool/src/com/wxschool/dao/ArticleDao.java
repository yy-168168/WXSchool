package com.wxschool.dao;

import java.util.*;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Article;
import com.wxschool.entity.Page;

public class ArticleDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Article> getKeywordsOfArticle(String wxaccount) {
		String sql = "SELECT `articleId`, `keyword` FROM `tb_article` WHERE (`wxaccount` = ? or `wxaccount` = 'admin') and `status` = 1 ";
		Object[] o = { wxaccount };
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Article a = new Article();
				a.setArticleId(Integer.parseInt(os[i][0].toString()));
				a.setKeyword(os[i][1].toString());

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getKeywordsOfArticle出错；wxaccount:" + wxaccount);
		}
		return articles;
	}

	public List<Article> getArticlesByIds(String ids) {
		String sql = "SELECT  `articleId`, `title`, `picUrl`, `locUrl`, `desc` FROM `tb_article` WHERE `articleId` in ( "
				+ ids + " ) order by cate asc, sort desc, articleId desc ";
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, null);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Article article = new Article();
				article.setArticleId(Integer.parseInt(os[i][0].toString()));
				article.setTitle(os[i][1].toString());
				article.setPicUrl(os[i][2].toString());
				article.setLocUrl(os[i][3].toString());
				article.setDesc(os[i][4].toString());

				articles.add(article);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getArticlesByIds出错；ids:" + ids);
		}
		return articles;
	}

	public List<Article> getArticlesByCate(String wxaccount, String cate,
			String orderBy, Page page) {
		String sql = "";
		if (orderBy == null || orderBy.equals("default")) {
			sql = "SELECT `desc`, `picUrl`, `locUrl`, `visitPerson`, `articleId`, `keyword`, `title` FROM `tb_article` "
					+ "WHERE wxaccount = ? and `cate` = ? and `status` = 1 order by rand() limit ? , ? ";
		} else {
			sql = "SELECT `desc`, `picUrl`, `locUrl`, `visitPerson`, `articleId`, `keyword`, `title` FROM `tb_article` "
					+ "WHERE wxaccount = ? and `cate` = ? and `status` = 1 order by "
					+ orderBy + " desc , `sort` asc limit ? , ? ";
		}
		Object[] o = { wxaccount, cate,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Article a = new Article();
				a.setDesc(os[i][0].toString());
				a.setPicUrl(os[i][1].toString());
				a.setLocUrl(os[i][2].toString());
				a.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				a.setArticleId(Integer.parseInt(os[i][4].toString()));
				a.setKeyword(os[i][5].toString());
				a.setTitle(os[i][6].toString());

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getArticlesByCate出错；wxaccount:" + wxaccount + ",cate:"
							+ cate + ",orderBy:" + orderBy);
		}
		return articles;
	}

	public List<Article> getArticlesofArt(String wxaccount, Page page) {
		String sql = "SELECT `desc`, `visitPerson`, `articleId`, `keyword`, `title`, `cate`, `status` FROM `tb_article` "
				+ "WHERE wxaccount = ? and `cate` <> 'menu' and `status` > -1 order by articleId desc limit ? , ? ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Article a;

			for (int i = 0, len = os.length; i < len; i++) {
				a = new Article();
				a.setDesc(os[i][0].toString());
				a.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				a.setArticleId(Integer.parseInt(os[i][2].toString()));
				a.setKeyword(os[i][3].toString());
				a.setTitle(os[i][4].toString());
				a.setCate(os[i][5].toString());
				a.setStatus(Integer.parseInt(os[i][6].toString()));

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getArticlesofArt出错wxaccount:" + wxaccount);
		}
		return articles;
	}

	public List<Article> getArticlesofArt(String wxaccount, String orderBy,
			Page page) {
		String sql = "";
		if (orderBy == null || orderBy.equals("default")) {
			sql = "SELECT `desc`, `picUrl`, `locUrl`, `visitPerson`, `articleId`, `keyword`, `title` FROM `tb_article` "
					+ "WHERE wxaccount = ? and `cate` <> 'menu' and `status` = 1 order by rand() desc limit ? , ? ";
		} else {
			sql = "SELECT `desc`, `picUrl`, `locUrl`, `visitPerson`, `articleId`, `keyword`, `title` FROM `tb_article` "
					+ "WHERE wxaccount = ? and `cate` <> 'menu' and `status` = 1 order by "
					+ orderBy + " desc limit ? , ? ";
		}
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Article a = new Article();
				a.setDesc(os[i][0].toString());
				a.setPicUrl(os[i][1].toString());
				a.setLocUrl(os[i][2].toString());
				a.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				a.setArticleId(Integer.parseInt(os[i][4].toString()));
				a.setKeyword(os[i][5].toString());
				a.setTitle(os[i][6].toString());

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getArticlesofArt出错wxaccount:" + wxaccount + ",orderBy:"
							+ orderBy);
		}
		return articles;
	}

	public List<Article> getArticlesofMenu(String wxaccount, Page page) {
		String sql = "SELECT `desc`, `visitPerson`, `articleId`, `keyword`, `title`, `cate`, `sort`, `status` FROM `tb_article` "
				+ "WHERE wxaccount = ? and `keyword` <> 'subscribe' and `cate` = 'menu' and `status` > -1 order by articleId desc limit ? , ? ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Article a;

			for (int i = 0, len = os.length; i < len; i++) {
				a = new Article();
				a.setDesc(os[i][0].toString());
				a.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				a.setArticleId(Integer.parseInt(os[i][2].toString()));
				a.setKeyword(os[i][3].toString());
				a.setTitle(os[i][4].toString());
				a.setCate(os[i][5].toString());
				a.setRank(Integer.parseInt(os[i][6].toString()));
				a.setStatus(Integer.parseInt(os[i][7].toString()));

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getArticlesofMenu出错；wxaccount:" + wxaccount);
		}
		return articles;
	}

	public List<Article> searchByKeywordofArt(String wxaccount, String keyword,
			Page page) {
		String sql = "SELECT `desc`, `visitPerson`, `articleId`, `keyword`, `title`, `cate`, `status` FROM `tb_article` "
				+ "WHERE wxaccount = ? and (`keyword` like ? or `title` like ?) and `cate` <> 'menu' and `status` > -1 order by articleId desc limit ? , ? ";
		Object[] o = { wxaccount, "%" + keyword + "%", "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Article a;

			for (int i = 0, len = os.length; i < len; i++) {
				a = new Article();
				a.setDesc(os[i][0].toString());
				a.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				a.setArticleId(Integer.parseInt(os[i][2].toString()));
				a.setKeyword(os[i][3].toString());
				a.setTitle(os[i][4].toString());
				a.setCate(os[i][5].toString());
				a.setStatus(Integer.parseInt(os[i][6].toString()));

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeywordofArt出错；wxaccount:" + wxaccount
							+ ",keyword:" + keyword);
		}
		return articles;
	}

	public List<Article> searchByKeywordofMenu(String wxaccount,
			String keyword, Page page) {
		String sql = "SELECT `desc`, `visitPerson`, `articleId`, `keyword`, `title`, `cate`, `sort`, `status` FROM `tb_article` "
				+ "WHERE wxaccount = ? and keyword like ? and `cate` = 'menu' and `status` > -1 order by articleId desc limit ? , ? ";
		Object[] o = { wxaccount, "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Article> articles = new ArrayList<Article>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Article a;

			for (int i = 0, len = os.length; i < len; i++) {
				a = new Article();
				a.setDesc(os[i][0].toString());
				a.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				a.setArticleId(Integer.parseInt(os[i][2].toString()));
				a.setKeyword(os[i][3].toString());
				a.setTitle(os[i][4].toString());
				a.setCate(os[i][5].toString());
				a.setRank(Integer.parseInt(os[i][6].toString()));
				a.setStatus(Integer.parseInt(os[i][7].toString()));

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeywordofMenu出错；wxaccount:" + wxaccount
							+ ",keyword:" + keyword);
		}
		return articles;
	}

	public List<Article> getArticlesByKeyword(String wxaccount, String keyword) {
		String sql = "SELECT `desc`, `picUrl`, `locUrl`, `title`, `articleId`  FROM `tb_article` WHERE (`wxaccount` = ? or `wxaccount` = 'admin') and"
				+ " `keyword` like ? and `status` = 1 order by cate asc, sort desc , `articleId` desc  ";
		Object[] o = { wxaccount, "%" + keyword + "%" };
		List<Article> articles = new ArrayList<Article>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Article a = new Article();
				a.setDesc(os[i][0].toString());
				a.setPicUrl(os[i][1].toString());
				a.setLocUrl(os[i][2].toString());
				a.setTitle(os[i][3].toString());
				a.setArticleId(Integer.parseInt(os[i][4].toString()));

				articles.add(a);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getArticlesByKeyword出错；wxaccount:" + wxaccount
							+ ",keyword:" + keyword);
		}
		return articles;
	}

	public void updateVisitPerson(String articleId) {
		String sql = "UPDATE `tb_article` SET `visitPerson` = `visitPerson` + 1 WHERE `articleId` = ? ";
		Object[] o = { articleId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"updateArticleVisitPerson出错；articleId:" + articleId);
		}
	}

	public String getFiled(String articleId, String filed) {
		String sql = "SELECT " + filed
				+ " FROM `tb_article` WHERE `articleId` = ? ";
		Object[] o = { articleId };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowsByIndex()[0][0].toString();
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getFiled出错；articleId:" + articleId + ",filed:" + filed);
			return "0";
		}
	}

	public Article getArticleById(String articleId) {
		String sql = "SELECT `keyword`, `title`, `picUrl`, `locUrl`, `cate`, `desc`, `sort`, `status` FROM `tb_article` WHERE `articleId` = ? ";
		Object[] o = { articleId };
		Article article = new Article();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				article.setKeyword(os[i][0].toString());
				article.setTitle(os[i][1].toString());
				article.setPicUrl(os[i][2].toString());
				article.setLocUrl(os[i][3].toString());
				article.setCate(os[i][4].toString());
				article.setDesc(os[i][5].toString());
				article.setRank(Integer.parseInt(os[i][6].toString()));
				article.setStatus(Integer.parseInt(os[i][7].toString()));
				article.setArticleId(Integer.parseInt(articleId));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getArticleById出错；articleId:" + articleId);
		}
		return article;
	}

	public String[] getArticleCate(String wxaccount) {
		String sql = "SELECT cate FROM `tb_article` WHERE `wxaccount` = ? and cate <> 'menu' group by cate ";
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			int len = os.length;
			String[] cates = new String[len];

			for (int i = 0; i < len; i++) {
				cates[i] = os[i][0].toString();
			}
			return cates;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getArticleCate出错");
			return null;
		}
	}

	public Article getSubscribe(String wxaccount) {
		String sql = "SELECT `title`, `picUrl`, `locUrl`, `desc`, `status` FROM `tb_article` "
				+ " WHERE `wxaccount` = ? and `keyword` = 'subscribe' ";
		Object[] o = { wxaccount };
		Article article = new Article();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				article.setTitle(os[i][0].toString());
				article.setPicUrl(os[i][1].toString());
				article.setLocUrl(os[i][2].toString());
				article.setDesc(os[i][3].toString());
				article.setStatus(Integer.parseInt(os[i][4].toString()));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getSubscribe出错；wxaccount:" + wxaccount);
		}
		return article;
	}

	public int getTotalRecord(String wxaccount, String cate) {
		String sql = "select count(*) from `tb_article` where wxaccount = ? and cate = ? and `status` = 1 ";
		Object[] o = { wxaccount, cate };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_article中得到总记录数出错;wxaccount:" + wxaccount + ",cate:"
							+ cate);
			return 0;
		}
	}

	public int getTotalRecordofMenu(String wxaccount) {
		String sql = "select count(*) from `tb_article` where wxaccount = ? and cate = 'menu' and `status` > -1 ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_article中得到总记录数出错;wxaccount:" + wxaccount
							+ ",cate:menu");
			return 0;
		}
	}

	public int getTotalRecordofArt(String wxaccount) {
		String sql = "select count(*) from `tb_article` where wxaccount = ? and cate <> 'menu' and `status` > -1 ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog()
					.addExpLog(
							e,
							"从tb_article中得到总记录数出错;wxaccount:" + wxaccount
									+ ",cate:art");
			return 0;
		}
	}

	public boolean updateArt(Article art) {
		String sql = "UPDATE `tb_article` SET `keyword`= ? ,`title`= ? , `picUrl`= ? ,`locUrl`= ? ,`cate`= ? , `desc`= ? , `sort`= ?  WHERE `articleId`= ? ";
		Object[] o = { art.getKeyword(), art.getTitle(), art.getPicUrl(),
				art.getLocUrl(), art.getCate(), art.getDesc(), art.getRank(),
				art.getArticleId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateArt出错；artId:" + art.getArticleId() + ",keyword:"
							+ art.getKeyword() + ",title:" + art.getTitle()
							+ ",picUrl:" + art.getPicUrl() + ",locUrl:"
							+ art.getLocUrl() + ",cate:" + art.getCate()
							+ ",desc:" + art.getDesc() + ",rank:"
							+ art.getRank());
			return false;
		}
	}

	public boolean updateSubscribe(Article art) {
		String sql = "UPDATE `tb_article` SET `title`= ? , `picUrl`= ? ,`locUrl`= ? , `desc`= ?  "
				+ " WHERE `wxaccount`= ? and `keyword`= 'subscribe' ";
		Object[] o = { art.getTitle(), art.getPicUrl(), art.getLocUrl(),
				art.getDesc(), art.getWxaccount() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateSubscribe出错；wxaccount:" + art.getWxaccount()
							+ ",title:" + art.getTitle() + ",picUrl:"
							+ art.getPicUrl() + ",locUrl:" + art.getLocUrl()
							+ ",desc:" + art.getDesc());
			return false;
		}
	}

	public boolean addArt(Article art) {
		String sql = "INSERT INTO `tb_article`(`keyword`, `title`, `picUrl`, `locUrl`, `cate`, `desc`, `sort`, `wxaccount`) "
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?) ";
		Object[] o = { art.getKeyword(), art.getTitle(), art.getPicUrl(),
				art.getLocUrl(), art.getCate(), art.getDesc(), art.getRank(),
				art.getWxaccount() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addArt出错；wxaccout:" + art.getWxaccount() + ",keyword:"
							+ art.getKeyword() + ",title:" + art.getTitle()
							+ ",picUrl:" + art.getPicUrl() + ",locUrl:"
							+ art.getLocUrl() + ",cate:" + art.getCate()
							+ ",desc:" + art.getDesc() + ",rank:"
							+ art.getRank());
			return false;
		}
	}

	public boolean changeStatus(String artId, String status) {
		String sql = "UPDATE `tb_article` SET `status` = ?  WHERE `articleId`= ? ";
		Object[] o = { status, artId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"deleteArt出错；artId:" + artId + ",status:" + status);
			return false;
		}
	}

	public boolean changeStatusOfSubscribe(String wxaccount, int status) {
		String sql = "UPDATE `tb_article` SET `status` = ?  WHERE `wxaccount`= ? and `keyword` = 'subscribe' ";
		Object[] o = { status, wxaccount };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"changeStatusOfSubscribe出错；wxaccount:" + wxaccount
							+ ",status:" + status);
			return false;
		}
	}
}
