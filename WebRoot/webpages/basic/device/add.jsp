<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>渔业综合服务平台</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="">
</head>
<body>
<form id="device_add_form" method="post" action='${basePath}device/device_add'>
	<table style="padding:20 0 0 20">
	     <tr style="height:40px;">
			<td style="width:120px;text-align:right;">地&nbsp;&nbsp;区：</td>
			<td>
				<input id="device_add_areaName" name="areaName"  style="width:210px;">
			    <input id="device_add_areaCode" name="areaCode" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">池&nbsp;&nbsp;塘：</td>
			<td>
				<input id="device_add_pondName" name="pondName"  style="width:210px;">
			    <input id="device_add_pondCode" name="pondCode" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">采 集 器：</td>
			<td>
				<input id="device_add_collectorName" name="collectorName"  style="width:210px;">
			    <input id="device_add_collectorCode" name="collectorCode" type="hidden">
			    <input id="device_add_collectorId" name="collectorId" type="hidden">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">设备类型：</td>
			<td>
				<input id="device_add_typeName" name="typeName" style="width:210px;">
			    <input id="device_add_typeCode" name="typeCode" type="hidden">
			</td>
		</tr>
		<tr><td></td><td><div id = "insert"></div></td></tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">通道编号：</td>
			<td>
				<input id="gallery_id" class="easyui-textbox"  name="gallery_id"  style="width:210px;">
		   </td>
		   
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">序 列 号：</td>
			<td>
				<input readonly="readonly" id="device_add_id" class="easyui-textbox"name="deviceId" data-options="required:true"  style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">名&nbsp;&nbsp;称：</td>
			<td>
				<input id="device_add_name" class="easyui-textbox" name="deviceName" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;display: none;" id="device_add_tr_valarea">
			<td style="width:120px;text-align:right;">阈值范围：</td>
			<td>
				<input id="device_add_minval" name="minval" class="easyui-numberbox" data-options="prompt:'最小值'" style="width:100px;">-
			    <input id="device_add_maxval" name="maxval" class="easyui-numberbox" data-options="prompt:'最大值'" style="width:100px;">
			</td>
		</tr>
		
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">购买时间：</td>
			<td>
				<input id="device_add_buyDate" class="easyui-datebox" name="buyDate" style="width:210px;" data-options="required:true" >
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">生效时间：</td>
			<td>
				<input id="device_add_effectiveDate" class="easyui-datebox" name="effectiveDate"  style="width:210px;"  data-options="required:true" /> 
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">到期时间：</td>
			<td>
				<input id="device_add_expiringDate" class="easyui-datebox" name="expiringDate"  style="width:210px;" data-options="required:true" /> 
			</td>
		</tr>	
	</table>
</form>
<script type="text/javascript">

