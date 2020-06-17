package com.domor.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import sun.misc.BASE64Encoder;

public class CommonUtil {
	public static String encodeStr(String str) {
		try {
			return new String(str.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

	/***
	 * 将List<Map<String,Object>>集合转换成javabean对象的list集合
	 * 
	 * @param <T>
	 * @param data
	 * @param c
	 * @return
	 * @throws Exception
	 */
	public static <T> List<T> MapsToObjects(List<Map<String, Object>> data, Class<T> c) throws Exception {
		Field[] fields = c.getDeclaredFields();
		List<T> result = new ArrayList<T>();

		for (int i = 0; i < data.size(); i++) {
			Map<String, Object> map = data.get(i);
			T t = c.newInstance();

			Set<String> set = map.keySet();
			Iterator<String> iter = set.iterator();
			while (iter.hasNext()) {
				String key = (String) iter.next();
				for (Field field : fields) {
					String fieldName = field.getName();
					if (fieldName.equals(key)) {
						String setMethodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
						Class<?> type = field.getType();
						Method setMethod = c.getMethod(setMethodName, type);
						setMethod.invoke(t, valueForamt(type, map.get(key)));
						break;
					}
				}

			}
			result.add(t);
		}
		return result;
	}

	/***
	 * 将Map<String,Object>对象转换成javabean对象
	 * 
	 * @param <T>
	 * @param data
	 * @param c
	 * @return
	 * @throws Exception
	 */
	public static <T> T MapToObject(Map<String, Object> data, Class<T> c) throws Exception {
		Field[] fields = c.getDeclaredFields();
		T t = c.newInstance();

		Set<String> set = data.keySet();
		Iterator<String> iter = set.iterator();
		while (iter.hasNext()) {
			String key = (String) iter.next();
			for (Field field : fields) {
				String fieldName = field.getName();
				if (fieldName.equals(key)) {
					String setMethodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
					Class<?> type = field.getType();
					Method setMethod = c.getMethod(setMethodName, type);
					setMethod.invoke(t, valueForamt(type, data.get(key)));
					break;
				}
			}

		}
		return t;
	}

	/**
	 * 通过反射调用set方法 去设置属性值 时 根据不同类型对value值进行类型转化
	 * 
	 * @param type
	 * @param value
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Object valueForamt(Class type, Object value) {
		try {
			if (type.equals(Integer.class) || type.equals(int.class))
				value = value == null ? 0 : (Integer) value;
			else if (type.equals(String.class)) {
				value = value == null ? "" : (String) value;
			} else if (type.equals(Boolean.class)) {
				value = value == null ? true : (Boolean) value;
			} else if (type.equals(Date.class)) {
				value = value == null ? new Date() : StringToDate(value.toString());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return value;
	}

	/**
	 * 泛型方法的使用 变量map 返回其value组成的List集合
	 * 
	 * @param map <K,V> K表示键key V表示值value
	 * @return
	 */
	public static <K, V> List<V> getMapValues(Map<K, V> map) {
		List<V> result = new ArrayList<V>();
		Set<K> set = map.keySet();
		Iterator<K> iter = set.iterator();
		while (iter.hasNext()) {
			Object key = iter.next();
			result.add(map.get(key));
		}
		return result;
	}

	public static String md5(String str) {
		try {
			// 将密码编程字节再加密
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] bys = md.digest(str.getBytes());
			// 将加密后的字节数组使用Base64算法变成字符串
			BASE64Encoder encode = new BASE64Encoder();
			return encode.encode(bys);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * 日期对象格式化
	 * 
	 * @param date
	 * @param format
	 * @return
	 * @throws ParseException
	 */
	public static Date DateFormat(Date date, String format) throws ParseException {
		String tempStr = DateToString(date, format);
		return StringToDate(tempStr, format);
	}

	public static Date DateFormat(Date date) throws ParseException {
		String tempStr = DateToString(date);
		return StringToDate(tempStr);
	}

	/**
	 * 日期对象转字符串
	 * 
	 * @Create In 2011-5-23 By mubd
	 * @param date
	 * @param format
	 * @return String
	 */
	public static String DateToString(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	public static String DateToString(Date date) {
		return DateToString(date, "yyyy-MM-dd");
	}

	/***
	 * 字符串转日期对象
	 * 
	 * @param dateString
	 * @param format
	 * @return
	 * @throws ParseException
	 */
	public static Date StringToDate(String dateString, String format) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		Date date = sdf.parse(dateString);
		return date;
	}

	public static Date StringToDate(String dateString) throws ParseException {
		return StringToDate(dateString, "yyyy-MM-dd");
	}

	/**
	 * 得到给定日期的当月第一天
	 * 
	 * @Methods Name getFirstDayOFDate
	 * @Description
	 * @Create In 2011-5-8 By huzh
	 * @param date
	 * @return Date
	 */
	public static Date getFirstDayOFDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		return cal.getTime();
	}

	/**
	 * 得到给定日期的当月最后一天
	 * 
	 * @Methods Name getFirstDayOFDate
	 * @Description
	 * @Create In 2011-5-8 By huzh
	 * @param date
	 * @return Date
	 */
	public static Date getLastDayOFDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		int day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		cal.set(Calendar.DAY_OF_MONTH, day);
		return cal.getTime();
	}

	/**
	 * 得到下月一号
	 * 
	 * @Methods Name getPreviousMonth
	 * @Description
	 * @Create In 2011-5-8 By huzh
	 * @return String
	 */
	public static Date getFirstDayOfNextMonth(Date date) {
		Calendar firstDate = Calendar.getInstance();
		firstDate.setTime(date);
		firstDate.set(Calendar.DAY_OF_MONTH, 1);
		firstDate.add(Calendar.MONTH, 1);
		return firstDate.getTime();
	}

	/**
	 * 得到给定日期的年、月或日
	 * 
	 * @Methods Name getYearMonthDayOfDate
	 * @Description
	 * @Create In 2011-5-9 By huzh
	 * @param date
	 * @param flag "year"、"month" or "day"
	 * @return int
	 */
	public static int getYearMonthDayOfDate(Date date, String flag) {
		Calendar calDate = Calendar.getInstance();
		calDate.setTime(date);
		if (flag != null && !"".equals(flag)) {
			if ("year".equals(flag)) {
				return calDate.get(Calendar.YEAR);
			} else if ("month".equals(flag)) {
				return calDate.get(Calendar.MONTH);

			} else if ("day".equals(flag)) {
				return calDate.get(Calendar.DAY_OF_MONTH);
			}

		}
		return 0;
	}

	/**
	 * 给定年月比较
	 * 
	 * @Methods Name isTheBeforeMonth
	 * @Description
	 * @Create In 2011-5-9 By huzh
	 * @param date
	 * @param fixDate
	 * @return boolean前者日期在后者之前返回true
	 */
	public static boolean isTheBeforeMonth(Date date, Date fixDate) {
		Calendar calDate = Calendar.getInstance();
		Calendar calFixDate = Calendar.getInstance();
		calDate.setTime(date);
		calFixDate.setTime(fixDate);
		if (calDate.get(Calendar.YEAR) < calFixDate.get(Calendar.YEAR)) {
			return true;
		} else if (calDate.get(Calendar.YEAR) == calFixDate.get(Calendar.YEAR) && calDate.get(Calendar.MONTH) < calFixDate.get(Calendar.MONTH)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 给定年月日比较
	 * 
	 * @param date
	 * @param fixDate
	 * @return 前者日期在后者之前返回true
	 */
	public static boolean isTheBeforeDay(Date date, Date fixDate) {
		Calendar calDate = Calendar.getInstance();
		Calendar calFixDate = Calendar.getInstance();
		calDate.setTime(date);
		calFixDate.setTime(fixDate);
		if (calDate.get(Calendar.YEAR) < calFixDate.get(Calendar.YEAR)) {
			return true;
		} else if (calDate.get(Calendar.YEAR) == calFixDate.get(Calendar.YEAR) && calDate.get(Calendar.MONTH) < calFixDate.get(Calendar.MONTH)) {
			return true;
		} else if (calDate.get(Calendar.YEAR) == calFixDate.get(Calendar.YEAR) && calDate.get(Calendar.MONTH) == calFixDate.get(Calendar.MONTH) && calDate.get(Calendar.DAY_OF_MONTH) <= calFixDate.get(Calendar.DAY_OF_MONTH)) {
			return true;
		} else {
			return false;
		}
	}

	/***
	 * 对于从数据库读取出的数据datas 根据其上下级关系 获取的树形结构所需的格式
	 * 
	 * @param datas 从数据库中获取的原始数据
	 * @param idName 主键字段名称
	 * @param parentIdName parentId的字段名称
	 * @param levelName 表示级别的字段名称
	 */
	public static List<Map<Object, Object>> getTreeData(List<Map<Object, Object>> oldDatas, String idName, String parentIdName, String levelName) {
		List<Map<Object, Object>> result = new ArrayList<Map<Object, Object>>();
		for (Map<Object, Object> data : oldDatas) {
			if (data.get(levelName).toString().equals("1")) { // 找到grade级别为1的所有节点
																// 依次采用getChildernForTree方法为这些节点找到其所有的下级
				data.put("iconCls", "icon-folder"); // 为生成的json对象中加入iconCls属性
													// 用来设置在easyui界面上的图标
				result.add(data);
				getChildernForTree(oldDatas, data, idName, parentIdName);
			}
		}
		return result;
	}

	/***
	 * 为原始数据oldDatas的指定的一条记录item 利用递归的方式遍历出其所有下级记录并封装为List<Map<Object,
	 * Object>>集合 并将该集合以value值的形式存放到该记录item的key='children'中
	 * 
	 * @param datas 从数据库中获取的原始数据
	 * @param item 表示datas中的其中一条数据 要为这条数据遍历出其所有下级记录
	 * @param idName 主键字段名称
	 * @param parentIdName parentId的字段名称
	 */
	public static void getChildernForTree(List<Map<Object, Object>> oldDatas, Map<Object, Object> item, String idName, String parentIdName) {
		List<Map<Object, Object>> children = new ArrayList<Map<Object, Object>>();
		for (Map<Object, Object> data : oldDatas) {
			Object parentId = data.get(parentIdName);
			if (item.get(idName).equals(parentId)) {
				children.add(data);
			}
		}
		item.put("children", children);
		for (Map<Object, Object> child : children)
			getChildernForTree(oldDatas, child, idName, parentIdName);

	}

	/***
	 * 对从数据库中查询出的数据进行分页操作 根据分页参数 获取到应该返回到前台的数据
	 * 
	 * @param datas 从数据库中查询出的原始数据
	 * @param rows 页大小 一页显示多少行
	 * @param page 当前页
	 * @return
	 */
	public static List<Map<Object, Object>> getTop(List<Map<Object, Object>> datas, int rows, int page) {
		int total = datas.size();
		int start = rows * (page - 1) > total ? 0 : rows * (page - 1);
		int end = start + rows > total ? total : start + rows;
		List<Map<Object, Object>> result = new ArrayList<Map<Object, Object>>();
		for (int i = start; i < end; i++) {
			Map<Object, Object> data = datas.get(i);
			if (data != null) {
				result.add(data);
			}
		}
		return result;
	}

	// //////////////////////////////////////////////////////工具方法测试////////////////////////////////////////////////////////

	// public static void main(String[] args) {
	// List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
	// Map<String, Object> map1 = new HashMap<String, Object>();
	// map1.put("name", "111");
	// map1.put("age", 20);
	// map1.put("sex", "nan");
	// map1.put("address", "beijing");
	//
	// Map<String, Object> map2 = new HashMap<String, Object>();
	// map2.put("name", "5555");
	// map2.put("age", 23);
	// map2.put("sex", "nv");
	// map2.put("address", "shanghai");
	//
	// data.add(map1);
	// data.add(map2);
	// try {
	// List<Test> tests = MapsToObjects(data, Test.class);
	// Test t = MapToObject(map1, Test.class);
	// System.out.println(tests.size());
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
}

class Test {
	private String name;
	private int age;
	private String sex;
	private String address;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}