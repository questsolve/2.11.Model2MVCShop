<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
�˼��մϴ� ��� �����մϴ�.
<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>���ż���</td>
		<td>${purchase.purchaseCount}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>���</td>
		<td>${purchase.purchaseProd.prodInven}</td>
		<td></td>
	</tr>
</table>
</body>
</html>