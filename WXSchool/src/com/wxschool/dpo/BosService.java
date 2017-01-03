package com.wxschool.dpo;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;
import javax.imageio.ImageIO;
import com.baidubce.auth.DefaultBceCredentials;
import com.baidubce.services.bos.BosClient;
import com.baidubce.services.bos.BosClientConfiguration;
import com.baidubce.services.bos.model.BosObject;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Config;

public class BosService {

	private static BosClient client;

	public static void main(String[] args) {
		// String fileUrl =
		// "http://wschool.bj.bcebos.com/3ac2ab68-7764-45a3-8361-a82a2ffe4efa.jpg?responseContentDisposition=attachment";
		String fileUrl = "http://wschool.bj.bcebos.com/e89166d2-1bbe-4ea5-b6a5-f05239f50907.jpg?responseContentDisposition=attachment";
		BosService bosService = new BosService();
		// System.out.println(bosService.addFile(fileUrl));
		// System.out.println(bosService.deleteFile(fileUrl));
		System.out.println(bosService.resizeFile(fileUrl));
	}

	public boolean resizeFile(String fileUrl) {

		try {
			int index0 = fileUrl.indexOf(".");
			int index1 = fileUrl.lastIndexOf("/");
			int index2 = fileUrl.lastIndexOf("?");

			String bucketName = fileUrl.substring(7, index0);
			String fileName = fileUrl.substring(index1);
			if (index2 > -1) {
				fileName = fileUrl.substring(index1, index2);
			}

			BosObject object = client.getObject(bucketName, fileName);
			InputStream fileContent = object.getObjectContent();

			Image image = ImageIO.read(fileContent);
			int oldWidth = image.getWidth(null);
			int oldHeight = image.getHeight(null);
			int newWidth = 640;

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

				client.putObject(bucketName, fileName, is);
				// client.shutdown();
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "resizeFile出错；fileUrl:" + fileUrl);
			return false;
		}
		return true;
	}

	public boolean deleteFile(String fileUrl) {

		try {
			int index0 = fileUrl.indexOf(".");
			int index1 = fileUrl.lastIndexOf("/");
			int index2 = fileUrl.lastIndexOf("?");

			String bucketName = fileUrl.substring(7, index0);
			String fileName = fileUrl.substring(index1);
			if (index2 > -1) {
				fileName = fileUrl.substring(index1, index2);
			}

			client.deleteObject(bucketName, fileName);
			// client.shutdown();

			return true;
		} catch (Exception e) {
			String msg = e.getMessage();
			if (msg.indexOf("not exist") > -1) {
				return true;
			} else {
				LogDao.getLog().addExpLog(e, "deleteFile出错；fileUrl:" + fileUrl);
				return false;
			}
		}
	}

	public String addFile(String fileUrl) {

		try {
			InputStream inputStream = getFileInputStream(fileUrl);
			String fileName = UUID.randomUUID() + ".jpg";
			// PutObjectResponse response =
			client.putObject("wschool", fileName, inputStream);

			String url = "http://wschool." + Config.BOSBUKETURL + "/"
					+ fileName;
			inputStream.close();
			// client.shutdown();

			return url;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "addFile出错；fileUrl:" + fileUrl);
			return null;
		}
	}

	public String addFile(byte[] b, String format) {

		try {
			String fileName = UUID.randomUUID() + "." + format;
			// PutObjectResponse response =
			if (format.equals("jpg")) {
				client.putObject("wschool", fileName, b);
			} else {
				client.putObject("wxschool-voice", fileName, b);
			}

			String url = "http://wschool." + Config.BOSBUKETURL + "/"
					+ fileName;
			// client.shutdown();

			return url;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "addFile出错；");
			return null;
		}
	}

	private InputStream getFileInputStream(String fileUrl) throws IOException {
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

		return fileContent;
	}

	public BosService() {
		if (client == null) {
			String ACCESS_KEY_ID = Config.BUCKETUSERNAME;
			String SECRET_ACCESS_KEY = Config.BUCKETPASSWORD;

			// 初始化一个BosClient
			BosClientConfiguration config = new BosClientConfiguration();
			config.setCredentials(new DefaultBceCredentials(ACCESS_KEY_ID,
					SECRET_ACCESS_KEY));
			client = new BosClient(config);
		}
	}

}