$(function() {
	$('#device_add_typeName').combobox({
		url : webContext + "device/getTypes",
		valueField: 'typeName',
		textField: 'typeName',
		required: true,
		editable: false,
		panelHeight: 'auto',
		onSelect: function(item) {
			$('#device_add_typeCode').val(item.typeCode);
			$('#device_add_typeName').val(item.typeName);
			/* if(item.typeCode=="0156"){
				$('#device_add_tr_valarea').show();
				$('#device_add_minval').numberbox({"required":true});
				$('#device_add_maxval').numberbox({"required":true});
			}else{
				$('#device_add_tr_valarea').hide();
				$('#device_add_minval').numberbox({"required":false});
				$('#device_add_maxval').numberbox({"required":false});
			} */
			if(item.typeCode==LXBH_CGQ_RYWD){//溶氧量温度传感器 0151
				$("#insert").html("<span style='font-family:华文中宋; color:red; '>通道编号:取值范围201-250</span>");
			}else if(item.typeCode==LXBH_KZQ_ZY){//增氧机 0156
				$("#insert").html("<span style='font-family:华文中宋; color:red; '>通道编号:取值范围000-019</span>");
			}else if(item.typeCode==LXBH_KZQ_TE){//投饵机0201
				$("#insert").html("<span style='font-family:华文中宋; color:red; '>通道编号:取值范围051-079</span>");
			}else if(item.typeCode==LXBH_CGQ_PH){//PH传感器0141
				$("#insert").html("<span style='font-family:华文中宋; color:red; '>通道编号:取值范围151-200</span>");
			}
		}
	});
	//选择区域对话框
	$('#device_add_areaName').textbox({
		editable: false,
		width:210,
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
      	 	showSelectAreaDialog($("#device_add_areaCode").val(),function(row){
				$("#device_add_areaName").textbox('setValue',row.text);
				$("#device_add_areaCode").val(row.id);
				$("#device_add_pondName").textbox('clear');
  	 		 	$("#device_add_pondCode").val('');
				$("#device_add_collectorName").textbox('clear');
  	 		 	$("#device_add_collectorCode").val('');
  	 		    $("#device_add_collectorId").val('');
	        });
        }
    });
	//选择池塘对话框
	$('#device_add_pondName').textbox({
    	editable: false,
    	width:210,
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
        	var area = $("#device_add_areaCode").val();
        	if(!area){
        		$.messager.alert("温馨提示", "请先选择所在地区！");
        		return;
        	}
      	 	showSelectPondDialog(area,function(row){
          	     $("#device_add_pondName").textbox('setValue',row.name);
   	 		 	 $("#device_add_pondCode").val(row.code);
   	 		     $("#device_add_collectorName").textbox('clear');
	 		 	 $("#device_add_collectorCode").val('');
	 		 	 $("#device_add_collectorId").val('');
	        });
        }
    });
	//选择采集器对话框
	$('#device_add_collectorName').textbox({
    	editable: false,
    	width:210,
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
        	var pondCode = $("#device_add_pondCode").val();
        	if(!pondCode){
        		$.messager.alert("温馨提示", "请先选择所属池塘！");
        		return;
        	}
        	var pointCode = pondCode.substr(0,pondCode.length-2);
      	 	showSelectCollectorDialog(pointCode,function(row){
          	     $("#device_add_collectorName").textbox('setValue',row.collectorName);
   	 		 	 $("#device_add_collectorCode").val(row.collectorCode);
   	 		     $("#device_add_collectorId").val(row.collectorId);
	        });
        }
    });

	$('#gallery_id').textbox({  
		validType:"number" ,
		events:{
			blur: function(){
				$('#device_add_id').textbox('setValue',"");
			    if(null == $('#device_add_collectorName').val()|| '' == $('#device_add_collectorName').val()){
			    	$.messager.alert("温馨提示",'请选择采集器!') ;
				   return;
				}else if(null == $('#device_add_typeName').val()|| '' == $('#device_add_typeName').val()){
					$.messager.alert("温馨提示",'请输入设备类型!') ;
				   return;
				}
			    var typeCode = $('#device_add_typeCode').val();
			    var collectorId =  $('#device_add_collectorId').val();
			    var gallery =  $('#gallery_id').val();
			    var len = "";
			    if(gallery.length>3  ){
			    	$.messager.alert("温馨提示",'您输入的通道号长度不对!') ;
					return;
			    }else if(gallery.length <= 2){
			    	$.messager.alert("温馨提示",'您输入的通道号!') ;
					return;
			    }else if(gallery.length == 2){
			    	len = "0";
			    }else if(gallery.length == 1){
			    	len = "00";
			    }
			    if(typeCode==LXBH_CGQ_RYWD){//溶氧量温度传感器 201 - 250  0151
			    	if(!((201<=gallery) && (gallery<=250))){
			    		$.messager.alert("温馨提示",'您输入的溶氧量温度传感器 通道号不在范围之内!') ;
			    		return;
				    }
				}else if(typeCode==LXBH_KZQ_ZY){//增氧机0-19  0156
					if(!((0<=gallery) && (gallery<=19))){
			    		$.messager.alert("温馨提示",'您输入的通道号不在范围之内!') ;
			    		return;
				    }
				}else if(typeCode==LXBH_KZQ_TE){//投饵机51-79  0201
					if(!((51<=gallery) && (gallery<=79))){
			    		$.messager.alert("温馨提示",'您输入的增氧机通道号不在范围之内!') ;
			    		return;
				    }
				}else if(typeCode==LXBH_CGQ_PH){//PH传感器151-200  0141
					if(!((151<=gallery) && (gallery<=200))){
			    		$.messager.alert("温馨提示",'您输入的PH传感器通道号不在范围之内!') ;
			    		return;
				    }
				}
			    $('#device_add_id').textbox('setValue',""+collectorId+len+gallery);
			 }} 
			
	});
	

});
</script>
</body>
</html>
