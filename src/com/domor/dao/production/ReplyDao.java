package com.domor.dao.production;

import java.util.List;
import java.util.Map;


public interface ReplyDao {

	Integer getCount(Map<String, Object> params);

	List<Map<String, Object>> getData(Map<String, Object> params);

	Integer add(Map<String, Object> params);

	Integer edit(Map<String, Object> params);

	Map<String, Object> getById(int id);
	
	Map<String, Object> getReportById(int id);
	
	List<Map<String, Object>> getReplyByReportId(Map<String, Object> params);
	
	Integer getValidReplyNumByReportId(Map<String, Object> params);

	Integer updateReport(Map<String, Object> params);

}