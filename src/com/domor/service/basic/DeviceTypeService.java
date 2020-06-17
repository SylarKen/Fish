package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.DeviceTypeDao;

@Service("deviceTypeService")
public class DeviceTypeService {
	
	@Autowired
	private DeviceTypeDao dao;
	
	public int insert(Map<String,Object> params) {
		return dao.insert(params);
	}
	
	public int update(Map<String,Object> params) {
		return dao.update(params);
	}
	
	public Map<String,Object> getById(int id) {
		return dao.getById(id);
	}
	
	public int getByCode(Map<String, Object> deviceType) {
		return dao.getByCode(deviceType);
	}

	public int count(Map<String, Object> params) {
		return dao.count(params);
	}
	
	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}

}
