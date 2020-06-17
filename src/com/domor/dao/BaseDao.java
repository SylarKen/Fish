package com.domor.dao;

import java.util.List;
import java.util.Map;

public interface BaseDao<T> {

	T findById(Integer id);

	Integer add(T t);

	Integer edit(T t);

	Integer delete(Integer id);

	Integer count(Map<String, Object> params);
	
	List<T> query(Map<String, Object> params);
}
