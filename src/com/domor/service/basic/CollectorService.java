package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.CollectorDao;

@Service("collectorService")
public class CollectorService {
	
	@Autowired
	private CollectorDao dao;
	
	public int insert(Map<String,Object> params) {
		//String codestr = "CJ" + MapUtils.getString(params, "pointCode");
		String codestr = MapUtils.getString(params, "pointCode");
		String lastCode = dao.getLastCode(codestr);
		String newcode = "";
		if(lastCode==null || lastCode.equals("")){
			newcode = codestr + "01";
		}else{
			Integer c = Integer.parseInt(lastCode.substring(lastCode.length()-2))+1;
			newcode = codestr + String.format("%02d", c);
		}
		params.put("collectorCode", newcode);
		return dao.insert(params);
	}
	
	public int update(Map<String,Object> params) {
		return dao.update(params);
	}
	
	public Map<String,Object> getByCode(String code) {
		return dao.getByCode(code);
	}

	public int count(Map<String, Object> params) {
		return dao.count(params);
	}
	
	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}
	
}
