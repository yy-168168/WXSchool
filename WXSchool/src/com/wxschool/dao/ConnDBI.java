package com.wxschool.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.jsp.jstl.sql.Result;

public abstract class ConnDBI {

	public abstract Result query(String sql, Object[] o) throws Exception;

	public abstract int update(String sql, Object[] o) throws Exception;

	public boolean check(Object[] o) {
		if (o != null) {
			for (int i = 0; i < o.length; i++) {
				if (o[i] != null) {
					// js注入
					if (o[i].toString().indexOf("script") > -1) {
						return false;
					}

					// 特殊字符转义
					o[i] = o[i].toString().replace("'", "\\'");
				}
			}
		}
		return true;
	}

	public void close(Connection conn, PreparedStatement pst, ResultSet rs)
			throws Exception {
		if (rs != null) {
			rs.close();
			rs = null;
		}
		if (pst != null) {
			pst.close();
			rs = null;
		}
		if (conn != null) {
			conn.close();
			conn = null;
		}
	}
}
