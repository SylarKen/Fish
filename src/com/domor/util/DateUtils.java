package com.domor.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class DateUtils {

	public static final String DATE_FROMAT1 = "yyyy-MM-dd";
	public static final String DATE_FROMAT2 = "yyyy-MM-dd HH:mm:ss";

	public static Date getDate(String s) {
		return getDate(s, null);
	}

	public static Date getJustDate(String s) {
		return getDate(s, "yyyy-MM-dd");
	}

	public static Date getDate(long date) {
		return getDate(date, null);
	}

	public static Date getJustDate(long date) {
		return getDate(date, "yyyy-MM-dd");
	}

	public static Date getDate(long date, String format) {
		if (format == null || "".equals(format)) {
			format = "yyyy-MM-dd HH:mm:ss";
		}

		return getDate(formatDate(new Date(date), format), format);
	}

	public static Date getDate(String s, String format) {
		Date date;
		try {
			if (format == null || "".equals(format)) {
				format = "yyyy-MM-dd HH:mm:ss";
			}

			date = new SimpleDateFormat(format).parse(s);
		} catch (Exception e) {
			date = new Date(0L);
		}

		return date;
	}

	public static String formatDate(long date, String format) {
		return formatDate(new Date(date), format);
	}

	public static String formatDate(long date) {
		return formatDate(new Date(date), null);
	}

	public static String formatJustDate(long date) {
		return formatDate(new Date(date), "yyyy-MM-dd");
	}

	public static String formatDate(Date date, String format) {
		if (format == null || "".equals(format)) {
			format = "yyyy-MM-dd HH:mm:ss";
		}

		return new SimpleDateFormat(format).format(date);
	}
}
