package com.domor.dao.business;

import java.util.List;
import java.util.Map;

public interface RealtimeMonitorDao {
	//根据采集器编码查询采集器数据条数
	int count(Map<String, Object> params);
	//根据采集器编码查询采集器数据
	List<Map<String, Object>> query(Map<String, Object> params);
	//查询最新的采集器数据
	List<Map<String, Object>> queryNewChart(Map<String, Object> params);
	//根据养殖点查询池塘信息
	List<Map<String, Object>> queryPond(Map<String, Object> params);
	//根据采集器查询传感器信息
	List<Map<String, Object>> queryDevice(Map<String, Object> params);
	//根据养殖点查询经纬度信息
	List<Map<String, Object>> queryLngLat(Map<String, Object> params);
	//根据养殖点查询采集器
	List<Map<String, Object>> queryCollector(Map<String, Object> params);
	//根据采集器编码查询最新的PH数据
	List<Map<String, Object>> query_PHCurve(Map<String, Object> params);
	//根据采集器编码查询最新的温度、溶氧度数据
	List<Map<String, Object>> query_TOCurve(Map<String, Object> params);
	//根据传感器编码查询传感器
	List<Map<String, Object>> queryDeviceByCode(Map<String, Object> params);
	//根据传感器编码统计数据条数
	int countDeviceByCode(Map<String, Object> params);
	//根据部门编码查询经纬度
	List<Map<String, Object>> queryLngLatOnly(Map<String, Object> params);
	//根据用户名查询经纬度
	List<Map<String, Object>> queryLngLatByUsername(Map<String, Object> params);
	//根据经纬度查询采集器
	List<Map<String, Object>> queryDeviceByLntLat(Map<String, Object> params);
	
	int countDeviceByLntLat(Map<String, Object> params);
	
	List<Map<String, Object>> findDeptsByUser(String username);
	
	List<Map<String, Object>> findDeptsByCode(String[] array);
	
	List<Map<String, Object>> findPondsByUser(String username);
	
	List<Map<String, Object>> queryDeviceByPond(Map<String, Object> params);

}
