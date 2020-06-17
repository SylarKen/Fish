package com.domor.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 实体类父类
 */
public class Entity implements Serializable {

	private static final long serialVersionUID = 280326368765543614L;
	
	/**
	 * 创建人 username
	 */
	private String creator;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 编辑人 username
	 */
	private String editor;
	
	/**
	 * 编辑时间
	 */
	private Date editTime;
	
	/**
	 * 删除标识：0-可用；1-已删除
	 */
	private Integer delete_flag = 0;
	
	public Entity() {}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getEditor() {
		return editor;
	}

	public void setEditor(String editor) {
		this.editor = editor;
	}

	public Date getEditTime() {
		return editTime;
	}

	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}

	public Integer getDelete_flag() {
		return delete_flag;
	}

	public void setDelete_flag(Integer delete_flag) {
		this.delete_flag = delete_flag;
	}

}
