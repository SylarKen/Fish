package com.domor.model;

import java.util.List;

/**
 * 菜单项
 */
public class Menu extends Entity {

	private static final long serialVersionUID = 7017687361260383318L;
	
	/**
	 * 菜单 ID
	 */
	private Integer menuId;
	
	/**
	 * 菜单显示名称
	 */
	private String menuName;
	
	/**
	 * 菜单地址
	 */
	private String menuUrl;
	
	/**
	 * 图标地址(使用fontawesome)
	 */
	private String iconUrl;
	
	/**
	 * 上级菜单 ID
	 */
	private Integer parentId;
	
	/**
	 * 菜单层级：从 1 开始
	 */
	private Integer menuLevel;
	
	/**
	 * 是否是叶子节点：0-不是叶子节点，即含有子菜单；1-是叶子节点
	 */
	private Integer isLeaf = 1;
	
	/**
	 * 菜单类型：1-菜单；2-按钮
	 */
	private Integer menuType;
	
	/**
	 * 菜单排序，降序排列，例：6,5,4,3,2,1
	 */
	private Integer menuOrder;
	
	private Integer oldParentId;
	/**
	 * 菜单子节点
	 */
	private List<Menu> children;

	public Menu() {}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
	public String getIconUrl() {
		return iconUrl;
	}

	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl;
	}

	public String getMenuUrl() {
		return menuUrl;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public Integer getOldParentId() {
		return oldParentId;
	}

	public void setOldParentId(Integer oldParentId) {
		this.oldParentId = oldParentId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(Integer menuLevel) {
		this.menuLevel = menuLevel;
	}

	public Integer getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(Integer isLeaf) {
		this.isLeaf = isLeaf;
	}

	public Integer getMenuType() {
		return menuType;
	}

	public void setMenuType(Integer menuType) {
		this.menuType = menuType;
	}

	public Integer getMenuOrder() {
		return menuOrder;
	}

	public void setMenuOrder(Integer menuOrder) {
		this.menuOrder = menuOrder;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

}
