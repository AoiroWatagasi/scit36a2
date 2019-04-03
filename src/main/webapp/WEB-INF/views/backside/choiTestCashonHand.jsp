<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script src="resources/jquery-3.3.1.js"></script>
<script>
$(function()	{
	//selectCashOne();		//���ó�¥�̸鼭 cashonType�� 1�ΰ͸� ���
	selectCashonhand();	//���� ��ü���
	//predicCash();	//��������					
	
	$("#cashCheck").on('click',function()	{
		insertCashonhand();		
	})
	$("#delbutt").on('click',function()	{
		deleteCashonhand();
	})
	
})
function insertCashonhand()	{
	var currentMoney = $("#currentMoney").val();
	var cashonhand_error = 0;
	
	//1.�з����� 		1)���� +  , 2)ȸ�� -  , 3)���� +  ,  4)���� -
	var cashonhand_type = $("#cashonhand_type option:selected").val();
	
	//5.���� ���� ����,����,ȸ���� �����ݾ�
	var cashonhand_cash = $("#cashonhand_cash").val();
	
	if (cashonhand_type=="����") {
		
		cashonhand_type = 1;
		
		if (currentMoney != cashonhand_cash) {
			cashonhand_error = Number(currentMoney) - Number(cashonhand_cash);
			
			if (cashonhand_error < 0) {
				cashonhand_error = Number(cashonhand_cash) - Number(currentMoney);
			}

		}	else	{
			cashonhand_error = Number(currentMoney) - Number(cashonhand_cash);
		}
			

	
	}	else if (cashonhand_type=="ȸ��") {
		cashonhand_type = 2;
		
		cashonhand_error = Number(currentMoney) - Number(cashonhand_cash);
	
	}	else if (cashonhand_type=="����") {
		cashonhand_type = 3;
		cashonhand_error = Number(currentMoney) + Number(cashonhand_cash);
		
		if (currentMoney != cashonhand_cash) {
			cashonhand_error = Number(currentMoney) - Number(cashonhand_cash);
			
			if (cashonhand_error < 0) {
				cashonhand_error = Number(cashonhand_cash) - Number(currentMoney);
			}

		}	else	{
			cashonhand_error = 0;
		}
	
	}	else if (cashonhand_type=="����") {
		cashonhand_type = 4;
		
		cashonhand_error = Number(currentMoney) - Number(cashonhand_cash);
	}
	
	
	//2.���系�� �����
	var cashonhand_register = $("#cashonhand_register").val();
	
	var dat = {"cashonhand_type" : cashonhand_type
				,"cashonhand_register" : cashonhand_register
				,"cashonhand_error" : cashonhand_error
				,"cashonhand_cash" : cashonhand_cash
				//,"predictCash" : predictCash
				};
					$.ajax({
						url : "insertCashonhand",
						method : "POST",
						data : dat,
						success : output	
					});
}
function output(resp) {
    var a = "";
    a += "<tr>";
    a += "<th>����з�����</th>";
    a += "<th>���系�������</th>";
    a += "<th>�������ݰ���λ����</th>";
    a += "<th>����ݾ�</th>";
    a += "</tr>";
  $.each(resp, function(index, item) {
      a += "<tr>";
      a += "<td>" + item.cashonhand_type + "</td>";
      a += "<td>" + item.cashonhand_register + "</td>";
      a += "<td>" + item.cashonhand_error + "</td>";
      a += "<td>" + item.cashonhand_cash + "</td>";
      a += "</tr>";
    })
    $("#view").html(a);
  	predicCash();	//��������
  }
function selectCashonhand()	{
		$.ajax({
			url : "selectCashonhand",
			method : "POST",
			success : output
		});
	}
function selectCashOne()	{
	$.ajax({
		url : "selectCashOne",
		method : "POST",
		success : output
		
	});
}	
function deleteCashonhand()	{
		var cashonhand_seq = $("#deleteCashonhand").val();
		if (isNaN(cashonhand_seq)) {
			alert("��ȣ�� �Է�");
			return;
		}
		$.ajax({
			url : "deleteCashonhand",
			method : "post",
			data : { cashonhand_seq : cashonhand_seq },
			success : output
		});
	}

function predicCash()	{//��������
	$.ajax({
		url : "predicCash"
		,method : "POST"
		,success : function(resp)	{
			$("#cashonhand_cash").val("��������" + resp);
		}
		
	});
}



</script>

</head>
<body>
	<h1>�������̺�</h1>
	��������� �Է��ϰ�  ����ݾ��� ���ڷ� �Է��ϸ� ���˴ϴ�. ���ÿ� ������ ��쿡�� �������� ����ݾ��� +�� �ǰ� ȸ���� ������ ��쿡�� -�� �˴ϴ�.
															�ѹ��� ������ �� �Ŀ��� ������� ������翡 �Է��ؾ� �ϴ� ���ŷο��� �ֽ��ϴ�.   �� ���� ����� �ְ����� ������ �ȳ��׿�...
<br><br><br><br><br>		
<input type="text" id="currentMoney" placeholder="��������Է�"><br>	
<tr>
	<td>����з�����<select id="cashonhand_type">
					<option value="����">����</option>
					<option value="ȸ��">ȸ��</option>
					<option value="����">����</option>
					<option value="����">����</option>
				 </select>
	</td>
</tr><br>
<tr>
	<td>
				<input type="text" id="cashonhand_register" placeholder="���系�������">
	</td>
</tr><br>

<tr>
	<td>
		<input type="text" id="cashonhand_cash" placeholder="����ݾ�">
	</td>
</tr><br>
<input type="button" id="cashCheck" value="�����ư">

<table id="view">
</table>
<input type="text" id="deleteCashonhand" placeholder="������ �����ȣ�Է�">
<input type="button" id="delbutt" value="������ư">
<br><br><br>	
<div id="predictCash4">${predictCash4}</div>

</body>
</html>