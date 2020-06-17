package com.domor.model;

/***
 * 数据查询的条件以及easyui表格插件分页参数的封装类
 * 
 * @author Administrator
 */
public class SearchDomain {

	// 以下是页面传递给后台的条件参数
	private String key1;
	private String key2;
	private String key3;
	private String key4;
	private String key5;
	private String key11;
	private String key12;
	private String key13;
	private String key14;
	private String key15;

	private Integer key6;
	private Integer key7;
	private Integer key8;
	private Integer key9;
	private Integer key10;

	public String getKey11() {
		return key11;
	}

	public void setKey11(String key11) {
		this.key11 = key11;
	}

	public String getKey12() {
		return key12;
	}

	public void setKey12(String key12) {
		this.key12 = key12;
	}

	public String getKey13() {
		return key13;
	}

	public void setKey13(String key13) {
		this.key13 = key13;
	}

	public String getKey14() {
		return key14;
	}

	public void setKey14(String key14) {
		this.key14 = key14;
	}

	public String getKey15() {
		return key15;
	}

	public void setKey15(String key15) {
		this.key15 = key15;
	}

	public Integer getKey6() {
		return key6;
	}

	public void setKey6(Integer key6) {
		this.key6 = key6;
	}

	public Integer getKey7() {
		return key7;
	}

	public void setKey7(Integer key7) {
		this.key7 = key7;
	}

	public Integer getKey8() {
		return key8;
	}

	public void setKey8(Integer key8) {
		this.key8 = key8;
	}

	public Integer getKey9() {
		return key9;
	}

	public void setKey9(Integer key9) {
		this.key9 = key9;
	}

	public Integer getKey10() {
		return key10;
	}

	public void setKey10(Integer key10) {
		this.key10 = key10;
	}

	public String getKey1() {
		return key1;
	}

	public void setKey1(String key1) {
		this.key1 = key1;
	}

	public String getKey2() {
		return key2;
	}

	public void setKey2(String key2) {
		this.key2 = key2;
	}

	public String getKey3() {
		return key3;
	}

	public void setKey3(String key3) {
		this.key3 = key3;
	}

	public String getKey4() {
		return key4;
	}

	public void setKey4(String key4) {
		this.key4 = key4;
	}

	public String getKey5() {
		return key5;
	}

	public void setKey5(String key5) {
		this.key5 = key5;
	}

	private int rows; // 每页记录数
	private int page; // 当前页码
	private int skipCount; // 跳过的记录数 也就是数据库中分页时用到 limit skipCount,pageSize
	private String sort; // 排序字段名
	private String order; // 排序规则 desc asc

	public int getSkipCount() {
		return this.skipCount;
	}

	public void setSkipCount(int total) {
		this.skipCount = rows * (page - 1) > total ? 0 : rows * (page - 1);
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

}
