package com.domor.model;

/**
 * 角色
 * 
 */
public class Role extends Entity {

	private static final long serialVersionUID = 3253995427336124166L;
	
//	public final static int AMDIN = 1;// 管理员
//	public final static int SALER = 2;// 内勤
//	public final static int CASHIER = 3;// 财务
//	public final static int DRAWER = 4;// 开票员

	private Integer roleId;
	private String roleName;
	private Integer delete_flag = 0;

//	private Integer roleType = -1;

	public Role() {}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getDelete_flag() {
		return delete_flag;
	}

	public void setDelete_flag(Integer delete_flag) {
		this.delete_flag = delete_flag;
	}

//	public Integer getRoleType() {
//		return roleType;
//	}
//
//	public void setRoleType(Integer roleType) {
//		this.roleType = roleType;
//	}
}
