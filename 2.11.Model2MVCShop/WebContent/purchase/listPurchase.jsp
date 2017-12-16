<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<style>
	  body {
            padding-top : 50px;
        }
</style>
<script type="text/javascript">

function fncGetUserList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
	$("form").attr("method","POST").attr("action","../purchase/listPurchase").submit();
}
$(function(){
	
	$(".ct_list_pop td:nth-child(1)").on("click",function(){
		self.location ="../purchase/getPurchase?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(1)").index(this)]).val();
	});
	
	
	$(".ct_list_pop td:nth-child(3)").on("click",function(){
		//self.location ="../purchase/getPurchase?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(1)").index(this)]).val()";
		var tranNo=$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(3)").index(this)]).val();
		$.ajax({
			url:"../purchase/json/getPurchase/"+tranNo,
			method:"GET",
			dataType:"json",
			headers :{
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success:function(JSONData,status){
				alert(status);
				alert(JSONData);
				var dpValue= "<h3>"
								+ "tranNo : "+JSONData.tranNo+"<br/>"
								+ "prodNo : "+JSONData.purchaseProd.prodNo+"<br/>"
								+ "prodName : "+JSONData.purchaseProd.prodName+"<br/>"
								+ "userId : "+JSONData.buyer.userId+"<br/>"
								+ "payOption : "+JSONData.paymentOption+"<br/>"
								+ "buyer : "+JSONData.receiverName+"<br/>"
								+ "phone : "+JSONData.receiverPhone+"<br/>"
								+ "address : "+JSONData.divyAddr+"<br/>"
								+ "request : "+JSONData.divyRequest+"<br/>"
								+ "</h3>";
				$("h3").remove();
				$("#"+tranNo+"").html(dpValue);
			}
		})
	});
	
	
	
	
	$(".ct_list_pop td:nth-child(11):contains('���ó��')").on("click",function(){
		self.location="../purchase/updateTranCode?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(11)").index(this)]).val();
	});
	
	$(".ct_list_pop td:nth-child(11):contains('���ſϷ�')").on("click",function(){
		
		self.location="../purchase/updateTranCode?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(11)").index(this)]).val();
				
	});
	
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ����  ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�̸�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		
	</tr>
	

	<c:set var = "i" value="0" />
	<c:forEach var = "purchase" items="${purchaseMapList}">
	<c:set var="i" value="${i+1}"> </c:set>
		
		<c:set var="transtatus" value="��ۿϷ�"/>
		<c:if test="${purchase.tranCode.trim() == '0' }">
			<c:set var="transtatus" value="��� �غ���"></c:set>
		</c:if>
		<c:if test="${purchase.tranCode.trim() == '1' }">
			<c:set var="transtatus" value="��� ��"></c:set>
		</c:if>
		<c:if test="${purchase.tranCode.trim() == '2' }">
			<c:set var="transtatus" value="���� �Ϸ�"></c:set>
		</c:if>
			
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<tr class="ct_list_pop">
		<td align="center">
			<!-- <a href="../purchase/getPurchase?tranNo=${purchase.tranNo}">${i}</a> -->
			${i}
			<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
		</td>
		<td></td>
		<td align="left">
			Ȯ��
		</td>
		<td></td>
		
		<td align="left">
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.buyer.userName }</td>
		<td></td>
		<td align="left">${purchase.buyer.phone }</td>
		<td></td>
		<td align="left">����
				
					${transtatus }
				
				 �Դϴ�.
				 
				 
				 <c:if test="${!(purchase.buyer.role == 'user')}">
				 	���ó��	
				 </c:if>
				 <c:if test="${purchase.buyer.role == 'user' && purchase.tranCode.trim() == '1' }">
					 ���ſϷ�	
				 </c:if>				
			
				 </td>
		<td></td>
		<td align="left">
			
		</td>
	</tr>
	<tr>
		<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>

</c:forEach>	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
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

</body>
</html>