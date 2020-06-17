package com.domor.model;

/***
 * 服务端返回数据给easyui表格插件的总记录数以及具体返回的数据的封装类
 * 
 * @author Administrator
 */
public class PagerReturns {
	private int total; // 总记录数
	private Object rows;// 返回给表格插件的数据
	private Object footer;
	
	public PagerReturns() {}
	
	public PagerReturns(Object rows, int total) {
		this.rows = rows;
		this.total = total;
	}
	
	public PagerReturns(Object rows, Object footer, int total) {
		this.rows = rows;
		this.footer = footer;
		this.total = total;
	}

	public Object getFooter() {
		return footer;
	}

	public void setFooter(Object footer) {
		this.footer = footer;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Object getRows() {
		return rows;
	}

	public void setRows(Object rows) {
		this.rows = rows;
	}

}
