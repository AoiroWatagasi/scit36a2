<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
  <title>Insert title here</title>



  <script src="resources/jquery-3.3.1.js"></script>
  <script>
    $(function() {
      init();
      $("#insertnewmenubutton").on('click', function() {
        alert("test1");
        newmenu();
        alert("test2");
      })
      $("#deletebutton").on('click', function() {
        delmenu();
      })


    });

    function newmenu() {
      var menu_name = $("#menu_name").val();
      if (menu_name.trim().length == 0) {
        alert("�޴��̸�����Ϸ��� �Է��ϼ���");
        return;
      }
      var menu_sellFlag = $("#menu_sellFlag option:selected").val();
      if (menu_sellFlag == "�Ǹ���") {
        return 1;
        //menu_sellFlag==1;
      } else if (menu_sellFlag == "�Ǹ��߾ƴ�") {
        return 0;
        //menu_sellFlag==0;
      }

      var menu_price = $("#menu_price").val();
      if (menu_price.trim().length == 0) {
        alert("����� �����Է��Ұ�");
        return;
      } else if (isNaN(menu_price)) {
        alert("������ ���ڷ��Է�");
        return;
      }

      var menu_category = $("#menu_category option:selected").val();


      var menu = {
        "menu_name": menu_name,
        "menu_sellFlag": menu_sellFlag,
        "menu_price": menu_price,
        "menu_category": menu_category
      };

      $.ajax({
        url: "insertMenu",
        method: "POST",
        data: menu,
        success: output
      });

    }

    function output() {
      var a = "";
      a += "<tr>";
      a += "<th>�޴��̸�</th>";
      a += "<th>�Ǹ�����������</th>";
      a += "<th>���İ���</th>";
      a += "<th>����ī�װ�</th>";
      a += "</tr>";

      $.each(resp, function(index, item) {
        a += "<tr>";
        a += "<td>" + item.menu_name + "</td>";
        a += "<td>" + item.menu_sellFlag + "</td>";
        a += "<td>" + item.menu_price + "</td>";
        a += "<td>" + item.menu_category + "</td>";
        a += "</tr>";
      })
      $("#menuRegi").html(a);
    }



    function delmenu() {
      var menu_seq = $("#menu_seq").val();
      if (menu_seq.trim().length == 0) {
        alert("�����Ϸ��� �Է��ϼ���");
        return;
      }
      var senddata = {
        "menu_seq": menu_seq
      };
      $.ajax({
        url: "deleteMenu",
        method: "post",
        data: senddata,
        success: output
      });

    }

    function init() {
      $.ajax({
        url: "selectMenu",
        method: "POST",
        success: function(resp) {
          output
        }

      });

    }

  </script>



</head>

<body>

  <tr>
    <td>
      <input type="text" placeholder="����� �޴��̸� �Է�" id="menu_name">
      <select id="menu_sellFlag">
        <option value="�Ǹ���">�Ǹ���</option>
        <option value="�Ǹ��߾ƴ�">�Ǹ��߾ƴ�</option>
      </select>
      <input type="text" placeholder="ǰ���ǸŰ� �Է�" id="menu_price">
      <select id="menu_category">
        <option value="����">����</option>
        <option value="�Ľ�">�Ľ�</option>
        <option value="����Ʈ">����Ʈ</option>
        <option value="����">����</option>
      </select>
    </td>
    <td>
      <input type="button" value="�޴� �߰� ���Ȯ�ι�ư" id="insertnewmenubutton">
    </td>
  </tr>

  <br><br><br><br><br><br>
  <input type="text" placeholder="�޴������� ��ȣ�Է�" id="menu_seq">
  <input type="button" value="�޴� ���� ��ư" id="deletebutton">
  <table id="menuRegi">
  </table>


</body>

</html>
