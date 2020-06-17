package com.domor.model;

import java.util.Map;

public class TreeGridNode extends TreeNode {

	private String iconCls;
	
	private Map<String, Object> attributes;

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public Map<String, Object> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	
}
