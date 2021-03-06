package com.domor.service.basic;

import com.domor.dao.basic.CollectorNewGatewayDao;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("collectorNewGatewayService")
public class CollectorNewGatewayService {

	@Autowired
	private CollectorNewGatewayDao dao;

	public int insert(Map<String,Object> params) {
		String codestr = MapUtils.getString(params, "deptCode");
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

	public int updatethreshold(Map<String,Object> params) {
		return dao.updatethreshold(params);
	}

	public int updateautomatic(Map<String,Object> params) {
		return dao.updateautomatic(params);
	}

	public Map<String,Object> getByCode(String code) {
		return dao.getByCode(code);
	}

	public Map<String,Object> getById(String id) {
		return dao.getById(id);
	}
	public List<Map<String,Object>> getRecords(String id) {
		return dao.get_Records(id);
	}

	public int count(Map<String, Object> params) {
		return dao.count(params);
	}

	public List<Map<String,Object>> query(Map<String, Object> params) {
		return dao.query(params);
	}

}
