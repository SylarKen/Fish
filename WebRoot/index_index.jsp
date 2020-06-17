<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <base href="<%=basePath%>">
        <title></title>
        <script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
    </head>
    <body>
        <style>
            .wrapperDiv {
                position: relative;
                vertical-align: top;
                width: 200px;
                height: 95px;
                margin: 10px 0 0 10px;
                display: inline-block;
                color: #FFF;
                border-radius: 5px;
                text-align: center;
            }

            .titleDiv {
                padding-top: 10px;
                height: 35px;
            }

            .dataDiv {
                background: rgba(0, 0, 0, .3);
                padding: 5px;
                border-radius: 5px;
                font-size: 16px;
                width: 170px;
                margin: 10px auto;
            }

            .dataDiv > div {
                white-space: nowrap;
            }

            .pondDeviceDiv {
                position: absolute;
                z-index: 100;
                border-radius: 5px;
                background: #d9534f;
                width: 100%;
            }

            .pondDeviceDiv .dataDiv div {
                text-align: left;
            }

            .pondDeviceDiv .dataDiv span {
                display: inline-block;
                width: 35px;
                padding-right: 60px;
                text-align: center;
                vertical-align: middle;
            }

            .pondDeviceDiv .dataDiv b {
                vertical-align: middle;
                font-size: 20px;
            }

            .pondDeviceDiv .dataDiv {
                height: 20px;
                overflow: hidden;
            }

            .pondDeviceDiv .dataDiv:hover {
                height: auto;
                max-height: 200px;
                overflow-y: auto;
            }

            .pondDeviceDiv .dataDiv div {
                margin-bottom: 5px;
            }

            #index1_pondOxyg {
                background: #5cb85c;
            }

            #index1_pondPhvalue {
                background: #0000FF;
            }

            #index1_weather {
                background: #5bc0de;
            }

            #index1_weather img {
                vertical-align: middle;
                width: 40px;
            }

            #index1_weather .titleDiv span {
                font-size: 25px;
                padding-left: 10px;
                vertical-align: middle;
            }

            #index1_weather .dataDiv b {
                padding-left: 10px;
            }


            .index1_hr {
                height: 1px;
                border: none;
                border-top: 1px dashed #3BAAE3;
                margin: 10px 0;
            }

            #index1_video {
                width: 100%;
                height: 50%;
            }

            #index1_video #dvplay {
                margin-left: 10px;
                margin-top: 10px;
            }

            #index1_devieCtrl {
                width: 100%;
                height: 48%;
                overflow-x: hidden;
                overflow-y: auto;
            }

            #index1_devieCtrl table {
                margin-left: 10px;
                border: none;
                border-collapse: collapse;
            }

            #index1_devieCtrl table tr th {
                border: #7AB9FE 1px solid;
                padding: 10px;
                line-height: 20px;
                text-align: center;
                vertical-align: middle;
                color: #FFF;
                background: #3baae3;
                font-weight: bold;
            }

            #index1_devieCtrl table tr td {
                border: 1px solid #7AB9FE;
                padding: 6px;
            }

            #index1_devieCtrl table tr td.swicthBtn {
                text-align: center;
                cursor: pointer;
            }

            #index1_devieCtrl table tr td.swicthBtn:hover {
                color: white;
                background-color: #5bc0de;
            }
        </style>
        <div class="easyui-layout" data-options="fit:true">
            <input type="hidden" id="index1_pondCode"/>
            <div id="index1_west" data-options="region:'west'" style="width:655px;">
                <!-- 天气 -->
                <!-- 	<div id="index1_weather" class="wrapperDiv">
                        <div class="titleDiv">
                            <img /><span></span>
                        </div>
                        <div class="dataDiv">
                            <span></span><b></b>
                        </div>
                    </div> -->
                <!-- 池塘温度 -->
                <div class="wrapperDiv">
                    <div id="index1_pondTemp" class="pondDeviceDiv">
                        <div class="titleDiv">
                            <i style="font-size:25px;padding-right:10px;" class="fa fa-thermometer-3"></i>
                            <span style="font-size:25px;">温度</span>
                        </div>
                        <div class="dataDiv"></div>
                    </div>
                </div>
                <!-- 池塘溶氧度 -->
                <div class="wrapperDiv">
                    <div id="index1_pondOxyg" class="pondDeviceDiv">
                        <div class="titleDiv">
                            <i style="font-size:25px;padding-right:10px;" class="fa fa-flask"></i>
                            <span style="font-size:25px;">溶氧度</span>
                        </div>
                        <div class="dataDiv"></div>
                    </div>
                </div>
                <!-- 池塘PH值 -->
                <div class="wrapperDiv">
                    <div id="index1_pondPhvalue" class="pondDeviceDiv">
                        <div class="titleDiv">
                            <i style="font-size:25px;padding-right:10px;" class="fa fa-eyedropper"></i>
                            <span style="font-size:25px;">PH值</span>
                        </div>
                        <div class="dataDiv"></div>
                    </div>
                </div>
                <hr class="index1_hr">
                <div id="index1_map" style="width:100%;height:200px;"></div>
            </div>
            <div data-options="region:'center',onResize:function(a,b){resizeDiv();}" style="overflow:hidden;">
                <!-- 实时视频 -->
                <div id="index1_video">
                    <div id="myChart" style="width: 600px;height:400px;"></div>
                    <%--                    <div id="dvplay"></div>--%>
                </div>
                <hr class="index1_hr">
                <!-- 设备控制列表 -->
                <div id="index1_devieCtrl">
                    <table>
                        <thead>
                        <tr style="height:40px;">
                            <th style="width:20%;">设备名称</th>
                            <th style="width:10%;">打开值</th>
                            <th style="width:10%;">关闭值</th>
                            <th style="width:10%;">设定</br>上下限</th>
                            <th style="width:20%;">运行模式</th>
                            <th style="width:10%;">工作状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div data-options="region:'east'" title="池塘列表" style="width:250px">
                <table id="index1_pond_tree"></table>
            </div>
        </div>

        <script type="text/javascript" src="<%=basePath%>js/videocfg/cyberplayer.js"></script>
        <script type="text/javascript" src="<%=basePath%>js/bmap.js"></script>
        <script type="text/javascript">
            if (index1_pondDeviceInterval) {
                clearInterval(index1_pondDeviceInterval);
            }
            if (index1_mapInterval) {
                clearInterval(index1_mapInterval);
            }
            var index1_mapInterval = null;
            var index1_pondDeviceInterval = null;
            var index1_player = null;
            var index1_map = null;
            $(function () {
                //百度地图API功能
                index1_map = new BMap.Map('index1_map');    // 创建Map实例
                index1_map.centerAndZoom(new BMap.Point(116.59, 35.38), 11);  // 初始化地图,设置中心点坐标和地图级别
                index1_map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
                index1_map.setCurrentCity('济宁');          // 设置地图显示的城市 此项是必须设置的
                index1_map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
                //右侧树
                var index1_yzdAreaId = "";//养殖点所在的区县编码
                $('#index1_pond_tree').treegrid({
                    url: webContext + 'production/getUserPondTree',
                    checkbox: true,
                    fit: true,
                    nowrap: true,
                    collapsible: true,
                    pagination: false,
                    autoRowHeight: false,
                    idField: "code",
                    treeField: "name",
                    columns: [[
                        {field: 'code', title: '编码', width: 70},
                        {
                            field: 'name', title: '名称', width: 150
                        }]],
                    onSelect: function (node) {
                        var pondCode = node.code;
                        if (pondCode.length < 7) {
                            $(this).treegrid("unselect", pondCode);
                            return;
                        }
                        //查询天气，如果换了养殖点的话（区域发生变化）
                        var yzd = $(this).treegrid("find", pondCode.slice(0, 5));
                        if (index1_yzdAreaId != yzd.areaId) {
                            index1_yzdAreaId = yzd.areaId;
                            //更换地图中心点
                            var point = new BMap.Point(yzd.lng, yzd.lat);
                            index1_map.centerAndZoom(point, 15);
                            //更换天气
                            $.post(webContext + "index1/getWeatherInfo", {
                                xianId: yzd.areaId,
                                xianName: yzd.areaName
                            }, function (data) {
                                var weather = data.weatherinfo;
                                $("#index1_weather .titleDiv img").attr("src", "http://m.weather.com.cn/img/" + weather.img2.replace("d", "b"));
                                $("#index1_weather .titleDiv span").text(weather.weather);
                                $("#index1_weather .dataDiv span").text(weather.city);
                                $("#index1_weather .dataDiv b").text(weather.temp1 + "~" + weather.temp2);
                            }, "json");
                        }
                        //换了池塘
                        var oldPondCode = $("#index1_pondCode").val();
                        if (oldPondCode != pondCode) {
                            // initPlayer();
                            $("#index1_pondCode").val(pondCode);
                            if (index1_pondDeviceInterval) {
                                clearInterval(index1_pondDeviceInterval);
                            }
                            index1_queryDevice();

                            index1_pondDeviceInterval = setInterval(function () {
                                if ($("#index1_pondCode").length == 0) {//如果首页被关闭了，那么停止查询
                                    clearInterval(index1_pondDeviceInterval);
                                    return;
                                }
                                index1_queryDevice();
                            }, QUERY_DEVICE_INTERVAL);
                        }
                    },
                    onLoadSuccess: function (row, data) {
                        if (data && data.length > 0) {
                            var firstCode = data[0].firstPondCode;
                            firstCode && ($(this).treegrid("select", firstCode));
                            //找到树的养殖点节点，在地图上显示
                            for (var i = 0; i < data.length; i++) {
                                var cy = data[i].children;
                                if (cy && cy.length > 0) {
                                    for (var j = 0; j < cy.length; j++) {
                                        var d = cy[j];
                                        if (d.lng && d.lat) {
                                            var point = new BMap.Point(d.lng, d.lat);
                                            var marker = new BMap.Marker(point);
                                            var content = "<span style='color:blue;font-weight:bold;font-size:13px;'>" + d.name + "</span><br>所在区县：<span>"
                                                + d.areaName + "</span>";
                                            index1_map.addOverlay(marker);
                                            index1_addClickHandler(content, marker);
                                        }
                                    }
                                }
                            }
                        }
                    }
                });

                setTimeout(function () {
                    resizeDiv();//调整宽高自适应
                }, 600);
            });

            function index1_addClickHandler(content, marker) {
                marker.addEventListener("click", function (e) {
                    index1_openInfo(content, e);
                });
            }

            function index1_openInfo(content, e) {
                var p = e.target;
                var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
                var infoWindow = new BMap.InfoWindow(content);  // 创建信息窗口对象
                index1_map.openInfoWindow(infoWindow, point); //开启信息窗口
            }

            //查询池塘传感器
            function index1_queryDevice() {
                var pondCode = $("#index1_pondCode").val();
                $(".pondDeviceDiv .dataDiv").empty().append('<i>暂无数据</i>');//清空顶部彩色卡数据
                $("#index1_devieCtrl table tbody tr").remove();//清空底部设备数据
                $("#index1_devieCtrl table tbody").append("<tr><td colspan=7 style='text-align:center;'><i>暂无数据~</i></td></tr>");
                ;
                $.post(webContext + "index1/getDeviceValue", {pondCode: pondCode}, function (data) {
                    if (data.ok) {
                        var list = data.list;
                        var oxygHtml = "";
                        var tempHtml = "";
                        var phHtml = "";
                        var ctrlHtml = "";
                        for (var i = 0; i < list.length; i++) {
                            var bean = list[i];
                            //溶氧传感器
                            // if(bean.typeCode == LXBH_CGQ_RYWD)
                            {
                                oxygHtml = oxygHtml + '<div style="text-align:center;">' + (bean.o2 !== undefined ? (Math.round(bean.o2 * 10) / 10) + 'mg/L' : "未知") + '</b></div>';
                                tempHtml = tempHtml + '<div style="text-align:center;">' + (bean.temp0 !== undefined ? (Math.round(bean.temp0 * 10) / 10) + '℃' : "未知") + '</b></div>';
                                phHtml = phHtml + '<div style="text-align:center;">' + (bean.ph !== undefined ? (Math.round(bean.ph * 10) / 10) : "未知") + '</b></div>';
                            }
                            //设备控制列表：增氧机、投饵机
                            // else if(bean.typeCode == LXBH_KZQ_ZY || bean.typeCode == LXBH_KZQ_TE)
                            {
                                var status = Number(bean.status);
                                ctrlHtml = ctrlHtml + '<tr deviceId=' + bean.collectorId + '><td>' + bean.collectorName + '</td>'
                                    + '<td>' + (bean.threshold_on !== undefined ? (bean.threshold_on) : "未定义") + '</td>'
                                    + '<td>' + (bean.threshold_off !== undefined ? (bean.threshold_off) : "未定义") + '</td>'
                                    + index1_setthreshold(bean.collectorCode.toString())
                                    + index1_getModeBtn(bean.collectorId.toString(), bean.runMode)
                                    + '<td style="text-align:center;">' + index1_getStatusText(bean.db)
                                    + '</td>' + index1_getSwitchBtn(bean.collectorId.toString(), bean.db) + '</tr>';
                            }
                        }
                        if (list[0].collectorId) {
                            GetChart(list[0].collectorId);
                        }
                        if (oxygHtml) {
                            $("#index1_pondOxyg .dataDiv").empty().append(oxygHtml);
                        }
                        if (tempHtml) {
                            $("#index1_pondTemp .dataDiv").empty().append(tempHtml);
                        }
                        if (phHtml) {
                            $("#index1_pondPhvalue .dataDiv").empty().append(phHtml);
                        }
                        if (ctrlHtml) {
                            $("#index1_devieCtrl table tbody tr").remove();
                            $("#index1_devieCtrl table tbody").append(ctrlHtml);
                        }
                    }
                }, "json");
            }

            //根据状态获得切换运行模式按钮
            function index1_getModeBtn(ICCID, status) {
                var text = "";
                switch (status) {
                    case '0' :
                        text = '<td class="swicthBtn" onclick="changemode(\'' + ICCID + '\')"><i style="color:red;"   class=" fa fa-arrow-circle-down">手动-->自动</i></td>';
                        break;
                    case 'a' :
                        text = '<td class="swicthBtn" onclick="changemode(\'' + ICCID + '\')"><i style="color:green;" class=" fa fa-arrow-circle-up">自动-->手动</i></td>';
                        break;
                }
                return text;
            }

            //根据状态获得控制按钮
            function index1_getSwitchBtn(ICCID, status) {
                var text = '<td class="swicthBtn" onclick="manualopen(\'' + ICCID + '\')"><i style="color:green;"   class=" fa fa-arrow-circle-down">开启</i></td>';
                switch (status) {
                    case "0" :
                        text = '<td class="swicthBtn" onclick="manualopen(\'' + ICCID + '\')"><i style="color:green;"   class=" fa fa-arrow-circle-down">开启</i></td>';
                        break;
                    case "1" :
                        text = '<td class="swicthBtn" onclick="manualclose(\'' + ICCID + '\')"><i style="color:red;" class=" fa fa-arrow-circle-up">关闭</i></td>';
                        break;
                }
                return text;
            }

            //改变设备状态
            function index1_swicth(dom, statusTo) {
                var cursor = $(dom).css("cursor");
                if (cursor == "not-allowed") {
                    return;
                }
                $(dom).css("cursor", "not-allowed");
                var deviceId = $(dom).parent().attr("deviceId");
                if (!deviceId) {
                    $.messager.alert("温馨提示", "设备编号为空！");
                    $(dom).css("cursor", "pointer");
                    return;
                }

                $.ajax({
                    url: CTRL_SERVER_ADDRESS + "/SWITCH_STATUS",
                    type: 'get',
                    async: true,
                    dataType: 'jsonp',
                    data: {deviceId: deviceId, statusTo: statusTo}, //传参
                    jsonp: "jsonpParam", //服务器端获取回调函数名(下边的jsonpCallback)的key，对应后台有$_GET['jsonpParam']='callBackfunc';
                    jsonpCallback: 'callBackfunc', //回调函数, 服务器段需要返回字符串'callbackfunc({"ok":true,"msg":"操作成功！"})'
                    timeout: CTROL_DEVICE_INTERVAL,//控制设备AJAX的间隔时间
                    success: function (data) {
                        $(dom).css("cursor", "pointer");
                        if (data.ok) {
                            $.messager.alert("温馨提示", "操作成功！");
                            index1_queryDevice();
                        } else {
                            $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert("温馨提示", "网络访问出错！");
                        $(dom).css("cursor", "pointer");
                    }
                });
            }

            //设备状态转文本
            function index1_getStatusText(status) {
                var text = "未知";
                switch (status) {
                    case "0" :
                        text = "<font color=green>关闭</font>";
                        break;
                    case "1" :
                        text = "<font color=red>开启</font>";
                        break;
                }
                return text;
            }

            //设置上限下限
            function index1_setthreshold(code) {
                var text = '<td class="setthreshold" style="color:blue" onclick="opencollectorthresholdDialog(\'' + code + '\')">编辑</td>';
                return text;
            }

            //视频实时显示
            function initPlayer() {
                index1_player = cyberplayer("dvplay").setup({
                    flashplayer: "js/videocfg/cyberplayer.flash.swf",
                    stretching: "uniform",
                    file: "rtmp://192.168.9.85:10035/live/stream_2" || "rtmp://121.40.50.44/live/stream_1",
                    image: "http://192.168.9.90:10080/snap/1/2016-12-08/20161208105432.jpg" || "/images/snap.png",
                    autostart: !1,
                    repeat: !1,
                    volume: 100,
                    controls: !0,
                    controlbar: {
                        barLogo: !1
                    },
                    ak: "515d61b893134f40bd4297b75a03494b"
                });

                resizeDiv();
            }

            //动态改变大小,自适应
            var lastResizeTime = new Date().getTime();//上次执行的时间
            function resizeDiv() {
                var nowTime = new Date().getTime();
                var tResize = nowTime - lastResizeTime;
                if (tResize <= 500) {//如果两次点击的时间间隔很短，那么不做任何反应
                    return false;
                }
                lastResizeTime = nowTime;
                var pHeight = $("#index1_video").height();
                var pWidth = $("#index1_video").width();
                $("#index1_devieCtrl").height(pHeight - 40);
                $("#index1_devieCtrl table").width(pWidth - 20);
                $("#index1_map").height($("#index1_west").height() - $("#index1_map").position().top - 10);
                $("#myChart").resize(pWidth - 20, pHeight);
            }

            // 操作网关
            function changemode(ICCID) {
                // alert(ICCID);
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
                            index1_queryDevice();
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
                            index1_queryDevice();
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
                            index1_queryDevice();
                        } else {
                            $.messager.alert("温馨提示", "手动模式关闭失败！" + data.errorMsg);
                        }
                    },
                    error: function (data) {
                        $.messager.alert("温馨提示", "操作失败！" + data.errorMsg);
                    }
                });
            }

            var myChart = echarts.init(document.getElementById('myChart'));
            myChart.setOption({
                title: {
                    text: '数据记录'
                },
                tooltip: {},
                legend: {
                    data: ['温度', '溶氧度', 'PH']
                },
                xAxis: {
                    data: [1, 2, 3, 4, 5, 6, 7, 8]
                },
                yAxis: [
                    {
                        type: 'value',
                        name: '温度',
                        min: 0,
                        max: 60,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} °C'
                        }
                    },
                    {
                        type: 'value',
                        name: '溶氧度',
                        min: 0,
                        max: 50,
                        // interval: 5,
                        inverse: true,
                        axisLabel: {
                            formatter: '{value}'
                        }
                    }
                    ,
                    {
                        type: 'value',
                        name: 'PH',
                        min: 0,
                        max: 14,
                        offset: 30,
                        interval: 7,
                        axisLabel: {
                            formatter: '{value}'
                        }
                    }
                ]
            });

            function GetChart(ICCID) {
                $.ajax({
                    url: webContext + "/collectorNewGateway/collectorNewGate_getDataList",
                    type: 'POST',
                    async: false,
                    dataType: 'json',
                    data: {collectorId: ICCID},//传参
                    success: function (data) {
                        if (data.ok) {
                            myChart.setOption({
                                xAxis: {
                                    data: data.xAxis,
                                    axisLabel: {
                                        formatter: function (value, index) {
                                            // 格式化成月/日，只在第一个刻度显示年份
                                            var date = new Date(value);
                                            var texts = [(date.getMonth() + 1), date.getDate()];
                                            if (index === 0) {
                                                texts.unshift(date.getYear());
                                            }
                                            return texts.join('/');
                                        }
                                    }
                                },
                                series: [
                                    {
                                        // 根据名字对应到相应的系列
                                        name: '温度',
                                        type: 'line',
                                        data: data.series_tmp
                                    },
                                    {
                                        name: '溶氧度',
                                        type: 'line',
                                        yAxisIndex: 1,
                                        data: data.series_o2
                                    },
                                    {
                                        name: 'PH',
                                        type: 'scatter',
                                        yAxisIndex: 2,
                                        data: data.series_ph,

                                    }
                                ]
                            });
                        } else {

                        }
                    },
                    error: function (data) {

                    }
                });


            }

            //定义采集器上下限
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
                            debugger;
                            console.log(this);
                            $.post(CTRL_COLLECTOR_ADDRESS + "/setYcThreshold", {
                                ICCID:$("#collectorNewGateway_threshold_id").val(),
                                threshold_on: $("#collectorNewGateway_threshold_on").val(),
                                threshold_off: $("#collectorNewGateway_threshold_off").val()
                            }, function (data) {
                            });
                            // $.post("http://192.168.9.20:50028" + "/setYcThreshold", {
                            //     ICCID:$("#collectorNewGateway_threshold_id").val(),
                            //     threshold_on: $("#collectorNewGateway_threshold_on").val(),
                            //     threshold_off: $("#collectorNewGateway_threshold_off").val()
                            // }, function (data) {
                            // });
                            submitForm('collectorNewGate_threshold_form', 'collectorNewGate_threshold_dialog', 'index1_devieCtrl', 'collector_search_form', this);
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
        </script>
    </body>
</html>
