package com.domor.dao.production;

import java.util.List;
import java.util.Map;


public interface ProductionDao {

	List<Map<String, Object>> getUserPondList(Map<String, Object> params);

	Map<String, Object> getPondByCode(String pondCode);

	Map<String, Object> getDeptByCode(String yzdCode);
	
}