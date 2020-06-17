package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

 
public interface CollectorDao {
	
	String getLastCode(String code);
	int insert(Map<String,Object> collector);
	int update(Map<String,Object> collector);
	
	Map<String,Object> getByCode(String code);
	Integer count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);
 
}
