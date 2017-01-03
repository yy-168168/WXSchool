package com.wxschool.entity;

import java.awt.image.BufferedImage;

public class ValidateCode {

	private BufferedImage bufferedImage;
	private String cookieStr;

	public BufferedImage getBufferedImage() {
		return bufferedImage;
	}

	public void setBufferedImage(BufferedImage bufferedImage) {
		this.bufferedImage = bufferedImage;
	}

	public String getCookieStr() {
		return cookieStr;
	}

	public void setCookieStr(String cookieStr) {
		this.cookieStr = cookieStr;
	}

}
