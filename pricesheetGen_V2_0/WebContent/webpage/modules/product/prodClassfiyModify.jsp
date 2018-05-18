<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>修改商品类型</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/bootstrap.css" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/css/build.css" />
	<script type="text/javascript">
	var validateForm;
	function doSubmit(){ //回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  $("#inputForm").submit();
		  return true;

	  return false;
	} 
	</script>
</head>
<body class="hideScroll">
	<form method="post" id="inputForm" name="inputForm"  action="${ctx}/product/prodClassfiy/update">
		<input type="hidden" name="id" value="${prodClassfiy.uid}" />
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品类型编号:</label></td>
		         <td  ><input name="prodClassfiyId" value="${prodClassfiy.prodClassfiyId}" readonly="readonly"  maxlength="50" class="form-control required" /></td>
		      </tr>
		      <tr>
		         <td class="active" width="15%"><label class="pull-right"><font color="red">*</font>商品类型名称:</label></td>
		         <td ><input name="prodClassfiyName" value="${prodClassfiy.prodClassfiyName}"   maxlength="50" class="form-control required "/></td>
		      </tr>
<!-- 		      <tr> -->
<!-- 		         <td class="active"><label class="pull-right">商品品牌:</label></td> -->
<!-- 		         <td> -->
<!-- 		         	<div style="height:200px; overflow:auto;padding:0px;" > -->
<%-- 		         			<form:checkboxes element="div style='margin-left:16px;width:40%;' class='checkbox checkbox-success checkbox-inline form-group col-sm-6'"  onchange='brandChecked()' --%>
<%-- 		         	 path="brandIdList" items="${brands}" itemLabel="brandName" itemValue="brandId" htmlEscape="false" cssClass="checks required"  /> --%>
<!-- 		         	</div> -->
<!-- 		         </td> -->
<!-- 		         <td class="active"><label class="pull-right">商品型号:</label></td> -->
<!-- 		         <td>  -->
<!-- 		         	<div style="height:200px; overflow:auto;" id="modelD"> -->
<!-- 		         	</div> -->
<!-- 		         </td> -->
<!-- 		      </tr> -->
		 </tbody>
		 </table>
	</form>
	<script type="text/javascript">
	 $(document).ready(function() { 
// 		 brandChecked();
	 }); 
	 
	 function brandChecked(){
		 $("#modelD").html("");
		 var brandId  = document.getElementsByName("brandIdList");
		 var brandIds=[];
		 for (var int = 0; int < brandId.length; int++) {
			if(brandId[int].checked){
				brandIds.push(brandId[int].value);
			}
		 }
		 var classfiyId = $('input[name="prodClassfiyId"]').val();
		 console.log(brandIds+"---"+classfiyId);
		 $.ajax({
				type : "GET",
		        url :'${ctx}/product/product/findModelByBIdAndCIdAndPId',
				data : {
					"brandIds" : brandIds,
					"classfiyId":classfiyId
				},
				dataType : "json",
				traditional: true,
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				cache : false,
				async : false,
				success : function(data) {
				 	console.log(data);
				 	var htmlM='';
				 	if(data.status==1){
				 		$(data.data.models).each(function(i, item){
				 			htmlM+='<div class="col-sm-12">';
				 			htmlM+='<div>';
				 			htmlM+=item.brandName;
				 			htmlM+='</div>';
				 			htmlM+='<div class="checkbox checkbox-success checkbox-inline" style="font-size:10px;padding:0px;">';
				 			$(item.modelList).each(function(j, items){
				 				htmlM+='<div class="col-sm-6">';	
					 			htmlM+='<input type="checkbox" name="modelId"  style="width:100px;height:35px;"  class="styled" value="'+items.modelId+'" checked="checked"  />'; 
					 			htmlM+='<label for="modelName" >'+items.modelName+' </label>'; 
					 			htmlM+='</div>';
					 		})
					 		htmlM+='</div>';
					 		htmlM+='</div>';
				 		})
				 	}
				 	$("#modelD").html(htmlM);
				},
				error : function(msg) {
					console.log(msg);
				}
			});
	 }
	</script>
</body>

</html>