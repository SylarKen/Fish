package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.DataDictionaryDao;
import com.domor.model.DataDictionary;

@Service("dataDictionaryService")
public class DataDictionaryService {

	@Autowired
	private  DataDictionaryDao dataDictionaryDao;
	
	public int insert(DataDictionary dataDictionary) {
		return dataDictionaryDao.insert(dataDictionary);
	}
	
	public int update(DataDictionary dataDictionary) {
		return dataDictionaryDao.update(dataDictionary);
	}
	
	public int delete(int dataDictionaryId) {
		return 0;
	}
	
	public DataDictionary findById(int dataDictionaryId) {
		return dataDictionaryDao.findById(dataDictionaryId);
	}
	
	public Integer count(Map<String, Object> params) {
		return dataDictionaryDao.count(params);
	}
	
	public List<DataDictionary> query(Map<String, Object> params) {
		return dataDictionaryDao.query(params);
	}
	
//	public int save(DataDictionary dataDictionary){
//		String code = dataDictionaryDao.getNewCode(dataDictionary.getCompanyId(), dataDictionary.getType());
//		dataDictionary.setCode(code);
//		return dataDictionaryDao.save(dataDictionary);
//	}
//
//	public void update(DataDictionary dataDictionary){
//		dataDictionaryDao.update(dataDictionary);
//	}
//	
//	public Integer delete(String dataId){
//		return dataDictionaryDao.delete(dataId);
//	
//	}
//	
//	public Integer count(SearchDomain params) {
//		return dataDictionaryDao.getData_total(params);
//	}
//	public List<Map<Object, Object>> query(SearchDomain params) {
//		return dataDictionaryDao.getData(params);
//	}
//	
//	public List<DataDictionary> getDataDictionariesByType(String type,String companyId) {
//		return dataDictionaryDao.getByType(type,companyId);
//	}

}
