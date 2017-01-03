package com.wxschool.dpo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.wxschool.dao.LogDao;

@SuppressWarnings("deprecation")
public class BookService {

	private HttpClient client = new DefaultHttpClient();

	public String[][] searchBorrowList(String stuNum, String pwd) {
		String url = "http://lib.hrbnu.edu.cn/gdlisweb/ReaderLogin.aspx";

		try {
			// 获取隐藏参数
			String html_l = doGet(url);
			Document root_l = Jsoup.parse(html_l);
			String __VIEWSTATE = root_l.getElementById("__VIEWSTATE").val();
			String __EVENTVALIDATION = root_l.getElementById(
					"__EVENTVALIDATION").val();

			// 设置参数
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("ScriptManager1",
					"UpdatePanel1|ImageButton1"));
			nvps.add(new BasicNameValuePair("__EVENTTARGET", ""));
			nvps.add(new BasicNameValuePair("__EVENTARGUMENT", ""));
			nvps.add(new BasicNameValuePair("DropDownList1", "借书证号"));
			nvps.add(new BasicNameValuePair("TextBox1", stuNum));
			nvps.add(new BasicNameValuePair("TextBox2", pwd));
			nvps.add(new BasicNameValuePair("ImageButton1.x", "23"));
			nvps.add(new BasicNameValuePair("ImageButton1.y", "12"));
			nvps.add(new BasicNameValuePair("__VIEWSTATE", __VIEWSTATE));
			nvps.add(new BasicNameValuePair("__EVENTVALIDATION",
					__EVENTVALIDATION));

			boolean isSuccess = login(url, nvps);
			if (isSuccess) {
				String html_r = doGet("http://lib.hrbnu.edu.cn/gdlisweb/HisdoryList.aspx");
				Document root = Jsoup.parse(html_r);
				Element dataGrid1 = root.getElementById("DataGrid1").child(0);
				int i_tr = dataGrid1.childNodeSize();
				// System.out.println(dataGrid1.html());
				// System.out.println(i_tr);
				String[][] borrowList = new String[i_tr - 2][3];
				for (int i = 0; i < i_tr - 2; i++) {
					Element tr = dataGrid1.child(i + 1);
					borrowList[i][0] = tr.child(0).text();
					borrowList[i][1] = tr.child(3).text();
					borrowList[i][2] = tr.child(4).text();
				}
				return borrowList;
			}
		} catch (Exception e) {
			// e.printStackTrace();
			LogDao.getLog().addExpLog(e, "searchBorrowList出错；stuNum:" + stuNum);
		}
		return null;
	}

	public String[][] searchExpireList(String stuNum) {
		String url = "http://lib.hrbnu.edu.cn/gdlisweb/ExpiredList.aspx";

		try {
			// 获取隐藏参数
			String html_l = doGet(url);
			Document root_l = Jsoup.parse(html_l);
			String __VIEWSTATE = root_l.getElementById("__VIEWSTATE").val();
			String __EVENTVALIDATION = root_l.getElementById(
					"__EVENTVALIDATION").val();

			// 设置参数
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("ScriptManager1",
					"UpdatePanel1|Button1"));
			nvps.add(new BasicNameValuePair("__EVENTTARGET", "Button1"));
			nvps.add(new BasicNameValuePair("__EVENTARGUMENT", ""));
			nvps.add(new BasicNameValuePair("TextBox3", stuNum));
			nvps.add(new BasicNameValuePair("MyPaper1_PageNo", "1"));
			nvps.add(new BasicNameValuePair("__VIEWSTATE", __VIEWSTATE));
			nvps.add(new BasicNameValuePair("__EVENTVALIDATION",
					__EVENTVALIDATION));

			String html_r = doPost(url, nvps);
			if (html_r != null && html_r.equals("")) {
				return new String[0][];
			}
			Document root = Jsoup.parse(html_r);
			Element dataGrid1 = root.getElementById("DataGrid1").child(0);
			int i_tr = dataGrid1.childNodeSize();
			// System.out.println(dataGrid1.html());
			// System.out.println(i_tr);
			String[][] expireList = new String[i_tr - 2][3];
			for (int i = 0; i < i_tr - 2; i++) {
				Element tr = dataGrid1.child(i + 1);
				expireList[i][0] = tr.child(2).text();
				expireList[i][1] = tr.child(3).text();
				expireList[i][2] = tr.child(4).text();
			}
			return expireList;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "searchExpireList出错；stuNum:" + stuNum);
		}
		return null;
	}

	private String doPost(String url, List<NameValuePair> nvps)
			throws ClientProtocolException, IOException {
		HttpPost httPost = new HttpPost(url);
		String responseBody = null;

		try {
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps, "UTF-8");
			nvps = null;
			httPost.setEntity(httpEntity);
			httpEntity = null;

			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT, 10000);
			client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
					30000);
			HttpResponse res = client.execute(httPost);
			int statusCode = res.getStatusLine().getStatusCode();
			// System.out.println(statusCode);
			if (statusCode == 200) {
				HttpEntity entity = res.getEntity();
				responseBody = EntityUtils.toString(entity, "UTF-8");
			} else if (statusCode == 302) {
				responseBody = "";
			}
		} finally {
			httPost.releaseConnection();
		}
		return responseBody;
	}

	private String doGet(String url) throws ClientProtocolException,
			IOException {
		HttpGet httpGet = new HttpGet(url);
		String responseBody = null;

		try {
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT, 10000);
			client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
					30000);
			HttpResponse response = client.execute(httpGet);
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				responseBody = EntityUtils.toString(entity, "UTF-8");
			}
			entity = null;
			response = null;
		} finally {
			httpGet.releaseConnection();
		}
		return responseBody;
	}

	private boolean login(String url, List<NameValuePair> nvps)
			throws ClientProtocolException, IOException {
		HttpPost httPost = new HttpPost(url);

		try {
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps, "UTF-8");
			nvps = null;
			httPost.setEntity(httpEntity);
			httpEntity = null;

			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT, 10000);
			client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
					30000);
			HttpResponse res = client.execute(httPost);
			int statusCode = res.getStatusLine().getStatusCode();
			// System.out.println(statusCode);
			if (statusCode == 302) {
				return true;
			}
		} finally {
			httPost.releaseConnection();
		}
		return false;
	}

	public static void main(String[] args) {
		new BookService().searchBorrowList("2012040042", "2012040042");// 有
		// new BookService().searchBorrowList("2012040046", "2012040046");//无
		// new BookService().searchBorrowList("2015020646", "2015020646");//
		// 密码有误
		// new BookService().searchExpireList("2015020646");
		// new BookService().searchExpireList("2010040060");
	}
}
