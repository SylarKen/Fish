package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

public interface WarnConfDao {
	
	void add(Map<String, Object> warnConf);
	
	void edit(Map<String, Object> warnConf);
	
	List<Map<String, Object>> query(Map<String, Object> params);

	Map<String, Object> findById(int id);

	Map<String, Object> findByDeviceCode(String deviceCode);
	
	List<Map<String, Object>> getWarnInfo(String pondCode);

}
