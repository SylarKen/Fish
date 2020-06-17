<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>德州恒丰纺织后台管理系统</title>
<jsp:include page="/common.jsp"></jsp:include>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="添加用户">
</head>
<body>
<form id="user_add_form" method="post" action='${basePath}user/insert'>
	<table style="padding:40px;">
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">登录账号：</td>
			<td>
				<input id="user_add_username" class="easyui-textbox" name="username" 
					data-options="required:true" style="width:210px;" validType="username">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">姓&nbsp;&nbsp;名：</td>
			<td>
				<input id="user_add_realname" class="easyui-textbox" name="realname" data-options="required:true" style="width:210px;">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">性&nbsp;&nbsp;别：</td>
			<td>
				男&nbsp;<input id="user_add_sex_man" type="radio" name="sex" value="0" checked>
				女&nbsp;<input id="user_add_sex_woman" type="radio" name="sex" value="1">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">手&nbsp;&nbsp;机：</td>
			<td>
				<input id="user_add_phone" class="easyui-textbox" name="phone" 
					data-options="" style="width:210px;" validType="mobile">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">角&nbsp;&nbsp;色：</td>
			<td>
				<input id="user_add_role" name="role" style="width:210px;">
				<input type="hidden" id="user_add_role_name" name="roleName">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">所在区划：</td>
			<td>
				<input id="user_add_areaId" type="hidden" name="area"  style="width:200px;">
				<input id="user_add_areaName"  name="areaName" value=""/>
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">所属部门：</td>
			<td>
				<input id="user_add_dept" name="dept" style="width:210px;">
				<input type="hidden" id="user_add_deptName" name="deptName">
			</td>
		</tr>
		<tr style="height:40px;">
			<td style="width:120px;text-align:right;">管理池塘：</td>
			<td>
				<input id="user_add_pondCode" type="hidden" name="pondCode" >
				<input id="user_add_pondName"  name="pondName" />
			</td>
		</tr>
	</table>
</form>
<script type="text/javascript">
$(function() {
	$('#user_add_dept').combobox({});
	$('#user_add_areaName').textbox({
	editable: false,
	width:210,
	buttonText:'查询',    
    iconAlign:'right',
    //required:true,
    icons:[{
		iconCls:'icon-clear',
		handler: function(e){
			$(e.data.target).textbox('clear').textbox('textbox').focus();
		}
	}],
    onClickButton:function(){
    	  showSelectAreaDialog($("#user_add_areaId").val(),function(row){
			$("#user_add_areaName").textbox('setValue',row.text);
			$("#user_add_areaId").val(row.id);	
	 
	    	$('#user_add_dept').combobox({
	    		url: '${basePath}dept/getDeptForComb?hasBlank=0&area='+row.id,
	    		valueField: 'code',
	    		textField: 'name', 
	    		editable: false,
	    		required:true,
	    		onSelect: function(node){			
	    			$('#user_add_deptName').val(node.name);
	    		}
	    	});
        }); 
    },
    onChange:function(newValue, oldValue){
 
    }
})
	
	
	$('#user_add_role').combobox({
		url: '${basePath}role/dataForCombo',
		valueField: 'id',
		textField: 'text', 
		required: true,
		editable: false,
		onSelect: function(item) {
			$('#user_add_role_name').val(item.text);
		}
	});

 
	$('#user_add_pondName').textbox({
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
        	//选择池塘
        	showPondTreeDialog(0,"",function(rows){
        		var pondCode = "";
        		var pondName = "";
        		console.log(rows);
        		for(var i=0;i<rows.length;i++){
        			if(rows[i].code.length==7){
        				pondCode = pondCode==""?rows[i].code:pondCode+","+rows[i].code;
            			pondName = pondName==""?rows[i].name:pondName+","+rows[i].name;
        			}
        		}
        		
        		$('#user_add_pondName').textbox("setValue",pondName);
        		$('#user_add_pondCode').val(pondCode);
        	},$('#user_add_dept').combobox("getValue"));	
        },
        onChange:function(newValue, oldValue){
      	 
      }
    })
});
</script>
</body>
</html>
