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
<meta http-equiv="description" content="编辑部门">
</head>
<body>
<form id="dept_edit_form" method="post" action='${basePath}dept/update'>
	<table style="padding:40px;">
			<tr style="height:40px;">
			<td style="width:120px;text-align:right;">部门名称：</td>
			<td>
			    <input type="hidden" name="code"  value="${dept.code}"  />
			    <input type="hidden" name="pcode"  value="${dept.pcode}"  />
			    <input type="hidden" name="grade"  value="${dept.grade}"  />
				<input id="dept_edit_name" class="easyui-textbox" name="name" value="${dept.name}"  style="width:200px;" data-options="required:true">
			</td>
		</tr>
	 	<tr style="height:40px;">
			<td style="width:120px;text-align:right;">上级部门：</td>
			<td>
				<input id="dept_edit_parent_name" class="easyui-textbox" value="${pdept.name }" name="pname" style="width:200px;" readOnly="readOnly">
				<%-- <input id="dept_edit_parent_id" type="hidden" name="pcode"  value="${pdept.code }"/> --%>
				<input id="dept_edit_level" type="hidden" name="pgrade" value="${pdept.grade }"/>
			</td>
		</tr> 
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">所在区划：</td>
			<td>
				<input id="dept_edit_areaId" type="hidden" name="areaId"  value="${dept.areaId}"  style="width:200px;">
				<input id="dept_edit_areaName"  name="areaName"  value="${dept.areaName}" />
				<input id="dept_edit_area_lng" type="hidden"  value="${dept.lng}" />
				<input id="dept_edit_area_lat" type="hidden"  value="${dept.lat}" />
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">经纬度：</td>
			<td  id="dept_edit_lat_td">
				<input id="dept_edit_lat" style="width:200px;"  value="${dept.lng_lat}" >
				<input id="dept_edit_hidden_lng"  name="lng" value="${dept.lng}"  type="hidden" />
				<input id="dept_edit_hidden_lat"  name="lat" value="${dept.lat}"  type="hidden" />
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">详细地址：</td>
			<td>
				<input id="dept_edit_address" class="easyui-textbox" name="address" value="${dept.address}"  style="width:200px;" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">联系人：</td>
			<td>
				<input id="dept_edit_linkman" class="easyui-textbox" name="linkman" value="${dept.linkman}"  style="width:200px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">联系电话：</td>
			<td>
				<input id="dept_edit_phone" class="easyui-textbox" name="linkphone"  value="${dept.linkphone}" 
					style="width:200px;" validType="mobile">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">备注：</td>
			<td>
				<input class="easyui-textbox" data-options="multiline:true" id="dept_edit_memo" name="memo" value="${dept.memo}"  style="width:200px;height:100px"></textarea>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">是否可用：</td>
			<td>
			 	<select class="easyui-combobox" style="width: 200px;" id="dept_edit_delete_flag" name="delete_flag" select_value='${dept.delete_flag}' data-options="panelHeight:'auto'">
       				<option value="0">可用</option>
					<option value="1">不可用</option>
	  			</select>
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript">
 
$(function() {
	$("#dept_edit_delete_flag").children("option[value='"+$('#dept_edit_delete_flag').attr("select_value")+"']").eq(0).attr('selected','selected');


	
	 <%--  $('#dept_edit_parent_name').combobox({
			url: '<%=basePath%>dept/getChildDepts', 
		    valueField:'code',    
		    textField:'name' ,
		    onSelect:function(record){
		    	$("#dept_edit_parent_id").val(record.code);
		    	$("#dept_edit_parent_name").val(record.name)
		    	$("#dept_edit_level").val(record.grade);
		    }
		});   --%>
	 
	 
	$('#dept_edit_lat').textbox({
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
          var $map = $("<div id='dept_edit_map' style='height:450px;width:500px;border:1px solid #CCC;position:absolute;top:-80px;left:-80px;z-index:100'></div>")
          var $closeMap = $("<div id='dept_edit_closemap' onclick=javascript:$('#dept_edit_map').remove();$(this).remove() style='position:absolute;top:-75px;left:400px;z-index:101;color:red;font-size:20px;font-weight:bolder;cursor:pointer'>X</div>");
          $("#dept_edit_lat_td").append($map);
          $("#dept_edit_lat_td").append($closeMap);
          $("#dept_edit_lat_td").css("position","relative");
		          // 百度地图API功能
			var map = new BMap.Map("dept_edit_map");            // 创建Map实例
			var lng = $("#dept_edit_area_lng").val();
			var lat =$("#dept_edit_area_lat").val();
			
			if(!lng) lng = 116.587242;
			if(!lat) lat = 35.415394;
			
			map.centerAndZoom(new BMap.Point(lng,lat), 11);  // 初始化地图,设置中心点坐标和地图级别
			//map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
			//map.setCurrentCity("上海");          // 设置地图显示的城市 此项是必须设置的
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		 
			function showInfo(e){
				console.log(e)
				$('#dept_edit_lat').textbox('setValue',e.point.lng + ", " + e.point.lat);
				$('#dept_edit_hidden_lng').val(e.point.lng);
				$('#dept_edit_hidden_lat').val(e.point.lat);
				var gc = new BMap.Geocoder();
				gc.getLocation(e.point, function(rs){
				   var addComp = rs.addressComponents;
				   //alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
				   
				   $("#dept_edit_address").textbox('setValue',addComp.street+addComp.streetNumber);
				   $("#dept_edit_map").remove();
				   $("#dept_edit_closemap").remove()
				})
			}
			map.addEventListener("click", showInfo);
    }
	
    });
	
	  
	$('#dept_edit_areaName').textbox({
	editable: false,
	width:200,
	buttonText:'查询',    
    iconAlign:'right',
    required:true,
    icons:[{
		iconCls:'icon-clear',
		handler: function(e){
			$(e.data.target).textbox('clear').textbox('textbox').focus();
			$("#dept_edit_areaName").textbox('setValue','${dept.areaName}');
			$("#dept_edit_areaId").val('${dept.areaId}');
		}
	}],
    onClickButton:function(){
    	  showSelectAreaDialog($("#dept_edit_areaId").val(),function(row){
			$("#dept_edit_areaName").textbox('setValue',row.text);
			$("#dept_edit_areaId").val(row.id);
			$("#dept_edit_area_lng").val(row.datas.lng);
			$("#dept_edit_area_lat").val(row.datas.lat);
        }); 
    },
    onChange:function(newValue, oldValue){
  	 
  }
})
});
</script>
</body>
</html>
