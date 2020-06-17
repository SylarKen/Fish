package com.domor.dao.basic;

import java.util.List;
import java.util.Map;
 
public interface DeviceDao {
	
	String getLastCode(String code);
	int insert(Map<String,Object> params);
	int update(Map<String,Object> params);
	
	Map<String,Object> getByCode(String code);
	Integer count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);
	
	String getRule(String typeCode);
	List<Map<String, Object>> getTypes();
	
	List<Map<String,Object>> getDepts(Map<String,Object> params);
	List<Map<String,Object>> getPonds(String deptCode);
	
}
