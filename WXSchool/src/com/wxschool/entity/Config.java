package com.wxschool.entity;

public class Config {

	// 域名
	public static final String SITEURL = "http://www.jingl520.com";

	// 服务器所在平台
	public static final int PLATFORMACCOUNT = 1;// 1-百度 2-阿里

	// 数据库连接方式
	public static final int DBCONNECTIONTYPE = 1;

	// 连接数据库的参数
	public static String DRIVER = "com.mysql.jdbc.Driver";
	public static String DBUSERNAME = null;
	public static String DBPASSWORD = null;
	public static String DBCONNECTION = null;

	// 连接云存储的参数
	public static final String BUCKETUSERNAME = "dDDmQGwr5NDPNw3heC2N8GqK";
	public static final String BUCKETPASSWORD = "bRchlG2fjVD1eqFbrmwxf03IIXHRx8wD";
	public static final String BCSBUKETURL = "bcs.duapp.com";// 云存储域名
	public static final String BOSBUKETURL = "bj.bcebos.com";// BOS服务域名

	// JS-SDK
	public static String jsapiTicket = "";

	//
	public static int WECHATCUSTOMMSGVALIDTIME = 47;
}
