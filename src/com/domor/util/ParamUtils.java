package com.domor.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 获取HttpServletRequest中的参数、属性工具类
 * 
 * @author Administrator
 * 
 */
public class ParamUtils {

	/**
	 * 获取字符串类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认""
	 */
	public static String getStringParameter(HttpServletRequest request, String name) {
		return getStringParameter(request, name, "");
	}

	/**
	 * 获取字符串类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @param defayktValue 默认值
	 * @return 参数值
	 */
	public static String getStringParameter(HttpServletRequest request, String name, String defaultValue) {
		return getStringParameter(request, name, defaultValue, "");
	}

	/**
	 * 获取字符串类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @param defayktValue 默认值
	 * @param charset 字符集
	 * @return 参数值
	 */
	public static String getStringParameter(HttpServletRequest request, String name, String defaultValue, String charset) {
		String value = request.getParameter(name);

		if (value == null || "".equals(value)) {
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

	/**
	 * 获取布尔类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认false
	 */
	public static boolean getBooleanParameter(HttpServletRequest request, String name) {
		return getBooleanParameter(request, name, false);
	}

	/**
	 * 获取布尔类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @param defaultValue 默认值
	 * @return 参数值
	 */
	public static boolean getBooleanParameter(HttpServletRequest request, String name, boolean defaultValue) {
		String value = request.getParameter(name);

		if ("true".equals(value)) {
			return true;
		} else if ("false".equals(value)) {
			return false;
		}

		return defaultValue;
	}

	/**
	 * 获取整数类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认0
	 */
	public static int getIntParameter(HttpServletRequest request, String name) {
		return getIntParameter(request, name, 0);
	}

	/**
	 * 获取整数类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @param defaultValue 默认值
	 * @return 参数值
	 */
	public static int getIntParameter(HttpServletRequest request, String name, int defaultValue) {
		String value = request.getParameter(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Integer.parseInt(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 获取浮点类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认0D
	 */
	public static double getDoubleParameter(HttpServletRequest request, String name) {
		return getDoubleParameter(request, name, 0D);
	}

	/**
	 * 获取浮点类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认0D
	 */
	public static double getDoubleParameter(HttpServletRequest request, String name, double defaultValue) {
		String value = request.getParameter(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Double.parseDouble(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 获取长整型类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @return 参数值，默认0L
	 */
	public static long getLongParameter(HttpServletRequest request, String name) {
		return getLongParameter(request, name, 0L);
	}

	/**
	 * 获取长整型类型的参数
	 * 
	 * @param request
	 * @param name 参数名称
	 * @param defaultValue 默认值
	 * @return 参数值
	 */
	public static long getLongParameter(HttpServletRequest request, String name, long defaultValue) {
		String value = request.getParameter(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Long.parseLong(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 获取字符串类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @return 属性值，默认""
	 */
	public static String getStringAttribute(HttpServletRequest request, String name) {
		return getStringAttribute(request, name, "");
	}

	/**
	 * 获取字符串类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @param defaultValue 默认值
	 * @return 属性值
	 */
	public static String getStringAttribute(HttpServletRequest request, String name, String defaultValue) {
		String value = (String) request.getAttribute(name);

		if (value == null || "".equals(value)) {
			return defaultValue;
		}

		return value;
	}

	/**
	 * 获取布尔类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @return 属性值，默认false
	 */
	public static boolean getBooleanAttribute(HttpServletRequest request, String name) {
		return getBooleanAttribute(request, name, false);
	}

	/**
	 * 获取布尔类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @param defaultValue 默认值
	 * @return 属性值
	 */
	public static boolean getBooleanAttribute(HttpServletRequest request, String name, boolean defaultValue) {
		String value = (String) request.getAttribute(name);

		if ("true".equals(value)) {
			return true;
		} else if ("false".equals(value)) {
			return false;
		}

		return defaultValue;
	}

	/**
	 * 获取整数类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @return 属性值，默认0
	 */
	public static int getIntAttribute(HttpServletRequest request, String name) {
		return getIntAttribute(request, name, 0);
	}

	/**
	 * 获取整数类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @param defaultValue 默认值
	 * @return 属性值
	 */
	public static int getIntAttribute(HttpServletRequest request, String name, int defaultValue) {
		String value = (String) request.getAttribute(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Integer.parseInt(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 获取浮点类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @return 属性值，默认0D
	 */
	public static double getDoubleAttribute(HttpServletRequest request, String name) {
		return getDoubleAttribute(request, name, 0D);
	}

	/**
	 * 获取浮点类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @param defaultValue 默认值
	 * @return 属性值
	 */
	public static double getDoubleAttribute(HttpServletRequest request, String name, double defaultValue) {
		String value = (String) request.getAttribute(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Double.parseDouble(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 获取长整数类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @return 属性值，默认0L
	 */
	public static long getLongAttribute(HttpServletRequest request, String name) {
		return getLongAttribute(request, name, 0L);
	}

	/**
	 * 获取长整数类型的属性
	 * 
	 * @param request
	 * @param name 属性名称
	 * @param defaultValue 默认值
	 * @return 属性值
	 */
	public static long getLongAttribute(HttpServletRequest request, String name, long defaultValue) {
		String value = (String) request.getAttribute(name);

		if (value != null && !"".equals(value)) {
			try {
				defaultValue = Long.parseLong(value);
			} catch (Exception e) {
			}
		}

		return defaultValue;
	}

	/**
	 * 从request中获得参数Map，并返回可读的Map
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public static Map<String, Object> getParameterMap(HttpServletRequest request) {
	    // 参数Map
	    Map<String, String []> properties = request.getParameterMap();
	    // 返回值Map
	    Map<String, Object> returnMap = new HashMap<String, Object>();
	    Iterator entries = properties.entrySet().iterator();
	    Map.Entry entry;
	    String name = "";
	    String value = "";
	    while (entries.hasNext()) {
	        entry = (Map.Entry) entries.next();
	        name = (String) entry.getKey();
	        Object valueObj = entry.getValue();
	        if(null == valueObj){
	            value = "";
	        }else if(valueObj instanceof String[]){
	            String[] values = (String[])valueObj;
	            for(int i=0;i<values.length;i++){
	                value = values[i] + ",";
	            }
	            value = value.substring(0, value.length()-1);
	        }else{
	            value = valueObj.toString();
	        }
	        if(!"".equals(value)) {
	        	returnMap.put(name, value);
	        }
	    }
	    
	    Map<String, Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
	    returnMap.put("loginUser", MapUtils.getStringValue(user, "username"));
	    returnMap.put("userDept", MapUtils.getStringValue(user, "dept"));
	    returnMap.put("userRole", MapUtils.getStringValue(user, "role"));
	    return returnMap;
	}

	/**
	 * 向请求参数中添加分布所需属性skipCount
	 * @param params 查询参数
	 * @param total 总的记录数
	 */
	public static void addSkipCount(Map<String, Object> params, int total) {
		int page = Integer.parseInt(String.valueOf(params.get(("page"))));
		int rows = Integer.parseInt(String.valueOf(params.get(("rows"))));
		int start = rows * (page - 1) > total ? 0 : rows * (page - 1);
		int end = (start+rows)>total?total:(start+rows);

		params.put("rows", rows);
		params.put("start", start);
		params.put("end", end);
	}

	public static String mapToString(Map<String, Object> params, String keyName) {
		return params.get(keyName) == null ? "" : params.get(keyName).toString();
	}
}
