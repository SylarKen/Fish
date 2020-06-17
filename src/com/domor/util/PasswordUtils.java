package com.domor.util;

import java.security.MessageDigest;

public class PasswordUtils {

	// 默认加密次数
	private final static int DEFAULT_NUMBER_OF_ENCRYPTION = 2;

	private final static String encode(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			byte[] strTemp = s.getBytes();
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte b = md[i];
				str[k++] = hexDigits[b >> 4 & 0xf];
				str[k++] = hexDigits[b & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 字符串加密
	 * @param s 需要加密的字符串
	 * @return 加密后的字符串
	 */
	public final static String encrypt(String s) {
		String result = "";
		for (int i = 0; i < PasswordUtils.DEFAULT_NUMBER_OF_ENCRYPTION; i++) {
			result = PasswordUtils.encode(s);
		}
		return result;
	}

	/**
	 * 字符串加密
	 * @param s 需要加密的字符串
	 * @param num 加密次数
	 * @return 加密后的字符串
	 */
	public final static String encrypt(String s, int num) {
		String result = "";
		for (int i = 0; i < num; i++) {
			result = PasswordUtils.encode(s);
		}
		return result;
	}

	public static void main(String[] args) {
		String str = "123456";
		System.out.println(PasswordUtils.encrypt(str));
	}
}
