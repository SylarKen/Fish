package com.domor.model;

import java.util.List;

/**
 * 行政区划
 * @author ThinkMan
 *
 */
public class Area {
	
	/**
	 * 主键
	 */
	private Integer id;
	
	/**
	 * 名称
	 */
	private String areaname;
	
	/**
	 * 上级区划 ID
	 */
	private Integer parentid;
	
	/**
	 * 简称
	 */
	private String shortname;
	
	/**
	 * 层级
	 */
	private Integer level;
	
	private double lng;
	
	private double lat;
	
	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	/**
	 * 区划节点状态，在数据库中无与之对应的字段
	 */
//	private String state;
	
	private List<Area> children;
	
	public Area() {}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAreaname() {
		return areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
//	public String getState() {
//		return state;
//	}
//	
//	public void setState(String state) {
//		this.state = state;
//	}
	
	public List<Area> getChildren() {
		return children;
	}
	
	public void setChildren(List<Area> children) {
		this.children = children;
	}

}
