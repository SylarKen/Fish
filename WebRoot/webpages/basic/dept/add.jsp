<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>绩效考核系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="新增部门">
</head>
<body>
 
<form id="dept_add_form" method="post" action='<%=basePath%>dept/insert'>
	<table style="padding:40px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">部门名称：</td>
			<td>
				<input id="dept_add_name" class="easyui-textbox" name="name" style="width:200px;" data-options="required:true">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">上级部门：</td>
			<td>
				<input id="dept_add_parent_name" value="${pname }" name="pname" style="width:200px;"  data-options="required:true">
				<input id="dept_add_parent_id" type="hidden" name="pcode" value="${pcode }"/>
				<input id="dept_add_level" type="hidden" name="pgrade" value="${pgrade }"/>
			</td>
		</tr> 
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">所在区划：</td>
			<td>
				<input id="dept_add_areaId" type="hidden" name="areaId"  style="width:200px;">
				<input id="dept_add_areaName"  name="areaName" value=""/>
				<input id="dept_add_area_lng" type="hidden" value=""/>
				<input id="dept_add_area_lat" type="hidden" value=""/>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">经纬度：</td>
			<td  id="dept_add_lat_td">
				<input id="dept_add_lat" style="width:200px;">
				<input id="dept_add_hidden_lng"  name="lng" type="hidden" />
				<input id="dept_add_hidden_lat"  name="lat" type="hidden" />
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">详细地址：</td>
			<td>
				<input id="dept_add_address" class="easyui-textbox" name="address" style="width:200px;" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">联系人：</td>
			<td>
				<input id="dept_add_linkman" class="easyui-textbox" name="linkman" style="width:200px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">联系电话：</td>
			<td>
				<input id="dept_add_phone" class="easyui-textbox" name="linkphone" 
					data-options="" style="width:200px;" validType="mobile">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">备注：</td>
			<td>
				<input class="easyui-textbox" data-options="multiline:true" id="dept_add_memo" name="memo"  style="width:200px;height:100px"></textarea>			
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript">
$(function() {
	 $('#dept_add_parent_name').combobox({
		url: '<%=basePath%>dept/getChildDepts', 
	    valueField:'code',    
	    textField:'name' ,
	    onSelect:function(record){
	    	$("#dept_add_parent_id").val(record.code);
	    	$("#dept_add_parent_name").val(record.name)
	    	$("#dept_add_level").val(record.grade);
	    }
	}); 
 

	$('#dept_add_lat').textbox({
	editable: false,
	width:200,
	buttonText:'查询',    
    iconAlign:'right',
    required:true,
    icons:[{
		iconCls:'icon-clear',
		handler: function(e){
			$(e.data.target).textbox('clear').textbox('textbox').focus();
		}
	}],
    onClickButton:function(){
          var $map = $("<div id='dept_add_map' style='height:450px;width:500px;border:1px solid #CCC;position:absolute;top:-80px;left:-80px;z-index:100'></div>")
          var $closeMap = $("<div id='dept_add_closemap' onclick=javascript:$('#dept_add_map').remove();$(this).remove() style='position:absolute;top:-75px;left:400px;z-index:101;color:red;font-size:20px;font-weight:bolder;cursor:pointer'>X</div>");
          $("#dept_add_lat_td").append($map);
          $("#dept_add_lat_td").append($closeMap);
          $("#dept_add_lat_td").css("position","relative");
		          // 百度地图API功能
			var map = new BMap.Map("dept_add_map");            // 创建Map实例
			var lng = $("#dept_add_area_lng").val();
			var lat =$("#dept_add_area_lat").val();
			
			if(!lng) lng = 116.587242;
			if(!lat) lat = 35.415394;
			
			map.centerAndZoom(new BMap.Point(lng,lat), 11);  // 初始化地图,设置中心点坐标和地图级别
			//map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
			//map.setCurrentCity("上海");          // 设置地图显示的城市 此项是必须设置的
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		 
			function showInfo(e){
				console.log(e)
				$('#dept_add_lat').textbox('setValue',e.point.lng + ", " + e.point.lat);
				$('#dept_add_hidden_lng').val(e.point.lng);
				$('#dept_add_hidden_lat').val(e.point.lat);
				var gc = new BMap.Geocoder();
				gc.getLocation(e.point, function(rs){
				   var addComp = rs.addressComponents;
				   //alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
				   
				   $("#dept_add_address").textbox('setValue',addComp.street+addComp.streetNumber);
				   $("#dept_add_map").remove();
				   $("#dept_add_closemap").remove()
				})
			}
			map.addEventListener("click", showInfo);
    }
	
    });
     
		$('#dept_add_areaName').textbox({
    	editable: false,
    	width:200,
    	buttonText:'查询',    
        iconAlign:'right',
        required:true,
        icons:[{
			iconCls:'icon-clear',
			handler: function(e){
				$(e.data.target).textbox('clear').textbox('textbox').focus();
			}
		}],
        onClickButton:function(){
        	  showSelectAreaDialog($("#dept_add_areaId").val(),function(row){
				$("#dept_add_areaName").textbox('setValue',row.text);
				$("#dept_add_areaId").val(row.id);
				$("#dept_add_area_lng").val(row.datas.lng);
				$("#dept_add_area_lat").val(row.datas.lat);
				
	        }); 
        },
        onChange:function(newValue, oldValue){
      	 
      }
    })
	
	
	
});
</script>
</body>
</html>
