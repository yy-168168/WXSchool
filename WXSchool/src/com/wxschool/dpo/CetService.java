package com.wxschool.dpo;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLEncoder;
import java.net.UnknownHostException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.wxschool.dao.LogDao;

public class CetService {

	public String getCET(String card, String name) {
		try {
			String html = cetChsiRequest(card, name);
			if (html != null) {
				Document doc = Jsoup.parse(html);

				Elements tables = doc.getElementsByTag("table");
				if (tables.size() > 1) {
					System.out.println(tables.get(1).outerHtml());
					return tables.get(1).outerHtml();
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "card:" + card + ",name:" + name);
		}
		return null;
	}

	public String[] cet99Request(String card, String name) throws IOException {
		name = URLEncoder.encode(name, "gbk");
		String key = "id=" + card + "&name=" + name;

		String url = "http://cet.99sushe.com/find";
		HttpURLConnection conn = (HttpURLConnection) new URL(url)
				.openConnection();
		conn.setDoOutput(true);
		conn.setConnectTimeout(30000);
		conn.setReadTimeout(30000);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		conn.setRequestProperty("Referer", "http://cet.99sushe.com/");
		OutputStream out = conn.getOutputStream();
		out.write(key.getBytes());
		out.close();

		String str = "";
		if (200 == conn.getResponseCode()) {
			InputStream in = conn.getInputStream();
			byte[] b = new byte[512];
			int len = 0;
			while ((len = in.read(b)) != -1) {
				str = new String(b, 0, len, "GBK");
			}
		}
		// System.out.println(str);
		if (str.startsWith("6")) {
			String[] cet = str.split(",");
			return cet;
		} else {
			return null;
		}
	}

	private String cetChsiRequest(String card, String name) throws IOException {
		// name = URLEncoder.encode(name, "gbk");
		String url = "http://www.chsi.com.cn/cet/query?zkzh=" + card + "&xm="
				+ name;
		HttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeader("Accept",
				"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
		httpGet.setHeader("Accept-Language",
				"zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
		httpGet.setHeader("Accept-Encoding", "gzip, deflate");
		httpGet.setHeader("Content-Type", "text/html;charset=utf-8");
		httpGet.setHeader("Content-Encoding", "gzip");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "www.chsi.com.cn");
		httpGet.setHeader("Referer", "http://www.chsi.com.cn/cet/");

		try {
			HttpResponse response = httpClient.execute(httpGet);
			// System.out.println(response.getStatusLine().getStatusCode());
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				String responseBody = EntityUtils.toString(entity, "UTF-8");
				return responseBody;
			}
			entity = null;
			response = null;
		} catch (SocketTimeoutException e) {
		} catch (ConnectionPoolTimeoutException e) {
		} catch (ConnectTimeoutException e) {
		} catch (UnknownHostException e) {
		} finally {
			httpGet.releaseConnection();
			httpClient = null;
		}
		return null;
	}

	public static void main(String[] args) {
		new CetService().getCET("230022161223920", "简雯雯");
	}
}
