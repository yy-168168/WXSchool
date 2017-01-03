package com.wxschool.dpo;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.imageio.ImageIO;

import com.baidu.inf.iis.bcs.BaiduBCS;
import com.baidu.inf.iis.bcs.auth.BCSCredentials;
import com.baidu.inf.iis.bcs.model.ObjectMetadata;
import com.baidu.inf.iis.bcs.model.X_BS_ACL;
import com.baidu.inf.iis.bcs.request.PutObjectRequest;
import com.baidu.inf.iis.bcs.response.BaiduBCSResponse;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Config;
import com.wxschool.entity.Vote;
import com.wxschool.util.CommonUtil;

public class BCSService {

	private static String bucketName = "yy-pic";

	public Vote addFile1(String fileUrl) {
		BCSCredentials credentials = new BCSCredentials(Config.BUCKETUSERNAME,
				Config.BUCKETPASSWORD);
		BaiduBCS baiduBCS = new BaiduBCS(credentials, Config.BCSBUKETURL);
		baiduBCS.setDefaultEncoding("UTF-8");

		try {
			// new一个URL对象
			URL url = new URL(fileUrl);
			// 打开链接
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 设置请求方式为"GET"
			conn.setRequestMethod("GET");
			// 超时响应时间为5秒
			conn.setConnectTimeout(10 * 1000);
			// 通过输入流获取图片数据
			InputStream fileContent = conn.getInputStream();

			ObjectMetadata objectMetadata = new ObjectMetadata();
			objectMetadata.setContentType("text/html");
			objectMetadata.setContentLength(conn.getContentLength());
			// 文件输出名称
			String fileName = "/" + CommonUtil.getRandomStr(16) + ".jpg";
			PutObjectRequest request = new PutObjectRequest(bucketName,
					fileName, fileContent, objectMetadata);
			// 权限设置
			request.setAcl(X_BS_ACL.PublicReadWrite);
			BaiduBCSResponse<ObjectMetadata> response = baiduBCS
					.putObject(request);
			ObjectMetadata result = response.getResult();
			long size = Long.parseLong(result.getRawMetadata()
					.get("x-bs-file-size").toString());

			Vote vote = new Vote();
			vote.setContent("http://" + Config.BCSBUKETURL + "/" + bucketName
					+ fileName);
			vote.setSize(size);

			conn.disconnect();
			fileContent.close();
			return vote;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "addFile出错；fileUrl:" + fileUrl);
			return null;
		}
	}

	public boolean deleteFile1(String fileUrl) {
		BCSCredentials credentials = new BCSCredentials(Config.BUCKETUSERNAME,
				Config.BUCKETPASSWORD);
		BaiduBCS baiduBCS = new BaiduBCS(credentials, Config.BCSBUKETURL);
		baiduBCS.setDefaultEncoding("UTF-8");

		try {
			int index = fileUrl.lastIndexOf("/");
			String fileName = fileUrl.substring(index);
			baiduBCS.deleteObject(bucketName, fileName);
			return true;
		} catch (Exception e) {
			if (e.getMessage().matches(".*object not exists.*")) {
				return true;
			} else {
				LogDao.getLog().addExpLog(e, "deleteFile出错；fileUrl:" + fileUrl);
				return false;
			}
		}
	}

	public boolean resizeFile(String fileUrl) {
		BCSCredentials credentials = new BCSCredentials(Config.BUCKETUSERNAME,
				Config.BUCKETPASSWORD);
		BaiduBCS baiduBCS = new BaiduBCS(credentials, Config.BCSBUKETURL);
		baiduBCS.setDefaultEncoding("UTF-8");

		try {
			int index = fileUrl.lastIndexOf("/");
			String fileName = fileUrl.substring(index);
			// DownloadObject result = baiduBCS.getObject(bucketName,
			// fileName).getResult();
			// InputStream fileContent = result.getContent();

			// new一个URL对象
			URL url = new URL(fileUrl);
			// 打开链接
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 设置请求方式为"GET"
			conn.setRequestMethod("GET");
			// 超时响应时间为5秒
			conn.setConnectTimeout(10 * 1000);
			// 通过输入流获取图片数据
			InputStream fileContent = conn.getInputStream();

			Image image = ImageIO.read(fileContent);
			int oldWidth = image.getWidth(null);
			int oldHeight = image.getHeight(null);
			int newWidth = 640;

			conn.disconnect();
			fileContent.close();

			if (oldWidth > newWidth) {
				int newHeight = (int) (oldHeight * newWidth / oldWidth);

				BufferedImage bufferedImage = new BufferedImage(newWidth,
						newHeight, BufferedImage.TYPE_INT_RGB);
				bufferedImage.getGraphics().drawImage(
						image.getScaledInstance(newWidth, newHeight,
								Image.SCALE_SMOOTH), 0, 0, null);

				ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
				ImageIO.write(bufferedImage, "jpg", byteArrayOutputStream);
				byte[] ba = byteArrayOutputStream.toByteArray();
				InputStream is = new ByteArrayInputStream(ba);

				int newLength = ba.length;
				// System.out.println(newLength);
				// Image image2 = ImageIO.read(is);

				ObjectMetadata objectMetadata = new ObjectMetadata();
				objectMetadata.setContentType("text/html");
				objectMetadata.setContentLength(newLength);
				PutObjectRequest request = new PutObjectRequest(bucketName,
						fileName, is, objectMetadata);
				// 权限设置
				request.setAcl(X_BS_ACL.PublicReadWrite);
				// BaiduBCSResponse<ObjectMetadata> response =
				baiduBCS.putObject(request);
				// ObjectMetadata result = response.getResult();
				// long size =
				// Long.parseLong(result.getRawMetadata().get("x-bs-file-size").toString());
			}
			return true;
		} catch (Exception e) {
			if (e.getMessage().indexOf("403") < 0) {
				LogDao.getLog().addExpLog(e, "resizeFile出错；fileUrl:" + fileUrl);
			}
			return false;
		}
	}

	public static void main(String[] args) {
		// System.out.println(new
		// BCSDao().resizeFile("http://bcs.duapp.com/yy-pic/q3hoazebv3iu50rk.jpg"));
		// new BCSDao().addFile("http://bcs.duapp.com/yy-pic/test111.jpg");
	}
}
