<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  <title>Insert title here</title>
  <script src="resources/jquery-3.3.1.min.js"></script>
  <script>
    $(function() {
      init();
      $("#insert").on('click', function() {
        addtable();

      })
      $("#delete").on('click', function() {
        alert("����test1");
        del();
        alert("����test2");
      })
     /*  $(".up_val").on('click', function() {
        upd();
     }) */
      
    })

    function addtable() {
      var seat_id = $("#seat_id").val();
      if (seat_id.trim().length == 0) {
        alert("�Է� ���ϸ� �ȵȴ�.");
        return;
      }

      var senddata = {
        "seat_id": seat_id
      }

      $.ajax({
        url: "addtable",
        method: "POST",
        data: senddata,
        success: output
      });
    }


    function output(resp) {

      var a = "";
		
      $.each(resp, function(index,item) {
    	a += "<tr>";
        a += "<td>" + item.seat_seq + "</td>";
        a += "<td>" + item.comp_seq + "</td>";
        a += "<td>" + item.seat_id + "</td>";
        //a += "<td><input type='button' data-value=" + item.seat_seq + "id='update_val' value='����'></td>";
        a += "</tr>";
      })
      $("#addtable").html(a);
     
    }

    function init() { // ���̺� ����� �������� �Լ�
      $.ajax({
        url: "selectseat",
        method: "POST",
        success: function(resp) {
        	selectSeat(resp);
          	//console.log(resp.stringify());
        }
      });
    }
   
    function del() {
        var seat_seq = $("#seat_seq").val();

        if (seat_seq.trim().length == 0) {
          alert("�����Ϸ��� ������ ���̺� �ѹ��� �Է��ϼ�");
          return;
        }
        var sd = {
          "seat_seq": seat_seq
        }
        $.ajax({
          url: "deleteseat",
          method: "POST",
          data: sd,
          success: function(resp) {
            output
          }
        });
      }
    
    function selectSeat(resp)	{
    	  var a = "";
		  a +="<tr>";
		  a +="<th>" + 'seat_seq' + "</th>";
		  a +="<th>" + 'comp_seq' + "</th>";
		  a +="<th>" + 'seat_id' + "</th>";
		  a +="<th>" + '������ư' + "</th>";
		  a +="</tr>";
		  $.each(resp, function(index, item) {
		    	a += "<tr>";
		        a += "<td>" + item.seat_seq + "</td>";
		        a += "<td>" + item.comp_seq + "</td>";
		        a += "<td>" + item.seat_id + "</td>";
		        a += "<td><input type='button' data-value=" + item.seat_seq + "id='up_val' value='�¼�������ư'></td>";
		        a += "</tr>";
		      })
		  $("#addtable").html(a);
		 // $("#up_val").on('click',upd);	///////////////////////////
		//  $(".up_val").on('click',input_update2);
    }
      

    function upd() {
    	var upVal = $(this).attr("data-value");
   		alert("text1"); 
    	console.log(upVal);
    		$.ajax({
    			url : "selectseat",
    			method : "POST",
    			success : function(resp)	{
    				 var a = "";
    				  a +="<tr>";
    				  a +="<th>" + 'seat_seq' + "</th>";
    				  a +="<th>" + 'comp_seq' + "</th>";
    				  a +="<th>" + 'seat_id' + "</th>";
    				  a +="<th>" + '������ư' + "</th>";
    				  a +="</tr>";
    				$.each(resp,function(index,item)	{
    					if (upVal==item.seat_seq) {
							a += "<tr>";
    						a += "<td>" + item.seat_seq + "</td>";
    						a += "<td>" + item.comp_seq + "</td>";
    						a += "<td><input type='text' id='seat_id' value='" + item.seat_id + "'/></td>";
    						a += "<td><input type='button' data-value=" +item.seat_seq+ " id='input_update' value='�����ϱ�'></td>";
    						a += "</tr>";
						}	else	{
							a += "<tr>";
							a +="<td>" + item.seat_seq + "</td>";
							a +="<td>" + item.comp_seq + "</td>";
							a += "<td>" + item.seat_id + "</td>";
							a += "<td><input type='button' data-value=" +item.seat_seq+ " class='up_val' value='���̺� ������ư'></td>";
							a += "</tr>";
						}
       				})
    			$("#addtable").empty();
    			$("#addtable").html(a);
    			//$(".up_val").on('click',input_update2);
    			}
    		});
    }  
   		 function input_update2()	{
   			 var reseat_seq = $(this).attr("data-value");
   			 var seat_id = $("#seat_id").val();
   			alert("text2222");
   		 	var d = {"reseat_seq":reseat_seq,"seat_id":seat_id};
   		 
   		 $.ajax({
   			url : "updateseat",
   			 method : "POST",
   			 data : d,
   			 success : init
   		 });
   		 }
  </script>


</head>

<body>
  Seat ���̺��¼�<br>

  <tr>
    <td>
      <input type="text" id="seat_id" name="seat_id" placeholder="�߰��� ���̺� �̸��Է�"><br>
    </td>
  </tr>
  <tr>
    <td>
      <input type="button" value="���̺� �߰� ���" id="insert">
    </td>
  </tr>
  
  <br><br><br><br><br>


  <tr>
    <td>
      <input type="text" id="seat_seq" placeholder="������ ���̺� �ѹ� �Է�">
    </td>
  </tr>
  <tr>
    <td>
      <input type="button" value="���̺� ����" id="delete">
    </td>
  </tr>
<table id="addtable">
</table>
</body>

</html>
