package com.domor.dao.business;

import java.util.List;
import java.util.Map;

public interface MapInfoDao {

	/**
	 * 根据用户登录名获取用户所管辖的养殖点
	 * @param username 用户登录名
	 * @return 养殖点
	 */
	List<Map<String, Object>> findDeptsByUser(String username);
	
	List<Map<String, Object>> findDeptsByCode(String[] strings);
	
	/**
	 * 根据养殖点编码查询养殖点内的所有采集器Id
	 * @param pointCode 养殖点编码
	 * @return 采集器Id
	 */
	List<String> findCollecotrIdsByPoint(String pointCode);
	
	/**
	 * 根据采集器编码获取最新的数据记录
	 * @param pointCode 养殖点编码
	 * @return 最新数据记录
	 */
	List<Map<String, Object>> findLastRecords(String pointCode);
	
	Integer countWarn(Map<String, Object> params);
	
	/**
	 * 获取报警记录
	 */
	List<Map<String, Object>> queryWarn(Map<String, Object> params);
	
	/**
	 * 获取养殖点下的所有设备实时信息
	 */
	List<Map<String, Object>> getDeviceInfosByDeptCode(String deptCode);
	
	
}
