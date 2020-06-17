package com.domor.service.basic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.DeviceDao;

@Service("deviceService")
public class DeviceService {
	
	@Autowired
	private DeviceDao dao;
	
	public int insert(Map<String,Object> params) {
//		String rule = dao.getRule(MapUtils.getString(params, "typeCode"));
//		String codestr = rule + MapUtils.getString(params, "pondCode");
		String codestr = MapUtils.getString(params, "pondCode");
		String lastCode = dao.getLastCode(codestr);
		String newcode = "";
		if(lastCode==null || lastCode.equals("")){
			newcode = codestr + "001";
		}else{
			Integer c = Integer.parseInt(lastCode.substring(lastCode.length()-3))+1;
			newcode = codestr + String.format("%03d", c);
		}
		params.put("deviceCode", newcode);
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

	public List<Map<String,Object>> getTypes() {
		return dao.getTypes();
	}
	
	public List<Map<String,Object>> getPonds(Map<String,Object> params){
		params.put("pcode", 0);
		List<Map<String,Object>> ponds = dao.getDepts(params);
		for(Map<String,Object> pond:ponds){
			String code = MapUtils.getString(pond, "code");
			Map<String,Object> params1 = new HashMap<String,Object>();
			params1.put("pcode", code);
			List<Map<String,Object>> cs = dao.getDepts(params1); 
			for(Map<String,Object> c:cs){
				List<Map<String,Object>> ps = dao.getPonds(MapUtils.getString(c, "code"));
				c.put("children", ps);
			}
			pond.put("children", cs);
		}
		return ponds;
	}
	
}
