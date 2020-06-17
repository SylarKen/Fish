package com.domor.dao.basic;

import java.util.List;
import java.util.Map;

import com.domor.model.DataDictionary;

public interface DataDictionaryDao {
	
	int insert(DataDictionary dataDictionary);
	
	int update(DataDictionary dataDictionary);
	
	int delete(int id);
	
	DataDictionary findById(int id);
	
	Integer count(Map<String, Object> params);
	
	List<DataDictionary> query(Map<String, Object> params);
	
	// 保存
//	public int save(DataDictionary dataDictionary);
//
//	// 删除
//	public Integer delete(String dataId);
//
//	// 更新
//	public void update(DataDictionary dataDictionary);
//
//	public DataDictionary getdate(String name);
//
//	public List<DataDictionary> getAll();
//
//	public String getNewCode(int companyId, String type);
//
//	// 统计商品数量
//	public Integer getData_total(SearchDomain params);
//
//	// 获取商品列表
//	public List<Map<Object, Object>> getData(SearchDomain params);

	/**
	 * 根据类型查询数据
	 * 
	 * @param type 数据类型
	 * @return 数据集
	 */
	List<DataDictionary> getByType(String type, String companyId);

}
