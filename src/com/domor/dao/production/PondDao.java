package com.domor.dao.production;

import java.util.List;
import java.util.Map;

public interface PondDao {
	
	/**
	 * 查询养殖点的树
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> getChildDeptsForTree(Map<String, Object> params);

	/**
	 * 新增池塘信息
	 * @param params
	 * @return
	 */
	int insert(Map<String, Object> params);
	
	/**
	 * 新增池塘 用户关联
	 * @param params
	 * @return
	 */
	int insertUserPond(Map<String, Object> params);
	
	
	/**
	 * 分页查询池塘信息
	 * @param params
	 * @return
	 */
	int count(Map<String, Object> params);
	List<Map<String,Object>> query(Map<String, Object> params);
	
	
	/**
	 * 通过养殖点code 查询池塘信息
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> queryCode(Map<String, Object> params);
	
	/**
	 * 编辑 查看所要获取的池塘信息
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> findByCode(Map<String, Object> params);
	
	/**
	 * 编辑后 保存变更的信息
	 * @param params
	 * @return
	 */
	Integer edit(Map<String, Object> params);
}
