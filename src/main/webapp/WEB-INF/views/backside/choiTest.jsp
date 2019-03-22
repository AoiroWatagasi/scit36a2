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
      $("#updtable").on('click', function() {
        upd();

      })

    });

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
        success: output()
      });
    }


    function output(resp) {

      var a = "";


      $.each(resp, function(index, item) {
        a += "<tr>";
        a += "<td>" + item.seat_seq + "</td>";
        a += "<td>" + item.comp_seq + "</td>";
        a += "<td>" + item.seat_id + "</td>";
        a += "</tr>";
      });
      $("#addtable").html(a);
      init();
    }

    function init() { // ���̺� ����� �������� �Լ�
      $.ajax({
        url: "selectseat",
        method: "GET",
        success: function(resp) {
          output
          //console.log(resp.stringify());
        }
      });
    }


    function del() {
      var seat_seq = $(".seat_seq").val();

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
      })
    }

    function upd() {
      var updseat = $("#updseat").val();
      if (updseat.trim().length == 0) {
        alert("�����Ϸ��� ������ ���̺� �ѹ��� �Է��ϼ�");
        return;
      }
      var newseat = $("#newseat").val();
      if (newseat.trim().length == 0) {
        alert("���ιٲ��� ����� �Է�")
        return;
      }

      var sd = {
        "updseat": updseat
      }
      $.ajax({
        url: "updateseat",
        method: "POST",
        data: sd,
        success: function(resp) {
          output
        }
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
  <table id="addtable">
  </table>
  <br><br><br><br><br><br><br><br><br><br>


  <tr>
    <td>
      <input type="text" class="seat_seq" placeholder="������ ���̺� �ѹ� �Է�">
    </td>
  </tr>
  <tr>
    <td>
      <input type="button" value="���̺� ����" id="delete">
    </td>
  </tr>


  <div id="seats">
  </div>


  <br><br><br><br>
  <tr>
    <td>
      <input type="text" id="updseat" placeholder="������ ���̺� �ѹ� �Է�">
      <input type="text" id="newseat" placeholder="���ιٲ��� �Է�">
    </td>
  </tr>
  <tr>
    <td>
      <input type="button" value="���̺����" id="updtable">
    </td>

  </tr>
</body>

</html>
