<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>POS��� �⺻ȭ��1</title>


<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function()	{
	selectAll();
})


function selectAll()	{
	$.ajax({
		url : "selectAll",
		method : "POST",
		success : output
		
	});
}
	 function output(resp)	{
			var a = "";
				a += "<tr>";
				a += "<th>" + "�¼���ȣ" +"</th>";
				a += "<th>" + "�湮�� ��" +"</th>";
				a += "<th>" + "���۽ð�" +"</th>";
				a += "<th>" + "�����ð�" +"</th>";
				a += "<th>" + "�޴���ȣ" +"</th>";
				a += "<th>" + "�޴��̸�" +"</th>";
				a += "<th>" + "�޴�����" +"</th>";
				a += "<th>" + "����" +"</th>";
				a += "<th>" + "����,����" +"</th>";
				a += "<th>" + "�޸�" +"</th>";
				a += "<th>" + "�Ǹ��߿���" + "</th>";
				a += "</tr>";
			$.each(resp,function(index,item)	{
				a +="<tr>";
				a +="<td>" +item.seat_seq+"</td>";
				a +="<td>" +item.sales_visitors+"</td>";
				a +="<td>" +item.sales_start+"</td>";
				a +="<td>" +item.sales_end+"</td>";
				a +="<td>" +item.menu_seq+"</td>";
				a +="<td>" +item.menu_name+"</td>";
				a +="<td>" +item.menu_price+"</td>";
				a +="<td>" +item.sales_order+"</td>";
				a +="<td>" +item.sales_discount+"</td>";
				a +="<td>" +item.sales_memo+"</td>";
				a +="<td>" +item.menu_sellFlag+"</td>";
				//a += "<td><input type='button' regi-value=" +item.menu_seq+ " class='regi' value='�ֹ�������ư'></td>";
				//a += "<td><input type='button' del-value=" +item.menu_seq+ " class='del' value='������ư'></td>";
				//a += "<td><input type='button' upd-value=" +item.menu_seq+ " class='upd' value='������ư'></td>";
				a +="</tr>";
				
			});
			$("#selectOrder").html(a);	
			
		} 















</script>


</head>
<body>
	<h1>POS��� �⺻ȭ��1 ( ���̺�ȭ���� �߰� �����̸�,����α����� ��� ,���翹������,���ϸ���� ���� �ߴ� POSȭ�� )</h1><br><br>

	�����̸�<br>
	���̺��̵�<br>
	<br><br><br><br><br>
	���� ����(����)�� : ��          ���ϸ���� : ��<br><br><br>
	<input type="button" id="hwesoo" value="����ȸ��"><input type="button" id="tuip" value="��������"><input type="button" id="johwe" value="����������ȸ"><input type="button" id="magam" value="��������"><br><br><br><br><br>

	<a href="choiTestPOS2">POS���ȭ��2</a><br><br><br><br>
<table id="selectOrder">
</table>

</body>
</html>