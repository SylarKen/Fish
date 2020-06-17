package com.domor.service.basic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.domor.dao.basic.AreaDao;
import com.domor.model.Area;
import com.domor.model.TreeNode;
import com.domor.util.TreeNodeUtils;

@Service("areaService")
public class AreaService {
	
	@Autowired
	private AreaDao dao;

	public List<TreeNode> buildAllTree(String areaname, List<Integer> areaIds) {
		Map<String, Object> params = new HashMap<String, Object>();
		if(!StringUtils.isEmpty(areaname)) {
			params.put("areaname", areaname);
		}
		List<Area> areas = dao.queryAll(params);
		List<TreeNode> treeNodes = convert2TreeNodes(areas, areaIds);
		List<TreeNode> result = TreeNodeUtils.getFatherNodes(treeNodes);
		return result;
	}
	
	public List<TreeNode> convert2TreeNodes(List<Area> areas, List<Integer> areaIds) {
		List<TreeNode> treeNodes = new ArrayList<TreeNode>();
		for(Area area : areas) {
			TreeNode treeNode = new TreeNode();
			treeNode.setId(area.getId().toString());
			treeNode.setParentId(area.getParentid().toString());
			treeNode.setText(area.getAreaname());
			treeNode.setLevel(area.getLevel());
			Map<Object,Object> datas = new HashMap<Object,Object>();
			datas.put("lng", area.getLng());
			datas.put("lat", area.getLat());			
			treeNode.setDatas(datas);
			// 目前只支持省市
			if(area.getLevel() == 1 || area.getLevel() == 2) {
				treeNode.setState("closed");
			}
			if(areaIds != null && areaIds.size() > 0){
				if(areaIds.contains(area.getId())){
					treeNode.setChecked(true);
				}
			}
			treeNodes.add(treeNode);
		}
		return treeNodes;
	}
	
}
