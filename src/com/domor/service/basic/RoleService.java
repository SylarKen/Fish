package com.domor.service.basic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.RoleDao;
import com.domor.model.Role;
import com.domor.util.ObjectUtils;

@Service("roleService")
public class RoleService {

	@Autowired
	private RoleDao roleDao;
	
	public Role findById(int roleId) {
		return roleDao.findById(roleId);
	}
	
	public int count(Map<String, Object> params) {
		Integer result = roleDao.count(params);
		return result == null ? 0 : result.intValue();
	}
	
	public List<Role> query(Map<String, Object> params) {
		if(ObjectUtils.isNull(params)) {
			params = new HashMap<String, Object>();
		}
		return roleDao.query(params);
	}
	
	public List<Map<String, Object>> dataForCombo() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delete_flag", 0);
		List<Role> roles = roleDao.query(params);
		
		List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
		for(Role role : roles) {
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("id", role.getRoleId());
			data.put("text", role.getRoleName());
			datas.add(data);
		}
		return datas;
	}
	
}
