package com.domor.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.SystemDao;
import com.domor.model.SearchDomain;

@Service("systemService")
public class SystemService {

	private SystemDao dao;

	public SystemDao getDao() {
		return dao;
	}

	@Autowired
	public void setDao(SystemDao dao) {
		this.dao = dao;
	}

	public List<Map<Object, Object>> getUser(SearchDomain params) {
		return dao.getUser(params);
	}

	public List<Map<Object, Object>> getActionsByUser(String username) {
		return dao.getActionsByUser(username);
	}

	public List<Map<Object, Object>> getAllActions() {
		return dao.getAllActions();
	}

	public List<Map<Object, Object>> getMenusByUser(String username) {
		return dao.getMenusByUser(username);
	}

	public Integer editPwd_save(SearchDomain params) {
		return dao.editPwd_save(params);
	}

	public Integer log_save(Map<String, Object> parmas) {
		return dao.log_save(parmas);
	}

//	public int getRoleTypeByUsername(String username) {
//		return dao.getRoleTypeByUsername(username);
//	}
}
