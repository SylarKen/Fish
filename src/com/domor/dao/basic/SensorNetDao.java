package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

public interface SensorNetDao {
	
	/**
	 * 查询养殖点的树
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> getChildDeptsForTree(Map<String, Object> params);
	List<Map<String,Object>> getChildCollectorForTree(Map<String, Object> params);
	
	/**
	 * 采集器传感器关联表  device 中的fatherID 
	 * @param params
	 * @return
	 */
	int addCollectorDevice(Map<String, Object> params);
	int addDeviceFatherID(Map<String, Object> params);
	
	/**
	 * delete采集器传感器关联表  device 中的fatherID 
	 * @param params
	 * @return
	 */
	int deleteCollectorDevice(Map<String, Object> params);
	int deleteDeviceFatherID(Map<String, Object> params);
	
	
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
	Integer countOxygen(Map<String, Object> params);
	List<Map<String,Object>> queryOxygen(Map<String, Object> params);
	
	/**
	 * 读取心跳包周期
	 */
	Map<String,Object> readHeartBeatCycle(Map<String, Object> params);
	
	
	/**
	 * 修改心跳包周期
	 */
	int updateHeartBeatCycle(Map<String, Object> params);
	
	
}
