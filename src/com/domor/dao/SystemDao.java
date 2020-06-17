package com.domor.dao;

import java.util.List;
import java.util.Map;

import com.domor.model.SearchDomain;

public interface SystemDao {

	List<Map<Object, Object>> getUser(SearchDomain params);

	List<Map<Object, Object>> getActionsByUser(String username);

	List<Map<Object, Object>> getAllActions();

	List<Map<Object, Object>> getMenusByUser(String username);

	Integer editPwd_save(SearchDomain params);

	Integer log_save(Map<String, Object> parmas);

	/**
	 * 根据用户名得到角色类型
	 * 
	 * @param username 用户名
	 * @return 角色类型
	 */
	// int getRoleTypeByUsername(String username);
}