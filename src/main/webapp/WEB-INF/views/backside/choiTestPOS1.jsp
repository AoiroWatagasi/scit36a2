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
	selectPOSone();
})

function selectPOSone(resp)	{
	
	$.ajax({
		url : "selectPOSone",
		method : "POST",
		success : output
		
	});
}
	 function output(resp)	{
			var a = "";
				a += "<tr>";
				a += "<th>" + "�¼���ȣ" +"</th>";
				a += "<th>" + "���̺��̸�" + "</th>";
				a += "<th>" + "�޸�" + "</th>";
				a += "<th>" + "�޴��Ϸù�ȣ" + "</th>";
				a += "<th>" + "�ֹ�����" + "</th>";
				a += "</tr> ";
			$.each(resp,function(index,item)	{
				a +="<tr>";
				a +="<td>" + item.SEAT_SEQ + "</td>";
				a +="<td>" + item.SEAT_ID + "</td>";
				a +="<td>" + item.SALES_MEMO + "</td>";
				a +="<td>" + item.MENU_SEQ + "</td>";
				a +="<td>" + item.SALES_ORDER + "</td>";
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
	<br><br><br>
<table id="selectOrder">
</table>
<br><br>
	���� ����(����)�� : ��          ���ϸ���� : ��<br><br><br>
	<input type="button" id="hwesoo" value="����ȸ��"><input type="button" id="tuip" value="��������"><input type="button" id="johwe" value="����������ȸ"><input type="button" id="magam" value="��������"><br><br><br><br><br>
<br><br>

	<a href="choiTestPOS2">POS���ȭ��2</a><br><br>

	
</body>
</html>