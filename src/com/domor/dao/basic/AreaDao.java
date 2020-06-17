package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.Area;

public interface AreaDao {
	List<Area> queryAll(Map<String, Object> params);
}
