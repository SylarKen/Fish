package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.IndexDao;

@Service
public class IndexService {
	
	@Autowired
	private IndexDao dao;

	public Map<String, Object> getAreaParent(String id) {
		return dao.getAreaParent(id);
	}

	public List<Map<String, Object>> getDeviceValue(Map<String, Object> params) {
		return dao.getDeviceValue(params);
	}

	
	
}
