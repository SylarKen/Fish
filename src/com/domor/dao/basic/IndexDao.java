package com.domor.dao.basic;

import java.util.List;
import java.util.Map;



public interface IndexDao {

	Map<String, Object> getAreaParent(String id);

	List<Map<String, Object>> getAreaParent(Map<String, Object> params);

	List<Map<String, Object>> getDeviceValue(Map<String, Object> params);
	
}