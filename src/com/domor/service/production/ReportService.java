package com.domor.service.production;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.production.ReportDao;

@Service
public class ReportService {
	
	@Autowired
	private ReportDao dao;

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

	public Integer report(Map<String, Object> params) {
		return dao.report(params);
	}

	public List<Map<String, Object>> getReplyByReportId(Map<String, Object> params) {
		return dao.getReplyByReportId(params);
	}


	
}
