package com.domor.dao.production;

import java.util.List;
import java.util.Map;


public interface InspectionDao {

	Integer getCount(Map<String, Object> params);

	List<Map<String, Object>> getData(Map<String, Object> params);

	Integer add(Map<String, Object> params);

	Integer edit(Map<String, Object> params);

	Map<String, Object> getById(int id);
	
	Map<String, Object> getByPondInfo(Map<String, Object> params);
	
}