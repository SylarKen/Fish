package com.domor.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;

import com.domor.model.PagerReturns;
import com.domor.model.TreeNode;

public class TreeNodeUtils {
	
	public final static List<TreeNode> getFatherNodes(List<TreeNode> treeNodes) {
		return getFatherNodes(treeNodes, "0");
	}

	public final static List<TreeNode> getFatherNodes(List<TreeNode> treeNodes, String root) {
		List<TreeNode> resultTreeNodes = new ArrayList<TreeNode>();
		if (root == null) {
			root = "";
		}
		for(TreeNode treeNode : treeNodes) {
			if(root.equals(treeNode.getParentId())) {
				treeNode.setChildren(getChildrenNodes(treeNode.getId(), treeNodes, root));
				resultTreeNodes.add(treeNode);
			}
		}
		return resultTreeNodes;
	}
	
	public final static List<TreeNode> getChildrenNodes(String parentId, List<TreeNode> treeNodes, String root) {
		List<TreeNode> resultTreeNodes = new ArrayList<TreeNode>();
		for(TreeNode treeNode : treeNodes) {
			if(root.equals(treeNode.getParentId())) {
				continue;
			}
			if(parentId.equals(treeNode.getParentId())) {
				treeNode.setChildren(getChildrenNodes(treeNode.getId(), treeNodes, root));
				resultTreeNodes.add(treeNode);
			}
		}
		return resultTreeNodes;
	}
	
	

	
	public static  PagerReturns  getTreeDataDept(List<Map<String, Object>> list,Map<String, Object> params){
		int topGrade = 100;
		for(Map<String,Object> l : list){
			int grade = MapUtils.getIntValue(l,"grade");
			topGrade = grade<topGrade?grade:topGrade;
		}
		
		List<Map<String,Object>> listTop = getTopDeptsForTree(list,topGrade);
		int total = listTop.size();
 
		ParamUtils.addSkipCount(params, total);
		params.put("topGrade", topGrade);
		List<Map<String, Object>> result = getDeptsForTree(list,listTop,params);
		PagerReturns pager = new PagerReturns(result, total);
		return pager;
	}
	

	private static List<Map<String,Object>> getTopDeptsForTree(List<Map<String,Object>> list,int topGrade){
		List<Map<String,Object>> listTop = new ArrayList<Map<String,Object>>();
		for(int i = 0;i<list.size();i++){
			Map<String,Object> dept = list.get(i);
			int grade = MapUtils.getIntValue(dept,"grade");
			if(grade==topGrade){
				listTop.add(dept);
			}	
		}
		return listTop;
	}
	
	
	private static  List<Map<String,Object>> getDeptsForTree(List<Map<String,Object>> list,List<Map<String,Object>> listTop,Map<String, Object> params){

		int topGrade = MapUtils.getIntValue(params, "topGrade");
		int start =  MapUtils.getIntValue(params, "start");
		int end =  MapUtils.getIntValue(params, "end");
		
		
		List<Map<String,Object>> list_page = new ArrayList<Map<String,Object>>();
		for(int i=start;i<end;i++){
			list_page.add(listTop.get(i));
		}
		
		List<Map<String,Object>> result  = new ArrayList<Map<String,Object>>();
		getChildren(list,list_page,result,topGrade,topGrade);
		return result;
	}
	
	
	private static  void getChildren(List<Map<String,Object>> list,List<Map<String,Object>> list_page,List<Map<String,Object>> result ,int topGrade,int thisGrade){	
	
		for(Map<String,Object> dept:list_page){
			int grade = MapUtils.getIntValue(dept,"grade");
			String code = MapUtils.getString(dept, "code");
			if(grade == thisGrade){			
				List<Map<String,Object>> children = new ArrayList<Map<String,Object>>();
				for(Map<String,Object> d:list){			
					String pcode = MapUtils.getString(d,"pcode");
					if(pcode.equals(code)){
						children.add(d);
					}			
				}
				if(children.size()>0){
					dept.put("children", children);
					getChildren(list,children,result,topGrade,thisGrade+1);
				}
				if(topGrade==thisGrade)
					result.add(dept);
			}
		}

	}
 
}
