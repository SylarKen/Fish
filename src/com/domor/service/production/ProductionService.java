package com.domor.service.production;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.domor.dao.production.ProductionDao;
import com.domor.util.ParamUtils;

@Service
public class ProductionService {
	
	@Autowired
	private ProductionDao dao;
	
	public List<Map<String, Object>> getTreeNodeList(HttpServletRequest request) {
		List<Map<String, Object>> companyList = new ArrayList<Map<String, Object>>();
		String firstPondCode = null;
		@SuppressWarnings("unchecked")
		Map<Object, Object> user = (Map<Object, Object>) request.getSession().getAttribute("user");
		Map<String, Object> params = ParamUtils.getParameterMap(request);
		params.put("username", user.get("username"));
		List<Map<String, Object>> list = dao.getUserPondList(params);
		
		if(list != null && list.size() > 0){
			//遍历池塘，倒推养殖点
			Map<String, Map<String, Object>> yzdMap = new HashMap<String, Map<String, Object>>();//MAP(code,node)
			for(Map<String, Object> pond : list){
				String pondCode = pond.get("code").toString();//池塘编码
				if(pondCode.length() != 7) continue;
				if(firstPondCode == null ) firstPondCode = pondCode;
				//更新本池塘父亲养殖点node的children，增加本池塘
				String yzdCode = pondCode.substring(0,5);//养殖点编码
				addChildNode2ParentMap(yzdMap, yzdCode, pond);
			}
			Map<String, Map<String, Object>> companyMap = new HashMap<String, Map<String, Object>>();//MAP(code,node)
			//遍历养殖点，倒推公司 
			for(Entry<String, Map<String, Object>> yzdEntry : yzdMap.entrySet()){
				String yzdCode = yzdEntry.getKey();
				Map<String, Object> yzdNode = yzdEntry.getValue();
				String companyCode = yzdCode.substring(0, 3);
				addChildNode2ParentMap(companyMap, companyCode, yzdNode);
			}
			//最后转化公司Map为List
			for(Entry<String, Map<String, Object>> componyEntry : companyMap.entrySet()){
				Map<String, Object> compony = componyEntry.getValue();
				companyList.add(compony);
			}
			//设置第一个池塘编码，方便前台默认选中
			if(companyList.size() > 0){
				companyList.get(0).put("firstPondCode", firstPondCode);
			}
		}
		return companyList;
	}
	
	@SuppressWarnings("unchecked")
	private void addChildNode2ParentMap(Map<String, Map<String, Object>> parentMap, String parentCode, Map<String, Object> childNode){
		Map<String, Object> parentNode = null;
		List<Map<String, Object>> children = null;
		if(parentMap.containsKey(parentCode)){
			parentNode = parentMap.get(parentCode);
			children = (ArrayList<Map<String, Object>>)parentNode.get("children");
		}else{
			parentNode = dao.getDeptByCode(parentCode);
			children = new ArrayList<Map<String, Object>>();
		}
		children.add(childNode);
		parentNode.put("children", children);
		parentMap.put(parentCode, parentNode);
	}

	
}
