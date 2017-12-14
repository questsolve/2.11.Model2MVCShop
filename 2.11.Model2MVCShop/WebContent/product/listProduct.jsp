<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<script type="text/javascript">

function fncGetUserList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	$("form").attr("action","../product/listProduct?menu=${menu}").attr("method","post").submit();
}


$(function(){
	$(".ct_list_pop td:nth-child(5)").on("click",function(){
		self.location ="../product/getProduct?prodNo="+$($("input[name=prodNo]")[$(".ct_list_pop td:nth-child(5)").index(this)]).val()+"&menu=${menu}";
	});
});


$(function(){
	$(".ct_list_pop td:nth-child(3)").on("click",function(){
		//self.location ="../product/getProduct?prodNo="+$($("input[name=prodNo]")[$(".ct_list_pop td:nth-child(3)").index(this)]).val()+"&menu=${menu}";
		var prodNo =$($("input[name=prodNo]")[$(".ct_list_pop td:nth-child(3)").index(this)]).val();
		var menu = "${menu}";
		
		$.ajax({
			url:"../product/json/getProduct/"+prodNo+"/"+menu,
			method:"GET",
			dataType:"json",
			headers :{
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success: function(JSONData,status){
				alert(status);
				alert(JSONData);
				var dpValue= "<h3>"
								+ "prodNo : " +JSONData.prodNo+"<br/>"
								+ "prodName : " +JSONData.prodName+"<br/>"
								+ "price : " +JSONData.price+"<br/>"
								+ "regDate : " +JSONData.regDate+"<br/>"
								+ "prodCount : " +JSONData.prodCount+"<br/>"
								+ "</h3>";
				$("h3").remove();
				$("#"+prodNo+"").html(dpValue);
			}
			
		});
	});
	
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<jsp:include page="/layout/toolbar.jsp" />

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				
				<option value="0" ${! empty search.searchCondition && search.searchCondition==0? "selected" :"" }>��ǰ��ȣ</option>
				<option value="1" ${! empty search.searchCondition && search.searchCondition==1? "selected" :"" }>��ǰ��</option>
				<option value="2" ${! empty search.searchCondition && search.searchCondition==2? "selected" :"" }>��ǰ����</option>
				
			</select>
			<input type="text" name="searchKeyword" value = "${! empty search.searchKeyword? search.searchKeyword: "" }" class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetUserList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="100"><a href="../product/listProduct?menu=${menu}&ordering=${productSearch.ordering}">No</a></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�̸�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
	<c:set var= "i" value="0"/>
	<c:forEach var ="product" items="${productMapList}">
		<c:set var="i" value="${i+1}"> </c:set>		
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
	<tr class="ct_list_pop">
		<td align="center">${i}</td>
		
		<td></td>
				
		<td align="left">
		<!-- <a href="../product/getProduct?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a> -->
		�̸�����</td>
		
		<td></td>
				
		<td align="left">
		<!-- <a href="../product/getProduct?prodNo=${product.prodNo}&menu=${menu}">${product.prodName}</a> -->
		${product.prodName}
		<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
		</td>
				
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.manuDate}</td>
		<td></td>
		<td align="left">
		
			�Ǹ���
		
		</td>	
	</tr>
	<tr>
		<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		
		<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
${menu}

</body>
</html>
