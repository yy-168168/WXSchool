package com.wxschool.dao;

import java.sql.*;

import javax.servlet.jsp.jstl.sql.*;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.wxschool.entity.Config;

public class ConnDB_C3P0 extends ConnDBI {

	private static ComboPooledDataSource dataSource;

	public ConnDB_C3P0() {
		if (dataSource == null) {
			init();
		}
	}

	// 初始化连接池
	private void init() {
		try {
			dataSource = new ComboPooledDataSource();
			dataSource.setUser(Config.DBUSERNAME);
			dataSource.setPassword(Config.DBPASSWORD);
			dataSource.setJdbcUrl(Config.DBCONNECTION);
			dataSource.setDriverClass(Config.DRIVER);
			// 设置初始连接池的大小！
			dataSource.setInitialPoolSize(5);
			// 设置连接池的最小值！
			dataSource.setMinPoolSize(3);
			// 设置连接池的最大值！
			dataSource.setMaxPoolSize(30);
			// 设置连接池中的最大Statements数量！
			dataSource.setMaxStatements(200);
			// 设置连接池的最大空闲时间！
			dataSource.setMaxIdleTime(45);
			// 设置请求超时限制
			dataSource.setCheckoutTimeout(45000);
			// 每隔多少秒检查连接池中的空闲连接
			dataSource.setIdleConnectionTestPeriod(3600);
			// 取得连接时校验其有效性
			dataSource.setTestConnectionOnCheckin(true);
			// 测试connection是否有效
			dataSource.setAutomaticTestTable("tb_test");
		} catch (Exception e) {
			System.out.println("create DBPool error!");
		}
	}

	private Connection getConnection() throws Exception {
		return dataSource.getConnection();
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
