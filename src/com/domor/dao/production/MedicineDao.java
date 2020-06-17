package com.domor.dao.production;

import java.util.List;
import java.util.Map;


public interface MedicineDao {

	Integer getCount(Map<String, Object> params);

	List<Map<String, Object>> getData(Map<String, Object> params);

	Integer add(Map<String, Object> params);

	Integer edit(Map<String, Object> params);

	Map<String, Object> getById(int id);
	
}