package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.Role;

public interface RoleDao {

	public Role findById(int id);
	
	public Integer count(Map<String, Object> params);
	
	public List<Role> query(Map<String, Object> params);
}
