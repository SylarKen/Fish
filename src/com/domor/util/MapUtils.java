package com.domor.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;

/**
 * 从 Map 中获取指定类型的数据
 * @author wgc
 *
 */
public class MapUtils {

	public static String getStringValue(Map<String, Object> map, String key, String defaultValue, String charset) {
		Object obj = map.get(key);
		if(ObjectUtils.isNull(obj)) {
			return "";
		}
		
		String value = obj.toString();
		if("null".equals(value.trim().toLowerCase()) || "".equals(value)) {
			return defaultValue;
		}
		if (!"".equals(charset)) {
			try {
				return URLDecoder.decode(value, charset);
			} catch (UnsupportedEncodingException e) {
			}
		}
		
		return value;
	}
	
	public static String getStringValue(Map<String, Object> map, String key, String defaultValue) {
		return getStringValue(map, key, defaultValue, "");
	}
	
	public static String getStringValue(Map<String, Object> map, String key) {
		return getStringValue(map, key, "", "");
	}
	
	public static boolean getBooleanValue(Map<String, Object> map, String key, boolean defaultValue) {
		Object obj = map.get(key);
		if(ObjectUtils.isNull(obj)) {
			return false;
		}
		
		String value = getStringValue(map, key, defaultValue + "");
		if ("true".equals(value)) {
			return true;
		} else if ("false".equals(value)) {
			return false;
		}
		
		return defaultValue;
	}
	
	public static boolean getBooleanValue(Map<String, Object> map, String key) {
		return getBooleanValue(map, key, false);
	}
	
	public static int getIntValue(Map<String, Object> map, String key, int defaultValue) {
		Object obj = map.get(key);
		if(ObjectUtils.isNull(obj)) {
			return 0;
		}
		
		String value = getStringValue(map, key, defaultValue + "");
		
		return Integer.parseInt(value);
	}
	
	public static int getIntValue(Map<String, Object> map, String key) {
		return getIntValue(map, key, 0);
	}
	
	public static double getDoubleValue(Map<String, Object> map, String key, double defaultValue) {
		Object obj = map.get(key);
		if(ObjectUtils.isNull(obj)) {
			return 0D;
		}
		
		String value = getStringValue(map, key, defaultValue + "");
		
		return Double.parseDouble(value);
	}
	
	public static double getDoubleValue(Map<String, Object> map, String key) {
		return getDoubleValue(map, key, 0D);
	}
	
	public static long getLongValue(Map<String, Object> map, String key, long defaultValue) {
		Object obj = map.get(key);
		if(ObjectUtils.isNull(obj)) {
			return 0L;
		}
		
		String value = getStringValue(map, key, defaultValue + "");
		
		return Long.parseLong(value);
	}
	
	public static long getLongValue(Map<String, Object> map, String key) {
		return getLongValue(map, key, 0L);
	}
	
}
