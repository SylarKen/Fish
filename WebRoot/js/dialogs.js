/**
 * 打开池塘选择对话框，池塘树
 * isSingleCheck 是否单选，整形，1是0否
 * checkedPonds 为已经选中的池塘编码，如多选（isSingleCheck=0）以逗号分隔
 * callback 为回调函数，回调函数的参数为选中的TreeNode节点，回调函数返回值：是否保持窗口，如果没有返回或者返回否，关闭窗口
 */
function showPondTreeDialog(isSingleCheck, checkedPonds,callback,deptCode) {
	var $PondSelectDialog = $("<div></div>");
	var url = deptCode?(webContext + "production/pondTreeDialog?deptCode="+deptCode):(webContext + "production/pondTreeDialog");
	$PondSelectDialog.dialog({
		title : '选择池塘',
		width: 320,
        height: 600,
		closed : true,
		cache : false,
		href : url,
		modal : true,
		queryParams : {isSingleCheck : isSingleCheck, checkedPonds : checkedPonds},
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : function() {
				var checkedRows = $('#pond_tree_dialog_tree').treegrid("getChecked");
				if(checkedRows && checkedRows.length > 0){
					if(callback && typeof callback == "function"){
						var isKeepDialog = callback(checkedRows);//执行回调,返回是否保持窗口，如果没有返回或者返回否，关闭窗口
						if(!isKeepDialog){
							$PondSelectDialog.dialog('destroy');
						}
					}
				}else{
					$.messager.alert("温馨提示", "请至少选中一行！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$PondSelectDialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$PondSelectDialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$PondSelectDialog.dialog('open');
}


/**
 * 打开产品选择对话框
 * 参数为回调函数，回调函数的参数为选中的TreeNode节点
 */
function showProductSelectDialog(callback) {
	var $productSelectDialog = $("<div></div>");
	$productSelectDialog.dialog({
		title : '选择产品',
		width: 600,
        height: 450,
		closed : true,
		cache : false,
		href : webContext + "product/select",
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var selectRow = $('#product_select_list').treegrid("getSelected");
				if(selectRow){
					if(callback && typeof callback == "function"){
						callback(selectRow);//执行回调
					}
					$productSelectDialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请选择一个产品！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$productSelectDialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$productSelectDialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$productSelectDialog.dialog('open');
}

/**
 * 打开部门选择对话框，支持多选
 * 参数为回调函数，回调函数的参数为选中的TreeNode节点
 */
function showDeptSelectDialog(deptLevel, callback) {
	var $deptSelectDialog = $("<div></div>");
	$deptSelectDialog.dialog({
		title : '选择部门',
		width: 600,
        height: 450,
		closed : true,
		cache : false,
		href : webContext + "dept/select?deptLevel=" + deptLevel,
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var selectRows = $('#dept_select_list').treegrid("getSelections");
				if(selectRows){
					if(callback && typeof callback == "function"){
						callback(selectRows);//执行回调
					}
					$deptSelectDialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请至少选择一行！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$deptSelectDialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$deptSelectDialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$deptSelectDialog.dialog('open');
}

function showBarcodePrintDialog(barcodes) {
	var $barcodePrintDialog = $("<div id='barcode_print_dialog'></div>");
	$barcodePrintDialog.dialog({
		title: '条码打印',
		width: 980,
		height: 670,
		closed: true,
		cache: false,
		href: webContext + "webpages/barcodePrintDialog.jsp?barcodes=" + barcodes,
		modal : true,
		buttons : [ {
			text : '打印',
			iconCls : 'icon-printer',
			handler : function() {
				$('#barcode_print_dialog').jqprint();
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$barcodePrintDialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$barcodePrintDialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$barcodePrintDialog.dialog('open');
}


//选择区域对话框
function showSelectAreaDialog(selectValue,callback) {
	var $select_area_dialog = $("<div></div>");
	$select_area_dialog.dialog({
		title : '选择行政区划',
		width : 360,
		height : 600,
		closed : true,
		cache : false,
		href : webContext + "area/selectAreaDialog?selectValue="+selectValue,
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var rows = $('#area_dialog_list').tree("getChecked");
				if( rows && rows.length==1 ){
					if(callback && typeof callback == "function"){
						callback(rows[0]);//执行回调
					}
					$select_area_dialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请选择一个行政区划！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$select_area_dialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$select_area_dialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$select_area_dialog.dialog('open');
}

//选择养殖点对话框
function showSelectPointDialog(areaCode,callback) {
	var $select_point_dialog = $("<div></div>");
	$select_point_dialog.dialog({
		title : '选择养殖点',
		width : 1000,
		height : 600,
		closed : true,
		cache : false,
		href : webContext + "collector/selectPointDialog?areaCode="+areaCode,
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var rows = $('#point_dialog_list').datagrid("getSelections");
				if( rows && rows.length==1 ){
					if(callback && typeof callback == "function"){
						callback(rows[0]);//执行回调
					}
					$select_point_dialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请选择一个行政区划！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$select_point_dialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$select_point_dialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$select_point_dialog.dialog('open');
}

//选择池塘对话框
function showSelectPondDialog(areaCode,callback) {
	var $select_pond_dialog = $("<div></div>");
	$select_pond_dialog.dialog({
		title : '选择池塘',
		width : 1000,
		height : 600,
		closed : true,
		cache : false,
		href : webContext + "device/selectPondDialog?areaCode="+areaCode,
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var rows = $('#pond_dialog_list').datagrid("getSelections");
				if( rows && rows.length==1 ){
					if(callback && typeof callback == "function"){
						callback(rows[0]);//执行回调
					}
					$select_pond_dialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请选择一个行政区划！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$select_pond_dialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$select_pond_dialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$select_pond_dialog.dialog('open');
}

//选择采集器对话框
function showSelectCollectorDialog(pointCode,callback) {
	var $select_collector_dialog = $("<div></div>");
	$select_collector_dialog.dialog({
		title : '选择采集器',
		width : 1000,
		height : 600,
		closed : true,
		cache : false,
		href : webContext + "device/selectCollectorDialog?pointCode="+pointCode,
		modal : true,
		buttons : [ {
			text : '选择',
			iconCls : 'icon-ok',
			handler : function() {
				var rows = $('#collector_dialog_list').datagrid("getSelections");
				if( rows && rows.length==1 ){
					if(callback && typeof callback == "function"){
						callback(rows[0]);//执行回调
					}
					$select_collector_dialog.dialog('destroy');
				}else{
					$.messager.alert("温馨提示", "请选择一个行政区划！");
					return;
				}
			}
		}, {
			text : '取消',
			iconCls : 'icon-cancel',
			handler : function() {
				$select_collector_dialog.dialog('destroy');
			}
		} ],
		onClose : function() {
			$select_collector_dialog.dialog('destroy');
		}
	});
	//初始化后打开对话框
	$select_collector_dialog.dialog('open');
}
