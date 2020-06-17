package com.domor.service.basic;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.basic.DeptDao;
import com.domor.model.Area;
import com.domor.model.DataDictionary;
import com.domor.model.PagerReturns;
import com.domor.model.TreeNode;
import com.domor.util.ParamUtils;

@Service("deptService")
public class DeptService {

	@Autowired
	private  DeptDao dao;
	
	public String getNewCode1(){
		return dao.getNewCode1();
	}
	public String getNewCode2(String pcode){
		return dao.getNewCode2(pcode);
	}
	public int insert(Map<String,Object> params) {
		return dao.insert(params);
	}
	
	public int update(Map<String,Object> params) {
		return dao.update(params);
	}
	
	public int delete(String code) {
		return 0;
	}
	
	public Map<String,Object> findById(String code) {
		return dao.findById(code);
	}

	public List<Map<String,Object>> getChildDepts(String username){
		return dao.getChildDepts(username);
	}
	
	public List<Map<String,Object>> getDeptForComb(String username,String area){
		return dao.getDeptForComb(username,area);
	}

	
	public List<Map<String,Object>> getDepts(Map<String, Object> params){
		return dao.getChildDeptsForTree(params);
	}
	
	public List<Map<String,Object>> getTopAreasForTree(List<Map<String,Object>> list,int topGrade){
		List<Map<String,Object>> listTop = new ArrayList<Map<String,Object>>();
		for(int i = 0;i<list.size();i++){
			Map<String,Object> dept = list.get(i);
			int grade = MapUtils.getIntValue(dept,"level");
			if(grade==topGrade){
				listTop.add(dept);
			}	
		}
		return listTop;
	}
	
 
	
 
 
}
