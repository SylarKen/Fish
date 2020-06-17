package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.domor.dao.basic.WarnDao;
 
@Service("warnService")
public class WarnService {

	@Autowired
	private WarnDao dao;
	
	public int insert(Map<String,Object> user) {
		return dao.insert(user);
	}
	
	
	public int update(Map<String,Object> user) {
		return dao.update(user);
	}
	
	public int delete(String username) {
		return dao.delete(username);
	}
	
	public Map<String,Object> getById(int id) {
		return dao.getById(id);
	}

	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}

	public int count(Map<String, Object> params) {
		Integer result = dao.count(params);
		return result == null ? 0 : result.intValue();
	}
 

}
