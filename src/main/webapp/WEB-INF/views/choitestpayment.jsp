<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function()	{
	$("#inPay").on('click',function()	{
		alert("test1");
		inPay();	
		alert("test2");
	})
})
	function inPay()	{
		var payType = $("#payType select:option").val();
				
		var payAmount = $("#payAmount").val();	
		if (payAmount.trim().length==0) {
			alert("�ݾ��Է��Ұ�");
			return;
		}	else if (isNaN(payAmount)) {
			alert("�ݾ��� ���ڷ�");
			return;
		}	
		var payTime = $("#payTime").val();
		
		var send = {"payAmount":payAmount, "payType":payType, "payTime":payTime};
		
		$.ajax({
			url : "inPay",
			method : "POST",
			data : send ,
			success : output
		});
}

function output()	{
	
}



</script>

<title>Insert title here</title>
</head>
<body>
<h1>��������</h1>


��������(ī��/����)
<select id="payType">
	<option value="ī��">ī��</option>
	<option value="����">����</option>
</select>
<br><br>

�����ݾ�
<input type="text" id="payAmount" placeholder="�����ݾ��Է�">
<br><br>
���� �ð�
<input type="date" id="payTime"><br>
<input type="button" id="inPay" value="����">






</body>
</html>