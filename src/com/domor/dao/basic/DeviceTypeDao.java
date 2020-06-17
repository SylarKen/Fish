package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

public interface DeviceTypeDao {
	
	int insert(Map<String,Object> deviceType);
	int update(Map<String,Object> deviceType);
	
	Map<String,Object> getById(int id);
	int getByCode(Map<String, Object> deviceType);
	Integer count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);
 
}
