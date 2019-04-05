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
      selectPOStwo();

      $(".upd").on('click', function() {
        updatePOStwo();
      })
    })



    function output(resp) {

      var a = "";
      a += "<tr>";
      a += "<th>" + "���̺��Ϸù�ȣ" + "</th>";
      a += "<th>" + "�մԼ�" + "</th>";
      a += "<th>" + "sales_start" + "</th>";
      a += "<th>" + "sales_end" + "</th>";
      a += "<th>" + "�޸�" + "</th>";
      a += "<th>" + "�޴��Ϸù�ȣ" + "</th>";
      a += "<th>" + "�޴���ȣ" + "</th>";
      a += "<th>" + "�޴�ī�װ�" + "</th>";
      a += "<th>" + "�ֹ�����" + "</th>";
      a += "<th>" + "����" + "</th>";
      a += "</tr>";

      $.each(resp, function(index, item) {
        a += "<tr>";
        a += "<td>" + item.seat_seq + "</td>";
        a += "<td>" + item.sales_visitors + "</td>";
        a += "<td>" + item.sales_start + "</td>";
        a += "<td>" + item.sales_end + "</td>";
        a += "<td>" + item.sales_memo + "</td>";
        a += "<td>" + item.menu_seq + "</td>";
        a += "<td>" + item.menu_name + "</td>";
        a += "<td>" + item.menu_category + "</td>";
        a += "<td>" + item.sales_order + "</td>";
        a += "<td>" + item.sales_discount + "</td>";
        a += "<td><input type='button' regi-value=" + item.menu_seq + " class='regi' value='�ֹ�������ư'></td>";
        a += "<td><input type='button' del-value=" + item.menu_seq + " class='del' name='menu_seq' value='������ư'></td>";
        a += "<td><input type='button' upd-value=" + item.seat_seq + " class='upd' name='seat_seq' value='������ư'></td>";
        a += "</tr>";
      });
      $("#selectOrder").html(a);
      $(".regi").on('click', regi);
      $(".del").on('click', clickDel);
      $(".upd").on('click', updatePOStwo);

    }

    function regi() {
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
        "m_seq": m_seq,
        "seat_seq": seat_seq,
        "sales_memo": sales_memo,
        "menu_seq": menu_seq,
        "sales_order": sales_order,
        "sales_discount": sales_discount,
        "sales_visitors": sales_visitors
      };
      $.ajax({
        url: "insertSasSad",
        method: "POST",
        data: d,
        success: output
      });

    }

    function selectPOStwo() {
      $.ajax({
        url: "selectPOStwo",
        method: "POST",
        success: function(resp) {
          output(resp);
        }
      });
    }


    function clickDel() { //����Ʈ�� �ִ� ������ư�� Ŭ�� ������ �����Ǵ� ���
      var d_seq = $(this).attr("del-value");
      alert(d_seq);
      var d = {
        "d_seq": d_seq
      };

      $.ajax({
        url: "deleteSasSadPay",
        method: "POST",
        data: d,
        success: output
      });
    }

    function updatePOStwo() {
      //alert("��������");
      var updatePOStwo = $(this).attr("upd-value");
      var upd = {
        "updatePOStwo": updatePOStwo
      };
      alert("����1");
      $.ajax({
        url: "updatePOStwo",
        method: "POST",
        data: upd,
        success: function(resp) {
          var a = "";
          a += "<tr>";
          a += "<th>" + "���̺��Ϸù�ȣ" + "</th>";
          a += "<th>" + "�մԼ�" + "</th>";
          a += "<th>" + "sales_start" + "</th>";
          a += "<th>" + "sales_end" + "</th>";
          a += "<th>" + "�޸�" + "</th>";
          a += "<th>" + "�޴��Ϸù�ȣ" + "</th>";
          a += "<th>" + "�޴���ȣ" + "</th>";
          a += "<th>" + "�޴�ī�װ�" + "</th>";
          a += "<th>" + "�ֹ�����" + "</th>";
          a += "<th>" + "����" + "</th>";
          a += "</tr>";
          alert("����2");
          $.each(resp, function(index, item) {
            if (upd == item.sales_state_seq) {
              a += "<tr>";
              a += "<td>" + item.sales_memo + "</td>";
              a += "<td>" + item.sales_visitors + "</td>";
              a += "<td>" + item.sales_discount + "</td>";
              a += "<td>" + item.sales_end + "</td>";
              a += "<td>" + item.sales_order + "</td>";
              a += "<td>" + item.menu_seq + "</td>";
              a += "<td>" + "�޴��̸�" + "</td>";
              a += "<td>" + "�޴�ī�װ�" + "</td>";
              a += "<td>" + "��ǰ����" + "</td>";
              a += "<td>" + "����" + "</td>";
              a += "<td><input type='button' regi-value=" + item.menu_seq + " class='regi' value='�ֹ�������ư'></td>";
              a += "<td><input type='button' del-value=" + item.menu_seq + " class='del' name='menu_seq' value='������ư'></td>";
              a += "<td><input type='button' upd-value=" + item.seat_seq + " class='upd' name='seat_seq' value='������ư'></td>";
              a += "</tr>";
            } else {
              a += "<tr>";
              a += "<td>" + item.seat_seq + "</td>";
              a += "<td>" + item.sales_visitors + "</td>";
              a += "<td>" + item.sales_start + "</td>";
              a += "<td>" + item.sales_end + "</td>";
              a += "<td>" + item.sales_memo + "</td>";
              a += "<td>" + item.menu_seq + "</td>";
              a += "<td>" + item.menu_name + "</td>";
              a += "<td>" + item.menu_category + "</td>";
              a += "<td>" + item.sales_order + "</td>";
              a += "<td>" + item.sales_discount + "</td>";
              a += "<td><input type='button' regi-value=" + item.menu_seq + " class='regi' value='�ֹ�������ư'></td>";
              a += "<td><input type='button' del-value=" + item.menu_seq + " class='del' name='menu_seq' value='������ư'></td>";
              a += "<td><input type='button' upd-value=" + item.seat_seq + " class='upd' name='seat_seq' value='������ư'></td>";
              a += "</tr>";
            }
          })
          $("#selectOrder").empty();
          $("#selectOrder").html(a);
          /* $(".upd").on('click',updatePOStwo);
          alert("����3"); */
        }
      })
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
    <td>�� �ݾ� : ��</td><br><br>

    <td><input type="text" id="seat_seq" name="seat_seq" placeholder="�ڸ���ȣ"></td>
    <td><input type="text" id="sales_visitors" name="sales_visitors" placeholder="����Է�"></td><br>
    <td><input type="text" id="menu_seq" name="menu_seq" placeholder="�޴���ȣ"></td>
    <td><input type="text" id="sales_discount" name="sales_discount" placeholder="����,����"> <input type="text" placeholder="�ֹ�����" id="sales_order" name="sales_order"><input type="text" id="sales_memo" name="sales_memo" placeholder="�޸��Է�">6�� �Է��� ���� �ֹ�������ư Ŭ��</td><br>

  </tr>




</body>

</html>
