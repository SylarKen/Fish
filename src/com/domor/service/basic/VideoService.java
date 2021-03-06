package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.VideoDao;

@Service
public class VideoService {
	
	@Autowired
	private VideoDao dao;

	public Integer getCount(Map<String, Object> params) {
		return dao.getCount(params);
	}

	public List<Map<String, Object>> getData(Map<String, Object> params) {
		return dao.getData(params);
	}

	public Integer add(Map<String, Object> params) {
		return dao.add(params);
	}

	public Integer edit(Map<String, Object> params) {
		return dao.edit(params);
	}

	public Map<String, Object> getById(int id) {
		return dao.getById(id);
	}


	
}
