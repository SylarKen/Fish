package com.domor.model;

/**
 * 数据字典
 * @author wgc
 *
 */
public class DataDictionary extends Entity {
	
	private static final long serialVersionUID = -7240318781426079179L;

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 类型
	 */
	private String type;

	/**
	 * 编号
	 */
	private String code;

	/**
	 * 数据
	 */
	private String content;

	/**
	 * 备注
	 */
	private String memo;
	
	public DataDictionary() {}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}


}
