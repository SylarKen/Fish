<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>渔业综合服务平台</title>
        <jsp:include page="/common.jsp"></jsp:include>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="运营人员管理">
    </head>
    <body>
        <div class="easyui-layout" style="width:100%;" fit="true">
            <div data-options="region:'north'" style="height:50px;">
                <form id="collector_search_form" style="padding:11 0 0 10;font-size:13px;">
                    <span>设备编号：</span><input class="easyui-textbox" name="collectorCode"/>&nbsp;
                    <span>池塘编号：</span><input class="easyui-textbox" name="deptCode"/>&nbsp;
                    <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
                       onclick="search_load('collector_list', 'collector_search_form')">查询</a>
                </form>
            </div>
            <div data-options="region:'center'" style="background:#eee;">
                <div id="collector_list"></div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                $('#collector_list').datagrid({
                    url: '<%=basePath%>collectorNewGateway/query',
                    fit: true,
                    fitColumns: true,
                    nowrap: true,
                    idField: 'collectorCode',
                    striped: true, // 奇偶行是否区分
                    singleSelect: true,// 单选模式
                    rownumbers: true,// 行号
                    pagination: true,
                    pageSize: 20, // 每一页多少条数据
                    pageList: [10, 20, 30, 40, 50], // 可以选择的每页的大小的combobox
                    sortName: 'collectorCode',
                    columns: [[
                        {field: 'ck', checkbox: true},
                        {field: 'collectorCode', title: '编号', width: 100},
                        {field: 'collectorId', title: '序列号', width: 100},
                        {field: 'collectorName', title: '名称', width: 100},
                        // {field: 'pointCode', title: '养殖点编号', width: 100},
                        // {field: 'pointName', title: '养殖点名称', width: 100},
                        {field: 'deptCode', title: '池塘编号', width: 100},
                        {field: 'deptName', title: '池塘名称', width: 100},
                        {field: 'buyDate', title: '购买时间', width: 100, formatter: dateFormatter},
                        {field: 'expiringDate', title: '服务到期时间', width: 100, formatter: dateFormatter},
                        {field: 'effectiveDate', title: '生效时间', width: 100, formatter: dateFormatter},
                        {
                            field: 'delete_flag', title: '是否可用', sortable: true, width: 80,
                            formatter: function (value, row) {
                                if (value == false) return '<span>是</span>';
                                if (value == true) return '<span>否</span>';
                            }
                        },
                        {
                            field: 'runMode', title: '运行模式', sortable: true, width: 40,
                            formatter: function (value, row) {
                                if (value == "0")
                                    return '<button id="changemode" type="button" onclick="changemode(\'' + row.collectorId + '\')">自动</button>';
                                if (value == "a")
                                    return '<button id="changemode" type="button" onclick="changemode(\'' + row.collectorId + '\')">手动</button>';
                            }
                        },
                        {
                            field: 'db', title: '操作', sortable: true, width: 50,
                            formatter: function (val, row) {
                                if (row.runMode == "0" && row.db == "0")
                                    return '<a href="javascript:void(0)" onclick="manualopen(\'' + row.collectorId
                                        + '\')">开启</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                                        '<a href="javascript:return false;" onclick="return false;' +
                                        '"><i class="edit" style="opacity: 0.2">关闭</i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                                if (row.runMode == "0" && row.db == "1")
                                    return '<a href="javascript:return false;" onclick="return false;' +
                                        '"><i class="edit" style="opacity: 0.2">开启</i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                                        '<a href="javascript:void(0)" onclick="manualclose(\'' + row.collectorId
                                        + '\')">关闭</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                                if (row.runMode == "a")
                                    return '<a href="javascript:return false;" onclick="return false;' +
                                        '"><i class="edit" style="opacity: 0.2">开启</i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
                                        '<a href="javascript:return false;" onclick="return false;' +
                                        '"><i class="edit" style="opacity: 0.2">关闭</i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                            }
                        }
                    ]],
                    toolbar: [{
                        text: '新增',
                        url: 'collectorNewGateway/add',
                        iconCls: 'icon-add',
                        handler: opencollectorAddDialog
                    }, {
                        text: '编辑',
                        url: 'collectorNewGateway/edit',
                        iconCls: 'icon-edit',
                        handler: function () {
                            var selectedRow = $('#collector_list').datagrid('getSelected');
                            if (selectedRow == null) {
                                $.messager.alert("温馨提示", "请先选择一行！");
                                return;
                            }
                            opencollectorEditDialog(selectedRow.collectorCode);
                        }
                    }, {
                        text: '设定上下限',
                        url: 'collectorNewGateway/threshold',
                        iconCls: 'icon-hold',
                        handler: function () {
                            var selectedRow = $('#collector_list').datagrid('getSelected');
                            if (selectedRow == null) {
                                $.messager.alert("温馨提示", "请先选择一行！");
                                return;
                            }
                            opencollectorthresholdDialog(selectedRow.collectorCode);
                        }
                    }]
                });
                actionButtonCtr('collector_list');
            });

            function opencollectorAddDialog() {
                var $dialog = $("<div id='collectorNewGate_add_dialog'></div>");
                $dialog.dialog({
                    href: '<%=basePath%>collectorNewGateway/collectorNewGate_add',
                    title: '新增采集器',
                    width: 470,
                    height: 430,
                    closed: true,
                    cache: false,
                    modal: true,
                    buttons: [{
                        text: '确定',
                        iconCls: 'icon-ok',
                        handler: function () {
                            submitForm('collectorNewGate_add_form', 'collectorNewGate_add_dialog', 'collector_list', 'collector_search_form', this);
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $dialog.dialog('close');
                        }
                    }],
                    onClose: function () {
                        $dialog.dialog('destroy');
                    }
                });
                $dialog.dialog('open');
            }

            function opencollectorEditDialog(code) {
                var $dialog = $("<div id='collectorNewGate_edit_dialog'></div>");
                $dialog.dialog({
                    href: '<%=basePath%>collectorNewGateway/collectorNewGate_edit?code=' + code,
                    title: '编辑采集器',
                    width: 470,
                    height: 510,
                    closed: true,
                    cache: false,
                    modal: true,
                    buttons: [{
                        text: '确定',
                        iconCls: 'icon-ok',
                        handler: function () {
                            submitForm('collectorNewGate_edit_form', 'collectorNewGate_edit_dialog', 'collector_list', 'collector_search_form', this);
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $dialog.dialog('close');
                        }
                    }],
                    onClose: function () {
                        $dialog.dialog('destroy');
                    }
                });
                $dialog.dialog('open');
            }

            function opencollectorthresholdDialog(code) {
                var $dialog = $("<div id='collectorNewGate_threshold_dialog'></div>");
                $dialog.dialog({
                    href: '<%=basePath%>collectorNewGateway/collectorNewGate_threshold?code=' + code,
                    title: '设定采集器上下限',
                    width: 470,
                    height: 510,
                    closed: true,
                    cache: false,
                    modal: true,
                    buttons: [{
                        text: '确定',
                        iconCls: 'icon-ok',
                        handler: function () {
                            console.log(this);
                            debugger;
                            $.post(CTRL_COLLECTOR_ADDRESS + "/setYcThreshold", {
                                threshold_on: $("#collectorNewGateway_threshold_on").val(),
                                threshold_off: $("#collectorNewGateway_threshold_off").val()
                            }, function (data) {
                            });
                            submitForm('collectorNewGate_threshold_form', 'collectorNewGate_threshold_dialog', 'collector_list', 'collector_search_form', this);
                        }
                    }, {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            $dialog.dialog('close');
                        }
                    }],
                    onClose: function () {
                        $dialog.dialog('destroy');
                    }
                });
                $dialog.dialog('open');
            }

            function changemode(ICCID) {
                // alert(ICCID);
                debugger;
                $.ajax({
                    url: webContext + "/collectorNewGateway/collectorNewGate_changeAuto",
                    type: 'POST',
                    async: false,
                    dataType: 'json',
                    data: {collectorId: ICCID},//传参
                    // jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
                    //jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
                    // timeout: 10000,
                    success: function (data) {
                        // alert(data.mode);
                        if (data.ok) {
                            $.post(CTRL_COLLECTOR_ADDRESS + "/setRunMode", {
                                ICCID: ICCID,
                                mode: data.mode
                            }, function (data) {
                            });
                            if (data.mode == "0") {
                                $.messager.alert("温馨提示", "成功切换为手动模式！");
                            } else {
                                $.messager.alert("温馨提示", "成功切换为自动模式！");
                            }
                            $('#collector_list').datagrid('reload');
                        } else {
                            $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
                    }
                });
            }

            function manualopen(ICCID) {

                $.ajax({
                    url: webContext + "/collectorNewGateway/collectorNewGate_manualOpen",
                    type: 'POST',
                    async: false,
                    dataType: 'json',
                    data: {collectorId: ICCID},//传参
                    success: function (data) {
                        if (data.ok) {
                            $.post(CTRL_COLLECTOR_ADDRESS + "/setOnOff", {ICCID: ICCID, o: data.o}, function (data) {
                            });
                            $.messager.alert("温馨提示", "手动模式开启成功！");
                            $('#collector_list').datagrid('reload');
                        } else {
                            $.messager.alert("温馨提示", "手动模式开启失败！" + data.errorMsg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert("温馨提示", "网络访问出错！");
                    }
                });
            }

            function manualclose(ICCID) {

                $.ajax({
                    url: webContext + "/collectorNewGateway/collectorNewGate_manualClose",
                    type: 'POST',
                    async: false,
                    dataType: 'json',
                    data: {collectorId: ICCID},//传参
                    // jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
                    //jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
                    // timeout: 10000,
                    success: function (data) {
                        if (data.ok) {
                            $.post(CTRL_COLLECTOR_ADDRESS + "/setOnOff", {ICCID: ICCID, o: data.o}, function (data) {
                            });
                            $.messager.alert("温馨提示", "手动模式关闭成功！");
                            $('#collector_list').datagrid('reload');
                        } else {
                            $.messager.alert("温馨提示", "手动模式关闭失败！" + data.errorMsg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
                    }
                });
            }

            //设置遥测 打开/关闭 临界点
            // function set_critical_point(threshold_on, threshold_off) {
            //
            //     $.ajax({
            //         url: CTRL_COLLECTOR_ADDRESS + "/setYcThreshold",
            //         type: 'POST',
            //         async: true,
            //         dataType: 'jsonp',
            //         data: {threshold_on: threshold_on, threshold_off: threshold_off}, //传参
            //         jsonp: "jsonpParam", //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
            //         jsonpCallback: 'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
            //         timeout: CTROL_DEVICE_INTERVAL,//控制设备AJAX的间隔时间
            //         success: function (data) {
            //             if (data.ok) {
            //                 $.messager.alert("温馨提示", "操作成功！");
            //             } else {
            //                 $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
            //             }
            //         },
            //         error: function (data) {
            //             $.messager.alert("温馨提示", "网络访问出错！");
            //         }
            //     });
            // }

            // //设置运行模式
            // function set_runmode(ICCID, mode){
            //
            // 	$.ajax({
            // 		url: CTRL_COLLECTOR_ADDRESS + "/setRunMode",
            // 		type:'POST',
            // 		async: true,
            // 		dataType:'jsonp',
            // 		data: { ICCID : ICCID, mode : mode }, //传参
            // 		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
            // 		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
            // 		timeout: CTROL_DEVICE_INTERVAL,//控制设备AJAX的间隔时间
            // 		success:function(data){
            // 			if(data.ok){
            // 				$.messager.alert("温馨提示", "操作成功！");
            // 			}else{
            // 				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
            // 			}
            // 		},
            // 		error:function(data){
            // 			$.messager.alert("温馨提示", "网络访问出错！");
            // 		}
            // 	});
            // }
            //
            // //手动模式开关
            // function set_manual_switch(ICCID, o){
            //
            // 	$.ajax({
            // 		url: CTRL_COLLECTOR_ADDRESS + "/setOnOff",
            // 		type:'POST',
            // 		async: true,
            // 		dataType:'jsonp',
            // 		data: { ICCID : ICCID, o : o }, //传参
            // 		jsonp: "jsonpParam" , //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
            // 		jsonpCallback:'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
            // 		timeout: CTROL_DEVICE_INTERVAL,//控制设备AJAX的间隔时间
            // 		success:function(data){
            // 			if(data.ok){
            // 				$.messager.alert("温馨提示", "操作成功！");
            // 			}else{
            // 				$.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
            // 			}
            // 		},
            // 		error:function(data){
            // 			$.messager.alert("温馨提示", "网络访问出错！");
            // 		}
            // 	});
            // }

        </script>
    </body>
</html>
