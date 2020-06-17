package com.domor.dao.basic;

import java.util.List;
import java.util.Map;


public interface CollectorNewGatewayDao {

	String getLastCode(String code);
	int insert(Map<String, Object> collector);
	int update(Map<String, Object> collector);
	int updatethreshold(Map<String, Object> collector);
	int updateautomatic(Map<String, Object> collector);

	Map<String,Object> getByCode(String code);
	Map<String,Object> getById(String id);
	List<Map<String,Object>> get_Records(String id);

	Integer count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);

}
