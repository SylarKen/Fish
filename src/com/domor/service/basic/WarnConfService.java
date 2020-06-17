package com.domor.service.basic;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.WarnConfDao;
import com.domor.util.MapUtils;
import com.github.pagehelper.PageHelper;

@Service("warnConfService")
public class WarnConfService {

	@Autowired
	private WarnConfDao warnConfDao;
	
	public void add(Map<String, Object> warnConf) {
		warnConfDao.add(warnConf);
	}
	
	public void edit(Map<String, Object> warnConf) {
		warnConfDao.edit(warnConf);
	}
	
	public List<Map<String, Object>> query(Map<String, Object> params) {
	    int pageNum = MapUtils.getIntValue(params, "page");
	    int pageSize = MapUtils.getIntValue(params, "rows");
	    PageHelper.startPage(pageNum, pageSize);
	    return warnConfDao.query(params);
	}

	public Map<String, Object> findById(int id) {
		return warnConfDao.findById(id);
	}

	public Object findByDeviceCode(String deviceCode) {
		return warnConfDao.findByDeviceCode(deviceCode);
	}
	
	
}
