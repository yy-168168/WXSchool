package com.wxschool.dao;

import java.util.*;
import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.*;

public class BoardDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public boolean addBoard(Board board) {
		String sql = "INSERT INTO `tb_board`(`content`, `way`, `contact`, `cate`, `wxaccount`, `userwx`) VALUES (?, ?, ?, ?, ?, ?) ";
		Object[] o = { board.getContent(), board.getWay(), board.getContact(),
				board.getCate(), board.getWxaccount(), board.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addBoard出错；content:" + board.getContent() + ",way:"
							+ board.getWay() + ",contact:" + board.getContact()
							+ ",cate:" + board.getCate() + ",wxaccount:"
							+ board.getWxaccount() + ",userwx:"
							+ board.getUserwx());
			return false;
		}
	}

	public List<Board> getBoards(String wxaccount, String cate, Page page) {
		String sql = "SELECT `content`, `way`, `contact`, `pubTime`, `cate`, `boardId` FROM `tb_board` WHERE `wxaccount` = ? and `cate` like ? and `status` = 1 order by `pubTime` desc limit ?, ? ";
		Object[] o = { wxaccount, cate + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Board> boards = new ArrayList<Board>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Board board = new Board();
				board.setContent(os[i][0].toString());
				board.setWay(os[i][1].toString());
				board.setContact(os[i][2].toString());
				board.setPubTime(os[i][3].toString().substring(0, 16));
				board.setCate(Integer.parseInt(os[i][4].toString()));
				board.setBoardId(Integer.parseInt(os[i][5].toString()));

				boards.add(board);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"cate:" + cate + ",wxaccount:" + wxaccount);
		}
		return boards;
	}

	public List<Board> getBoardsByDay(String wxaccount, String cate, int day) {
		String sql = "SELECT `content`, `way`, `contact`, `pubTime`, `cate` FROM `tb_board` WHERE DATE_SUB(CURDATE(), INTERVAL "
				+ day
				+ " DAY) <= date(pubTime) and `wxaccount` = ? and `cate` like ? and `status` = 1 order by `pubTime` desc ";
		Object[] o = { wxaccount, cate + "%" };
		List<Board> boards = new ArrayList<Board>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Board board = new Board();
				board.setContent(os[i][0].toString());
				board.setWay(os[i][1].toString());
				board.setContact(os[i][2].toString());
				board.setPubTime(os[i][3].toString().substring(0, 16));
				board.setCate(Integer.parseInt(os[i][4].toString()));

				boards.add(board);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"cate:" + cate + ",wxaccount:" + wxaccount);
		}
		return boards;
	}

	public int getTotalRecord(String wxaccount, String cate) {
		String sql = "select count(*) from tb_board where wxaccount = ? and cate like ? and status = 1 ";
		Object[] o = { wxaccount, cate + "%" };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_board中得到总记录数出错；wxaccount:" + wxaccount + ",cate:"
							+ cate);
			return 0;
		}
	}

	public boolean changeStatus(String boardId) {
		String sql = "UPDATE `tb_board` SET `status` = -1  WHERE `boardId`= ? ";
		Object[] o = { boardId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "tb_board删除数据出错；boardId:" + boardId);
			return false;
		}
	}
}
