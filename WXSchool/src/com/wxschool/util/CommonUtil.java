package com.wxschool.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.LogDao;

public class CommonUtil {

	/*
	 * 获取与当前时间相差的秒数
	 */
	public static long getDiffSecondOfNow(String date) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date d = df.parse(date);
			long diff_ms = new Date().getTime() - d.getTime();
			return diff_ms / 1000;
		} catch (ParseException e) {
			return Long.MAX_VALUE;
		}
	}

	/*
	 * 判断请求是否是移动端
	 */
	public static boolean isRequestOfMobile(HttpServletRequest request) {
		String userAgent = request.getHeader("user-agent");

		if (userAgent == null) {
			userAgent = request.getHeader("User-Agent");
			if (userAgent == null) {
				LogDao.getLog().addNorLog(
						"user-agent为空，请求网址为：" + request.getRequestURL() + "?"
								+ request.getQueryString());
				return false;
			}
		}

		userAgent = userAgent.toLowerCase();

		if (userAgent.indexOf("android") > -1
				|| userAgent.indexOf("iphone") > -1
				|| userAgent.indexOf("ipad") > -1
				|| userAgent.indexOf("windows phone") > -1
				|| userAgent.indexOf("symbian") > -1
				|| userAgent.indexOf("mobile") > -1
				|| userAgent.indexOf("micromessenger") > -1) {
			return true;
		} else {
			StringBuffer result = new StringBuffer(userAgent);
			String ip = getIpAddr(request);
			result.append("  ip：");
			result.append(ip);

			try {
				String ip_result = HttpUtils.doGet(
						"http://ip.taobao.com/service/getIpInfo.php", "ip="
								+ ip, "utf-8");
				JSONObject root = JSONObject.parseObject(ip_result);
				JSONObject data = root.getJSONObject("data");

				result.append("  来源：");
				result.append(data.getString("region"));
				result.append(data.getString("city"));
				result.append(data.getString("county"));
				result.append(data.getString("isp"));
			} catch (Exception e) {
			}
			LogDao.getLog().addNorLog(result.toString());
			return false;
		}
	}

	/*
	 * 获取请求的IP地址
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		if (ip != null && ip.indexOf(",") > -1) {
			String[] ips = ip.split(",");
			for (int i = 0; i < ips.length; i++) {
				if (!"unknown".equalsIgnoreCase(ips[i])) {
					return ips[i];
				}
			}
		}
		return ip;
	}

	public static String unicodeToString(String str) {
		Pattern pattern = Pattern.compile("(\\\\u(\\p{XDigit}{4}))");
		Matcher matcher = pattern.matcher(str);
		char ch;
		while (matcher.find()) {
			ch = (char) Integer.parseInt(matcher.group(2), 16);
			str = str.replace(matcher.group(1), ch + "");
		}
		return str;
	}

	/**
	 * 生成任意位数随机字符串： 本算法利用62个可打印字符，通过随机生成32位UUID，由于UUID都为十六进制，
	 * 所以将UUID分成8组，每4个为一组，然后通过模62操作，结果作为索引取出字符
	 */
	public static synchronized String getRandomStr(int length) {
		String[] chars = new String[] { "a", "b", "c", "d", "e", "f", "g", "h",
				"i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
				"u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5",
				"6", "7", "8", "9" };

		StringBuffer shortBuffer = new StringBuffer();
		String uuid = UUID.randomUUID().toString().replace("-", "");
		int group = (int) 32 / length;
		for (int i = 0; i < length; i++) {
			String str = uuid.substring(i * group, i * group + group);
			int x = Integer.parseInt(str, 16);
			shortBuffer.append(chars[x % 0x24]);
		}
		chars = null;
		return shortBuffer.toString();
	}

	/**
	 * 二维数组纵向合并
	 */
	public static String[][] mergeArray(String[][] arr1, String[][] arr2) {
		String[][] newArrey = new String[][] {};
		List<String[]> list = new ArrayList<String[]>();
		list.addAll(Arrays.<String[]> asList(arr1));
		list.addAll(Arrays.<String[]> asList(arr2));
		return list.toArray(newArrey);
	}

	/**
	 * SHA1加密
	 * 
	 * @param strSrc
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public static String encryptAHA1(String strSrc)
			throws NoSuchAlgorithmException {
		String strDes = "";
		MessageDigest md = MessageDigest.getInstance("SHA-1");
		md.reset();
		byte[] b = md.digest(strSrc.getBytes());
		strDes = byteToHex(b);
		return strDes;
	}

	/**
	 * 将byte转换成16进制字符串
	 * 
	 * @param bytes
	 * @return
	 */
	public static String byteToHex(byte[] bytes) {
		StringBuffer buf = new StringBuffer(bytes.length * 2);
		for (int i = 0; i < bytes.length; i++) {
			if (((int) bytes[i] & 0xff) < 0x10) {
				buf.append("0");
			}
			buf.append(Long.toString((int) bytes[i] & 0xff, 16));
		}
		return buf.toString().toUpperCase();
	}

	/**
	 * 字符串转int
	 * 
	 * @param str
	 * @param default_
	 * @return
	 */
	public static int parseInt(String str, int default_) {
		try {
			return Integer.parseInt(str);
		} catch (Exception e) {
			return default_;
		}
	}

	/**
	 * 生成随机汉字
	 * 
	 * @param args
	 * @throws UnsupportedEncodingException
	 */
	public static String getRandomChineseCharacter(int len)
			throws UnsupportedEncodingException {
		String ret = "";
		for (int i = 0; i < len; i++) {
			String str = null;
			int hightPos, lowPos; // 定义高低位
			Random random = new Random();
			hightPos = (176 + Math.abs(random.nextInt(39))); // 获取高位值
			lowPos = (161 + Math.abs(random.nextInt(93))); // 获取低位值
			byte[] b = new byte[2];
			b[0] = (new Integer(hightPos).byteValue());
			b[1] = (new Integer(lowPos).byteValue());
			str = new String(b, "GBk"); // 转成中文
			ret += str;
		}
		return ret;
	}

	public static void readExcel() throws IOException {
		File file = new File("D:\\236.xls");
		POIFSFileSystem poifsFileSystem = new POIFSFileSystem(
				new FileInputStream(file));
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(poifsFileSystem);
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(1);

		int rowstart = hssfSheet.getFirstRowNum();
		int rowEnd = hssfSheet.getLastRowNum();

		for (int i = rowstart; i <= rowEnd; i++) {
			HSSFRow row = hssfSheet.getRow(i);
			if (null == row) {
				System.out.println("-----------------");
				break;
			}

			int cellStart = row.getFirstCellNum();
			int cellEnd = row.getLastCellNum();

			String name = "", content = "";

			for (int k = cellStart; k <= cellEnd; k++) {
				// System.out.println(k + "  ");
				HSSFCell cell = row.getCell(k);
				if (null == cell)
					continue;

				if (k == 0)
					name = cell.getStringCellValue();
				if (k == 1)
					content = cell.getStringCellValue();

				// System.out.println(name + "  " + content);

				switch (cell.getCellType()) {
				case HSSFCell.CELL_TYPE_NUMERIC: // 数字
					System.out.print(cell.getNumericCellValue() + "   ");
					break;
				case HSSFCell.CELL_TYPE_STRING: // 字符串
					System.out.print(cell.getStringCellValue() + "   ");
					break;
				case HSSFCell.CELL_TYPE_BOOLEAN: // Boolean
					System.out.println(cell.getBooleanCellValue() + "   ");
					break;
				case HSSFCell.CELL_TYPE_FORMULA: // 公式
					System.out.print(cell.getCellFormula() + "   ");
					break;
				case HSSFCell.CELL_TYPE_BLANK: // 空值
					// System.out.print("空值");
					break;
				case HSSFCell.CELL_TYPE_ERROR: // 故障
					System.out.print("故障");
					break;
				default:
					System.out.print("未知类型   ");
					break;
				}

			}
			System.out.print("\n");

			String sql = String
					.format(
							"INSERT INTO `tb_vote`(`name`, `content`, `topicId`, `wxaccount`, `addTime`,  `status`,  `num`) values('%S', '%S', 2077, 'gh_f967b5057a03', now(), 1, %S);",
							name, content, (i + 950));
			// System.out.println(sql);
			writeFile(sql);
		}
		hssfWorkbook.close();
	}

	public static void writeFile(String str) throws IOException {
		String path = "D:\\aa.sql";
		File file = new File(path);
		if (!file.exists())
			file.createNewFile();
		FileOutputStream out = new FileOutputStream(file, true); // 如果追加方式用true
		StringBuffer sb = new StringBuffer();
		sb.append(str + "\n");
		out.write(sb.toString().getBytes("gbk"));// 注意需要转换对应的字符集
		out.close();
	}

	public static void main(String[] args) {
		try {
			readExcel();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
