package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.SensorNetDao;
import com.domor.dao.production.PondDao;
@Service("sensorNetService")
public class SensorNetService {

	@Autowired
	private  SensorNetDao dao;
	
	public Map<String,Object> readHeartBeatCycle(Map<String, Object> params){
		return dao.readHeartBeatCycle(params);
	}
	public int updateHeartBeatCycle(Map<String,Object> params) {
		return dao.updateHeartBeatCycle(params);
		
	}
	
	
	
	//查询养殖点树形结构
	public List<Map<String,Object>> getDepts(Map<String, Object> params){
		return dao.getChildDeptsForTree(params);
	}
	public List<Map<String,Object>> getCollectors(Map<String, Object> params){
		return dao.getChildCollectorForTree(params);
	}
	//采集器传感器关联表  
	public int addCollectorDevice(Map<String,Object> params) {
		return dao.addCollectorDevice(params);
		
	}
	//device 中的fatherID 
	public int addDeviceFatherID(Map<String,Object> params) {
		return dao.addDeviceFatherID(params);
		
	}
	
	//delete采集器传感器关联表  
	public int deleteCollectorDevice(Map<String,Object> params) {
		return dao.deleteCollectorDevice(params);
	}
	//delete device 中的fatherID 
	public int deleteDeviceFatherID(Map<String,Object> params) {
		return dao.deleteDeviceFatherID(params);	
	}
	
	//添加池塘 用户关联
	public int add_saveUserPond(Map<String,Object> params) {
		return dao.insertUserPond(params);
	}
		
	//计算分页数量	
	public int count(Map<String, Object> params) {
		Integer result = dao.count(params);
		return result;
	}
	
	//分页展示
	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}	
	
	//自动生成编码时,查询已有的编码序号
	public List<Map<String,Object>> queryCodes(Map<String, Object> params){
		return dao.queryCode(params);
	}
	
	//通过code 查询对应的池塘信息
	public List<Map<String,Object>> findByCode(Map<String, Object> params){
		return dao.findByCode(params);
	}
	
	//编辑池塘信息
	public Integer edit(Map<String, Object> params) {
		return dao.edit(params);
	}
	
	public int countOxygen(Map<String, Object> params) {
		return dao.countOxygen(params);
	}
	
	public List<Map<String,Object>> queryOxygen(Map<String, Object> params) {
		return dao.queryOxygen(params);
	}
	
}
