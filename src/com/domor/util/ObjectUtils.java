package com.domor.util;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;

public class ObjectUtils {

	public static final Object NULL = null;

	/**
	 * 判断对象是否为NULL
	 * @param o 对象
	 * @return true：对象为NULL；false：对象不为NULL
	 */
    public static boolean isNull(Object o) {
        return o == null;
    }

    /**
	 * 判断对象是否为NULL
	 * @param o 对象
	 * @return true：对象不为NULL；false：对象为NULL
	 */
    public static boolean notNull(Object o) {
        return !isNull(o);
    }

    /**
	 * 判断对象是否为空
	 * 	当对象为NULL时，返回true；
	 * 	当对象类型为String时，如果值为""，返回true；
	 *  当对象类型为Collection时，如果对象不包含元素，返回true；
	 *  当对象类型为Map时，如果对象不包含键-值映射关系，返回true；
	 *  当对象类型为一个数组类时，如果对象长度为0，返回true；
	 * @param o 对象
	 * @return true：对象为空；false：对象不为空
	 */
    public static boolean isEmpty(Object o) {
        if (isNull(o)) {
            return true;
        }

        if ((o instanceof String)) {
            return "".equals(o.toString());
        }
        if ((o instanceof Collection)) {
            return ((Collection) o).isEmpty();
        }
        if ((o instanceof Map)) {
            return ((Map) o).isEmpty();
        }
        if (o.getClass().isArray()) {
            return Array.getLength(o) == 0;
        }

        return true;
    }

    /**
	 * 判断对象是否为空
	 * @param o 对象
	 * @return true：对象不为空；false：对象为空
	 */
    public static boolean notEmpty(Object o) {
        return !isEmpty(o);
    }

    /**
     * 如果对象为NULL，返回safe；否则，返回actual
     * @param actual 实际值
     * @param safe 对象为NULL时返回值
     * @return 字符串
     */
    public static <T> T nullSafe(T actual, T safe) {
        return actual == null ? safe : actual;
    }
}
