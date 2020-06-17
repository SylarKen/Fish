package com.domor.dao.production;

import java.util.List;
import java.util.Map;


public interface ReportDao {

	Integer getCount(Map<String, Object> params);

	List<Map<String, Object>> getData(Map<String, Object> params);

	Integer add(Map<String, Object> params);

	Integer edit(Map<String, Object> params);

	Map<String, Object> getById(int id);

	Integer report(Map<String, Object> params);

	List<Map<String, Object>> getReplyByReportId(Map<String, Object> params);
	
}