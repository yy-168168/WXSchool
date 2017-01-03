package com.wxschool.dao;

import java.sql.*;

import javax.servlet.jsp.jstl.sql.*;

import com.wxschool.entity.Config;

public class ConnDB_JDBC1 extends ConnDBI {

	static {
		try {
			Class.forName(Config.DRIVER);
		} catch (Exception e) {
			System.out.println("Class.forName error!");
		}
	}

	private Connection getConnection() throws Exception {
		return DriverManager.getConnection(Config.DBCONNECTION,
				Config.DBUSERNAME, Config.DBPASSWORD);
	}

	public Result query(String sql, Object[] o) throws Exception {
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		Result result = null;

		try {
			conn = getConnection();

			pst = conn.prepareStatement(sql);

			if (o == null || o.length == 0) {

			} else {
				for (int i = 0; i < o.length; i++) {
					pst.setObject(i + 1, o[i]);
				}
			}

			rs = pst.executeQuery();
			result = ResultSupport.toResult(rs);

		} finally {
			close(conn, pst, rs);
		}
		return result;
	}

	public int update(String sql, Object[] o) throws Exception {
		int result = 0;

		if (check(o)) {
			Connection conn = null;
			PreparedStatement pst = null;

			try {
				conn = getConnection();

				pst = conn.prepareStatement(sql);

				if (o == null || o.length == 0) {

				} else {
					for (int i = 0; i < o.length; i++) {
						pst.setObject(i + 1, o[i]);
					}
				}
				result = pst.executeUpdate();
			} finally {
				close(conn, pst, null);
			}
		}
		return result;
	}
}
