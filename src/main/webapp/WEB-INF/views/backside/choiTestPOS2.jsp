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
		//alert("test1");
		selectMenu();
		//alert("test2");
	
		//alert("test3");	
	})
	


 function output(resp)	{
		
		var a = "";
			a += "<tr>";
			a += "<th>" + "seat_seq" +"</th>";
			a += "<th>" + "sales_visitors" +"</th>";
			a += "<th>" + "sales_start" +"</th>";
			a += "<th>" + "sales_end" +"</th>";
			a += "<th>" + "sales_memo" +"</th>";
			a += "<th>" + "menu_seq" +"</th>";
			a += "<th>" + "menu_name" +"</th>";
			a += "<th>" + "menu_price" +"</th>";
			a += "<th>" + "menu_sellFlag" + "</th>";
			a += "<th>" + "menu_category" + "</th>";
			a += "<th>" + "sales_order" +"</th>";
			a += "<th>" + "sales_discount" +"</th>";
			a += "<th>" + "sales_memo" + "</th>";
			a += "<th>" + "sales_state_seq" + "</th>";
			a += "</tr>";
				
		$.each(resp,function(index,item)	{
			a +="<tr>";
			a +="<td>" +item.seat_seq+"</td>";
			a +="<td>" +item.sales_visitors+"</td>";
			a +="<td>" +item.sales_start+"</td>";
			a +="<td>" +item.sales_end+"</td>";
			a +="<td>" +item.sales_memo+"</td>";
			a +="<td>" +item.menu_seq+"</td>";
			a +="<td>" +item.menu_name+"</td>";
			a +="<td>" +item.menu_price+"</td>";
			a +="<td>" +item.menu_sellFlag+"</td>";
			a +="<td>" +item.menu_category+"</td>";
			a +="<td>" +item.sales_order+"</td>";
			a +="<td>" +item.sales_discount+"</td>";
			a +="<td>" +item.sales_memo+"</td>";
			a +="<td>" +item.sales_state_seq+"</td>";
			a += "<td><input type='button' regi-value=" +item.menu_seq+ " class='regi' value='�ֹ�������ư'></td>";
			a += "<td><input type='button' del-value=" +item.sales_state_seq+" class='del' name='sales_state_seq' value='������ư'></td>";
			a += "<td><input type='button' upd-value=" +item.menu_seq+ " class='upd' value='������ư'></td>";
			a +="</tr>";
			
		});
		$("#selectOrder").html(a);	
		$(".regi").on('click',regi);
		$(".del").on('click',clickDel);
		
	} 
		
	
	
	function regi()	{
		var m_seq = $(this).attr("regi-value");
		var seat_seq = $("#seat_seq").val();
		if (isNaN(seat_seq)) {
			alert("���ڷ��Է�");
			return;
		}
		var sales_memo = $("#sales_memo").val();
		var sales_visitors = $("#sales_visitors").val();
		if (isNaN(sales_visitors)) {
			alert("���ڷ�");
			return;
		}
		var menu_seq = $("#menu_seq").val();
		if (isNaN(menu_seq)) {
			alert("���ڷ��Է�");
			return;
		}
		var sales_order = $("#sales_order").val();
		if (isNaN(sales_order)) {
			alert("���ڷ��Է�");
			return;
		}
		var sales_discount = $("#sales_discount").val();
		if (isNaN(sales_discount)) {
			alert("���ڷ��Է�");
			return;
		}
			
		var d = {
				"m_seq":m_seq
				,"seat_seq":seat_seq
				,"sales_memo":sales_memo
				,"menu_seq":menu_seq
				,"sales_order":sales_order
				,"sales_discount":sales_discount
				,"sales_visitors":sales_visitors
				};
		
		
		alert("text3");
		$.ajax({
			 url : "insertSasSad"
			,method : "POST"
			,data : d
			,success : output
		});
		
	}
	
	
	
  function selectMenu()	{
	$.ajax({
		url : "selectPOS2",
		method : "POST",
		success : function (resp) {
			alert(JSON.stringify(resp));
			/* output(resp); */
		}
	});
} 
 	
	
 	function clickDel()	{//����Ʈ�� �ִ� ������ư�� Ŭ�� ������ �����Ǵ� ���
		var d_seq = $(this).attr("del-value");
 	alert(d_seq);
		var d = {"d_seq":d_seq};
		
		$.ajax({
			url : "deleteSasSadPay",
			method : "POST",
			data : d,
			success : function(resp)	{
				output
			}
		});
	}
	
	
	</script>

</head>
<body>
	<h1>POS��� �⺻ȭ��2 ( ǰ���,����,���� ���� �Է¹ް� �ֹ������ �ϴ� ȭ�� )</h1><br><br><br><br><br>
	 

	<tr>
		<td>Ȧ ���̺�,���۽ð�,�����ð�???</td><br><br><br>
	</tr>	
<table border="1" id="selectOrder">
</table><br><br><br>	
	<tr>	
		<td>�߰��ֹ� , �����ֹ�</td><br>
		<td><input type="reset" value="��ü���" id="reset"><input type="button" id="one" value="�������"></td><br>
		<td>�� �ݾ� :    ��</td><br><br>
		
		<td><input type="text" id="seat_seq" name="seat_seq" placeholder="�ڸ���ȣ"></td>
		<td><input type="text" id="sales_visitors" name="sales_visitors" placeholder="����Է�"></td><br>
		<td><input type="text" id="menu_seq" name="menu_seq" placeholder="�޴���ȣ"></td>
		<td><input type="text" id="sales_discount" name="sales_discount" placeholder="����,����">	<input type="text" placeholder="�ֹ�����" id="sales_order" name="sales_order"><input type="text" id="sales_memo" name="sales_memo" placeholder="�޸��Է�">6�� �Է��� ���� �ֹ�������ư Ŭ��</td><br>
		
	</tr>




</body>
</html>