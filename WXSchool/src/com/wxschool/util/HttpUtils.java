package com.wxschool.util;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.*;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.httpclient.util.*;
import org.apache.commons.lang.StringUtils;

public class HttpUtils {

	/**
	 * 执行一个HTTP GET请求，返回请求响应
	 * 
	 * @param url
	 *            请求的URL地址
	 * @param queryString
	 *            请求的查询参数,可以为null
	 * @param charset
	 *            字符集
	 * @return 返回请求响应的HTML
	 */
	public static String doGet(String url, String queryString, String charset)
			throws HttpException, IOException {
		StringBuffer response = new StringBuffer();
		HttpClient client = new HttpClient();
		HttpMethod method = new GetMethod(url);

		try {
			if (StringUtils.isNotBlank(queryString))
				method.setQueryString(URIUtil.encodeQuery(queryString));
			
			client.executeMethod(method);
			if (method.getStatusCode() == HttpStatus.SC_OK) {
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(method.getResponseBodyAsStream(),
								charset));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line + "\n");
				}
				reader.close();
			}
		} finally {
			method.releaseConnection();
		}
		return response.toString();
	}

	/**
	 * 执行一个HTTP POST请求，返回请求响应
	 * 
	 * @param url
	 *            请求的URL地址
	 * @param params
	 *            请求的查询参数,可以为null
	 * @param charset
	 *            字符集
	 * @return 返回请求响应的HTML
	 */
	public static String doPost(String url, Map<String, String> params,
			String charset) throws UnsupportedEncodingException, IOException {
		StringBuffer response = new StringBuffer();
		HttpClient client = new HttpClient();
		HttpMethod method = new PostMethod(url);
		// 设置Http Post数据
		if (params != null) {
			HttpMethodParams p = new HttpMethodParams();
			for (Map.Entry<String, String> entry : params.entrySet()) {
				p.setParameter(entry.getKey(), entry.getValue());
			}
			method.setParams(p);
		}
		try {
			client.executeMethod(method);
			if (method.getStatusCode() == HttpStatus.SC_OK) {
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(method.getResponseBodyAsStream(),
								charset));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line + "\n");
				}
				reader.close();
			}
		} finally {
			method.releaseConnection();
		}
		System.out.println(response.toString());
		System.out.println("请求完毕");
		return response.toString();
	}

	/**
	 * 执行HTTP请求，以字符流的形式
	 * 
	 * @param requestUrl
	 * @param requestMethod
	 * @param outputStr
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	public String httpStreamRequest(String requestUrl, String requestMethod,
			String outputStr) throws UnsupportedEncodingException, IOException {

		URL url = new URL(requestUrl);
		HttpURLConnection httpUrlConn = (HttpURLConnection) url
				.openConnection();

		httpUrlConn.setDoOutput(true);
		httpUrlConn.setDoInput(true);
		httpUrlConn.setUseCaches(false);
		// 设置请求方式（GET/POST）
		httpUrlConn.setRequestMethod(requestMethod);

		if ("GET".equalsIgnoreCase(requestMethod))
			httpUrlConn.connect();

		// 当有数据需要提交时
		if (null != outputStr) {
			OutputStream outputStream = httpUrlConn.getOutputStream();
			// 注意编码格式，防止中文乱码
			outputStream.write(outputStr.getBytes("UTF-8"));
			outputStream.close();
		}

		// 将返回的输入流转换成字符串
		InputStream inputStream = httpUrlConn.getInputStream();
		InputStreamReader inputStreamReader = new InputStreamReader(
				inputStream, "utf-8");
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

		StringBuffer buffer = new StringBuffer();
		String str = null;
		while ((str = bufferedReader.readLine()) != null) {
			buffer.append(str);
		}
		bufferedReader.close();
		inputStreamReader.close();
		// 释放资源
		inputStream.close();
		inputStream = null;
		httpUrlConn.disconnect();

		return buffer.toString();
	}
}
