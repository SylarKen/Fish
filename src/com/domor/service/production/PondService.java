package com.domor.service.production;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.production.PondDao;
@Service("pondService")
public class PondService {

	@Autowired
	private  PondDao dao;	
	//查询养殖点树形结构
	public List<Map<String,Object>> getDepts(Map<String, Object> params){
		System.out.println("dao.getChildDeptsForTree(params)"+dao.getChildDeptsForTree(params).toString());
		return dao.getChildDeptsForTree(params);
	}
	//添加池塘信息
	public int add_save(Map<String,Object> params) {
		return dao.insert(params);
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
	
}
