<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="resources/jquery-3.3.1.min.js"></script>
<script>
	$(function()	{
		alert("test1");
		selectMenu();
		alert("test2");
		output();
		alert("test3");	
	})
	


	function output(resp)	{
		var a = "";
			a += "<tr>";
			a += "<th>" + "seat_seq" +"</th>";
			a += "<th>" + "sales_visitors" +"</th>";
			a += "<th>" + "sales_start" +"</th>";
			a += "<th>" + "sales_end" +"</th>";
			a += "<th>" + "menu_seq" +"</th>";
			a += "<th>" + "menu_name" +"</th>";
			a += "<th>" + "menu_price" +"</th>";
			a += "<th>" + "sales_order" +"</th>";
			a += "<th>" + "sales_discount" +"</th>";
			a += "<th>" + "sales_memo" +"</th>";
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
			a += "<td><input type='button' regi-value=" +item.menu_seq+ " class='regi' value='�ֹ�������ư'></td>";
			a += "<td><input type='button' del-value=" +item.menu_seq+ " class='del' value='������ư'></td>";
			a += "<td><input type='button' upd-value=" +item.menu_seq+ " class='upd' value='������ư'></td>";
			a +="</tr>";
			
		});
		$("#selectOrder").html(a);	
		$(".regi").on('click',regi);
	}
	
	
	function regi()	{
		var menu_seq = $(this).attr("regi-value");
		var mNum = {"menu_seq":menu_seq};
		/* var memoIn = ("#memoIn").val();
		if (memoIn.trim().length==0) {
			alert("�޸��Է�");
			return;
		} */
		
		var data = {"mNum":mNum};
		
		alert("text3");
		$.ajax({
			 url : "insertSasSad"
			,method : "POST"
			,data : data
			,success : output
		});
		
	}
	
	
	
function selectMenu()	{
	$.ajax({
		url : "selectMenu",
		method : "POST",
		success : output
		
	});
		
	
}
	

	
	
	
	
	</script>

</head>
<body>
	<h1>POS��� �⺻ȭ��</h1><br><br><br>
	 

	<tr>
		<td>Ȧ ���̺�,���۽ð�,�����ð�???</td><br>
		<td>�߰��ֹ� , �����ֹ�</td><br>
		<td><input type="reset" value="��ü���" id="reset"><input type="button" id="one" value="�������"></td><br>
		<td>�� �ݾ� :    ��</td><br>
		<td><input type="text" id="memoIn" placeholder="�޸��Է�"></td><br>
		<td><input type="text" id="sales_visitors" placeholder="����Է�"></td><br>
	</tr>


<br><br>
<table id="selectOrder">
</table>
</body>
</html>