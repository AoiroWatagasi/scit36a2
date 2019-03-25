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
			init();
			$("#inbutton").on('click',function()	{
					insertMenu();
				
			})
			$("#deletebutton").on('click',function()	{
				delmenu();
			})
		});	
	
		
		function insertMenu()	{
			var menu_name = $("#menu_name").val();
			var menu_sellFlag = 0;
			if (menu_name.trim().length == 0) {
				alert("�޴��̸�����Ϸ��� �Է��ϼ���");
				return;
			}
			
			var menu_sellFlag = $("#menu_sellFlag option:selected").val();	
			if (menu_sellFlag=="�Ǹ���") {
				menu_sellFlag = 1;
			}	else if (menu_sellFlag=="�Ǹ��߾ƴ�") {
				menu_sellFlag = 0;
			}
			var menu_price = $("#menu_price").val();
			if (menu_price.trim().length == 0) {
				alert("����� �����Է��Ұ�");
				return;
			}	else if (isNaN(menu_price)) {
				alert("������ ���ڷ��Ұ�. int�� ��¿�� �����");
				return;
			}
			var menu_category = $("#menu_category option:selected").val();
			var menu = {"menu_name":menu_name,
					"menu_sellFlag":menu_sellFlag,
					"menu_price":menu_price,
					"menu_category":menu_category};	
			$.ajax({
					url : "insertMenu",
					method : "post",
					data : menu,
					success : function(resp){
						alert(resp);
						init();
					}
				});
		}
	function output(resp)	{
		var a = "";
			a += "<tr>";
			a += "<th>�޴��̸�</th>";
			a += "<th>�Ǹ�����������</th>";
			a += "<th>���İ���</th>";
			a += "<th>����ī�װ�</th>";
			a += "</tr>";
		$.each(resp,function(index,item)	{		
			a += "<tr>";
			a += "<td>" + item.menu_name + "</td>";
			a += "<td>" + item.menu_sellFlag + "</td>";
			a += "<td>"	+ item.menu_price + "</td>";
			a += "<td>" + item.menu_category + "</td>";
			a += "</tr>";		
		})
		$("#menuRegi").html(a);
	}
	

	
	function delmenu()	{
		var menu_seq = $("#menu_seq").val();
		if (menu_seq.trim().length==0) {
			alert("�����Ϸ��� �Է��ϼ���");
			return;
		}
		var menu_seq = {"menu_seq":menu_seq}
		$.ajax({
			url : "deleteMenu",
			method : "post",
			data : menu_seq,
			success : output
		});
		
	}
	
	function init()	{
		$.ajax({
			url : "selectMenu",
			method : "GET",
			data : function(resp)	{
				output
			}
			
		});
		
	}
	
	
	
	</script>



</head>
<body>
�޴� Menu.JSP		
<br><br><br>	
		<table id="menuRegi">
			<tr>
				<td>
					<input type="text" placeholder="����� �޴��̸� �Է�" name="menu_name" id="menu_name">
						<select id="menu_sellFlag" name="menu_sellFlag">
							<option value="�Ǹ���">�Ǹ���</option>
							<option value=�Ǹ��߾ƴ�>�Ǹ��߾ƴ�</option>
						</select>
					<input type="text" placeholder="ǰ���ǸŰ� �Է�" name="menu_price" id="menu_price">
						<select name="menu_category" id="menu_category">
							<option value="����" >����</option>
							<option value="�Ľ�" >�Ľ�</option>
							<option value="����Ʈ" >����Ʈ</option>
							<option value="����" >����</option>
					</select>		
				</td>
				<td>
					<input type="button" value="�޴� �߰� ���Ȯ�ι�ư" id="inbutton">
				</td>
			</tr>
			<tr>
				<td>
		<br><br><br><br><br><br>
		<input type="text" placeholder="�޴������� ��ȣ�Է�" name="menu_seq" id="menu_seq">
					<input type="button" value="�޴� ���� ��ư" id="deletebutton">
				</td>
			</tr>
		</table>
		
</body>
</html>