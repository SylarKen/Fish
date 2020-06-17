package com.domor.model;

import java.util.List;
import java.util.Map;

public class TreeNode {

	private String id;
	private String parentId;
	private String text;
	private boolean checked;
	private int level;
	private String state;
	private String iconCls;
	private List<TreeNode> children;
	private Map<Object,Object> datas;
	
	public Map<Object, Object> getDatas() {
		return datas;
	}

	public void setDatas(Map<Object, Object> datas) {
		this.datas = datas;
	}

	public TreeNode() {}
	
	public TreeNode(String id, String text, String parentId) {
		this.id = id;
		this.text = text;
		this.parentId = parentId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		if (parentId == null) {
			this.parentId = "";
		} else {
			this.parentId = parentId;
		}
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	public boolean isChecked() {
		return checked;
	}
	
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
	public int getLevel() {
		return level;
	}
	
	public void setLevel(int level) {
		this.level = level;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getIconCls() {
		return iconCls;
	}
	
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	
	public List<TreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
}
