<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>德州恒丰纺织后台管理系统</title>
    <jsp:include page="/common.jsp"></jsp:include>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body>
<style type="text/css">
	#role_add_form{
		margin:0;
		padding:10px 30px;
	}
	.ftitle{
		font-size:14px;
		font-weight:bold;
		color:#666;
		padding:5px 0;
		margin-bottom:10px;
		border-bottom:1px solid #ccc;
	}
	.fitem{
		margin-bottom:5px;
	}
	.fitem label{
		display:inline-block;
		width:80px;
	}
</style>
<div class="easyui-layout" style="width:100%;height:100%;">
	<div region="west" split="true" title="角色列表" style="width:70%;">
		<div id="role_list"></div>
	</div>
	<div region="center" title="权限列表">
		<div style="background-color:#F4F4F4;border-color:#DDD;height:auto;padding:1px 2px;border-width:0 0 1px;border-style:solid;">
			<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="javascript:updateRoleRight();">保存</a>
		</div>
		<div id="rights-panel">
			<div id="right_tree" checkbox="true"></div>
		</div>
	</div>
</div>
<%-- <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
   	<div class="ftitle">角色信息</div>
   	<form id="role_add_form" method="post" action='${basePath}basic/role_add'>
   		<div class="fitem">
   			<label>角色名称:</label>
   			<input id="roleName" name="roleName" class="easyui-textbox" required="true">
   		</div>
   		<div class="fitem">
   			<label>角色关键字:</label>
   			<input id="key" name="roleKey" class="easyui-textbox" required="true">
   		</div>
   	</form>
</div>
<div id="dlg-buttons">
	<a href="#" id="dlg_save" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRole()">保存</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
 --%>

<div id="role_edit_dialog"></div>
<script>
    $(function () {
        $('#role_list').datagrid({
            url: '${basePath}basic/getPagedRoleList',
            fitColumns: true,
            nowrap: true,
            width:'auto',
            fit:true,
            collapsible: true,
            pagination: true,
            autoRowHeight: false,
            idField: 'username',
            striped: true, //奇偶行是否区分
            singleSelect: true,//单选模式
            rownumbers: true,//行号
            remoteSort: false,
            //sortName: 'createTime',
            pageSize: 20, //每一页多少条数据
            pageList: [10, 20, 30, 40, 50],  //可以选择的每页的大小的combobox
            //queryParams: { text: '0',value: ''}, //传递到后台的参数
            onLoadSuccess:function(){
            	var rows = $('#role_list').datagrid("getRows");
            	if(rows && rows.length>0) {
            		var roleId = rows[0].roleId;
            		var url = "${basePath}menu/tree?roleId=" + roleId + "&delete_flag=0";
            		$("#right_tree").tree({url:url, cache:false});
            	}
            },
            columns: [[
                    { field: 'ck', checkbox: true },
                    { field: 'roleName', title: '角色名称', width: 80 },
                    { field: 'roleKey', title: '角色关键字', width: 80 },
                    {
                        field: 'delete_flag',
                        title: '是否可用',
                        sortable: true,
                        width: 80,
                        formatter: function (value, row) {
                            if (value == 0) return '<span style=color:green; >是</span>';
                            if (value == 1) return '<span style=color:red; >否</span>';
                        }    
                    }

            ]],
            onSelect: function(rowIndex, rowData) {
            	var selectRows = $('#role_list').datagrid('getSelections');
            	if(selectRows.length > 0) {
            		var roleId = selectRows[0].roleId;
            		var url = "${basePath}menu/tree?roleId=" + roleId;           	
            		$("#right_tree").tree({url:url, cache:false});
            	}
            },
            toolbar:[{
            	url: 'basic/role_add',
    			text:'新增',
    			iconCls:'icon-add',
    			handler:function(){
    				addDialog();
                }
    		},{
    			url: 'basic/role_edit',
    			text:'编辑',
    			iconCls:'icon-edit',
    			handler:function(){
	    			 var selectRows = $('#role_list').datagrid('getSelections');
	    	         if (selectRows.length <= 0) {
    	                $.messager.alert("温馨提示", "请先选择一行！");
    	                return;
	    	         }
	    	        editDialog(selectRows[0].roleId);
	    	       
    		    }
    		},'-',
    		]
        });
        
        actionButtonCtr('role_list');
        
        $('#rights-panel').panel({
        	height: '95%',
        	width: '100%',
        });
        
        
        function addDialog(){
        	var dlg = $("<div id='role_add_dialog'></div>");
        	dlg.dialog({
                title: '编辑角色',
                width: 400,
                height: 200,
                closed: true,
                cache: false,
                href: '${basePath}basic/role_add',
                modal: true,
                buttons: [{
					text:'保存',
					iconCls:'icon-ok',
					handler:function(){
						submitForm('role_add_form','role_add_dialog','role_list', '',this);
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#role_add_dialog').dialog('close');
					}
				}],
				onClose:function(){
					$('#role_add_dialog').dialog('destroy');
				}
            });
        	
        	dlg.dialog('open');
        }
        
        function editDialog(roleId){
        	var dlg = $("<div id='role_edit_dialog'></div>");
        	dlg.dialog({
                title: '编辑角色',
                width: 400,
                height: 280,
                closed: true,
                cache: false,
                href: '${basePath}basic/role_edit?roleId=' + roleId + '&delete_flag=0',
                modal: true,
                buttons: [{
					text:'保存',
					iconCls:'icon-ok',
					handler:function(){
						submitForm('role_edit_form','role_edit_dialog','role_list', '',this);
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$('#role_edit_dialog').dialog('close');
					}
				}],
				onClose:function(){
					$('#role_edit_dialog').dialog('destroy');
				}
            });
        	dlg.dialog('open');
        }
    });
    function saveRole() {
    	$.get('${basePath}basic/isExistRole',{roleName:$("#roleName").val()},function(data){
            if(data == "false"){
         	   submitForm('role_add_form','dlg','role_list', '','','dlg_save');
            }else{
         	   $.messager.alert("温馨提示", "角色名称已存在！");
            }
        });
    }
    function updateRoleRight() {
    	var selectRows = $('#role_list').datagrid('getSelections');
    	if (selectRows.length <= 0) {
            $.messager.alert("温馨提示", "请先选中一个角色！");
            return;
         }
 
    	var checkedNodes = $('#right_tree').tree('getChecked',['checked','indeterminate']);
    	var checkedMenuIds = '';
    	for(var i = 0; i < checkedNodes.length; i++) {
    		if(checkedMenuIds != '') {
    			checkedMenuIds += ',';
    		}
    		checkedMenuIds += checkedNodes[i].id;
    		
    	}
    	 
    	$.post('${basePath}menu/updateRights',{roleId:selectRows[0].roleId,menuIds:checkedMenuIds},function(data){
            if(data == '"ok"'){
         	   $.messager.alert("温馨提示", "角色权限修改成功！");
         	   $('#role_list').datagrid('reload');
         	  var nodes =$("#right_tree").tree("getChecked");
         	  for(var i=0;i<nodes.length;i++){
         		 $("#right_tree").tree("uncheck",nodes[i].target);
         	  }
         	  $("#right_tree").tree('reload');
            }else{
         	   $.messager.alert("温馨提示", "角色权限修改失败，请联系服务人员！");
            }
        });
    }
</script>
</body>
</html>
