package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

public interface HistoryDataDao {
	
	/**
	 * 传感器列表
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> queryDeviceByPond(Map<String, Object> params);
	
    List<Map<String, Object>> findDeptsByUser(String username);
	
	List<Map<String, Object>> findDeptsByCode(String[] array);
	
	List<Map<String, Object>> findPondsByUser(String username);
	
	
	/**
	 * querySensorID
	 * @param params
	 * @return
	 */
	Map<String, Object>  querySensorID(Map<String, Object> params);
	
	/**
	 * 分页查询信息
	 * @param params
	 * @return
	 */
	int count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);
	List<Map<String,Object>> queryAll(Map<String, Object> params);
	List<Map<String,Object>> queryAllForCurve(Map<String, Object> params);
	
	
	
}
