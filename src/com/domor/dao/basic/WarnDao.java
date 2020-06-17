package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.User;

public interface WarnDao {
	
	int insert(Map<String,Object> user);
	
	int update(Map<String,Object> user);
	
	int delete(String username);
	
	Map<String,Object> getById(int id);

	List<Map<String,Object>> query(Map<String, Object> params);

	Integer count(Map<String, Object> params);
 
}
