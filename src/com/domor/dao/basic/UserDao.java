package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.User;

public interface UserDao {
	
	int insert(Map<String,Object> user);
	
	int insertPonds(Map<String,Object> pond);
	int deletePonds(String username);
	
	int update(Map<String,Object> user);		
	
	int delete(String username);
	
	Map<String,Object> getByName(String username);

	List<Map<String,Object>> query(Map<String, Object> params);

	Integer count(Map<String, Object> params);

	void initUserPwd(Map<String, Object> params);

}
