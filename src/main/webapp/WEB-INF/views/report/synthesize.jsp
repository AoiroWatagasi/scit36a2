<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" type="image/png" href="imgs/favicon.png">
<title>MinnanoPOS</title>
<!--     Fonts and icons     -->
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css"
	rel="stylesheet">
<!-- Nucleo Icons -->
<link href="assets/css/nucleo-icons.css" rel="stylesheet" />
<!-- CSS Files -->
<link href="assets/css/black-dashboard.css?v=1.0.0" rel="stylesheet" />
<!--�߰��� ���� jquery ui for chartjs  -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="assets/js/core/jquery.min.js"></script>
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Google Maps Plugin    -->
<!-- Place this tag in your head or just before your close body tag. -->
<!-- Chart JS -->
<script src="assets/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="assets/js/black-dashboard.min.js?v=1.0.0"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<title>Insert title here</title>
</head>
<body class="white-content">
	<br>
	<div class="col-md-12">
		<h1 class="store" style="text-align: center;"></h1>
		<h2 style="text-align: center;">��ǥ�ڸ� : ȫ���� &emsp;&emsp; ��ȭ��ȣ :
			010-3899-1389</h2>
	</div>
	<div class="row">
		<!-- ��Ʈ�κ� -->
		<div class="col-md-11" style="margin: 0 auto;">
			<div class="card" style="height: 120px">
				<div class="card-body">
					<div class="tableMain"></div>
				</div>
			</div>
		</div>
		<div class="col-md-5" style="margin: 0 auto; padding-right: 0px">
			�޴����
			<div class="card" style="height: 330px">
				<div class="card-body">
					<canvas id="myChart" style="height :200px;width :auto;"></canvas>
					<div class="menuTable"></div>
				</div>
			</div>
		</div>
		<!-- ��Ʈ �κ� -->
		<div class="col-md-5" style="margin: 0 auto; padding-left: 0px">
			����/ī��
			<div class="card" style="height: 330px">
				<div class="card-body">
					<canvas id="myChart2" style="height:200px"></canvas>
					<div class="cardTable"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<!-- ��Ʈ�κ� -->
		<div class="col-md-11" style="margin: 0 auto;">
			�� ���
			<div class="card">
				<div class="card-body">
					<div class="customerTable"></div>
				</div>
			</div>
		</div>
		<!-- ��Ʈ �κ� -->
		<div class="col-md-11" style="margin: 0 auto;">
			�������
			<div class="card" style="height: 200px">
				<div class="card-body">
					<div class="tableMain2"></div>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
	// �������� here
	// �׷��� �׽�Ʈ (���ϸ���  �����Ϻ��� 1�ϱ����� ����)
	var data = [];
	var labels = [];
	var label = "�����";
	//map ���� index ��ȣ ���¿�
	var temp = 0;
	//�⺻�� ���̺�(ǥ) ���� �׽�Ʈ
	var chart;
	var ctx = document.getElementById('myChart').getContext('2d');

	var newchart;
	var newchart2;
	// load company name
	$(document).ready(function() {
		$.ajax({
			url : 'selectCompanyOne',
			method : 'POST',
			success : function(resp) {
				var output = '';
				output += resp.comp_name;
				$('#company_name').val('��ü�� : ' + resp.comp_name);
				$('#name').val(resp.comp_name);
				$('#company_phone').val('��ȭ��ȣ : ' + resp.comp_tel)
				$('.store').html(output);
			}
		})
		$.ajax({
			url : 'selectOwner',
			method : 'POST',
			success : function(resp) {
				$('#company_master').val('��ǥ�ڸ� : ' + resp.emp_name);
			}
		})
	})

	// call init onload
	$(document).ready(function() {
		//firstshow();
		//MainTable();
		//menuTable();
		//cardTable();
	})

	// initializing for output (first time output) 
	function firstshow() {

	}
	$(document).ready(function() {
		//����
		$.ajax({
			url : 'totalReport',
			method : 'POST',
			success : function(resp) {
			}
		});
		//�޴��޴�
		$.ajax({
			url : 'totalMenuReport',
			method : 'POST',
			success : function(resp) {
				menuTable(resp);
				firstshow();
			}
		});
		//�����
		$.ajax({
			url : 'totalGuestReport',
			method : 'POST',
			success : function(resp) {
				customerTable(resp);
			}
		})
		//��������
		$.ajax({
			url : 'totalIncomeReport',
			method : 'POST',
			success : function(resp) {
				MainTable(resp);
				MainTable2(resp);
			}
		})
		//���� /ī��
		$.ajax({
			url : 'totalCardReport',
			method : 'POST',
			success : function(resp) {
				cardTable(resp)
			}
		})
	});
	function MainTable(resp) {
		var output = '';
		output += '<table class="table table-hover">';
		output += '<thead><tr><th style="width :26%; text-align: center;">����(3����)</th>'
		output += '<th style="width :27%; text-align: center;">����(3����)</th>'
		output += '<th style="width :27%; text-align: center;">���ͷ�</th>'
		output += '<th style="width :20%; text-align: center;">��������</th></tr></thead>'
		//��
		var mae;
		var ji;
		var ek;
		var employee;
		$.each(resp, function(index, item) {
			if (index == 1) {
				mae = item.ALLPAYMENT;
				ji = item.EXPENSE_AMOUNT;
			}
		})
		ek = ((mae - ji) / mae) * 100;
		output += '<tr><td style="width :25%; text-align: center;">' + mae
				+ '��</td>'
		output += '<td style="text-align: center; width :25%;">' + ji
				+ '��</td>'
		output += '<td style="text-align: center; width :25%;">'
				+ ek.toFixed(1) + '%</td>'
		output += '<td style="width :25%; text-align: center;">7��</td></tr>'
		output += "</table>"
		$('.tableMain').html(output);
	}
	function menuTable(resp) {
		newchart = new Chart(ctx, {
			type : 'bar', //��Ʈ���
			data : {
				labels : [ '1��', '2��', '3��' ],
				datasets : [ {
					type : "bar",
					label : '�����',
					backgroundColor : '#3e95cd',
					borderColor : 'rgb(111, 111, 102),rgb(102, 255, 153)',
					data : [ 100, 200, 150 ],
				}, ]
			}
		});
		var output = '';
		output += '<table class="table table-hover">';
		output += '<thead><tr><th style="width :30%; text-align: center;">��������(3����)</th>'
		output += '<th style="width :30%; text-align: center;">���ܰ�(3����)</th>'
		output += '<th style="width :40%; text-align: center;">ȸ��</th></tr></thead>'
		$.each(resp, function(index, item) {
			if (index == 1) {
				mae = item.ALLPAYMENT;
				ji = item.EXPENSE_AMOUNT;
			}
		})
		//��
		output += '<tr><td style="width :30%; text-align: center;">1000000</td>'
		output += '<td style="text-align: center; width :30%;">700000</td>'
		output += '<td style="width :40%; text-align: center;">7��</td></tr>'
		output += "</table>"
		$('.menuTable').html(output);

	}
	function cardTable(resp) {
		var data = [];
		var ctx2 = document.getElementById('myChart2').getContext('2d');
		$.each(resp, function(index, item) {
			data[index] = item.PAYMENT_AMOUNT;
		})
		newchart2 = new Chart(ctx2, {
			type : 'pie', //��Ʈ���
			data : {
				labels : [ 'ī��', '����' ],
				datasets : [ {
					type : "pie",
					label : '�����',
					backgroundColor : '#3e95cd',
					borderColor : 'rgb(111, 111, 102)',
					data : data,
				}, ]
			}
		});
		var output = '';
		output += '<table class="table table-hover">';
		output += '<thead><tr><th style="width :30%; text-align: center;">����</th>'
		output += '<th style="width :40%; text-align: center;">�����</th>'
		output += '<th style="width :30%; text-align: center;">����</th></tr></thead>'
		//��
		output += '<tr><td style="width :30%; text-align: center;">ī��</td>'
		output += '<td style="text-align: center; width :40%;">' + data[0]
				+ '</td>'
		output += '<td style="text-align: center; width :30%;">'
				+ ((data[0] / (data[0] + data[1])) * 100).toFixed(1)
				+ '%</td></tr>'
		output += '<tr><td style="width :30%; text-align: center;">����</td>'
		output += '<td style="text-align: center; width :40%;">' + data[1]
				+ '</td>'
		output += '<td style="text-align: center; width :30%;">'
				+ ((data[1] / (data[0] + data[1])) * 100).toFixed(1)
				+ '%</td></tr>'
		output += "</table>"
		$('.cardTable').html(output);
	}
	function customerTable(resp) {
		var output = '';
		var nae = 0;
		var geck = 0;
		var spin = 0;
		var finalGeck = 0;
		output += '<table class="table table-hover">';
		output += '<thead><tr><th style="width :30%; text-align: center;">��������(3����)</th>'
		output += '<th style="width :30%; text-align: center;">���ܰ�(3����)</th>'
		output += '<th style="width :40%; text-align: center;">ȸ��</th></tr></thead>'
		$.each(resp, function(index, item) {
			nae += item.VISITORS;
			geck += item.GECK;
			spin += item.SPIN;
		})
		finalGeck = (geck / 3);
		//��
		output += '<tr><td style="width :30%; text-align: center;">' + nae
				+ ' ��</td>'
		output += '<td style="text-align: center; width :30%;">'
				+ finalGeck.toFixed(0) + ' ��</td>'
		output += '<td style="width :40%; text-align: center;">'
				+ spin.toFixed(0) + ' ȸ��</td></tr>'
		output += "</table>"
		$('.customerTable').html(output);
	}
	//���� 1/3/6 ����
	function MainTable2(resp) {
		var output = '';
		var nae = 0;
		var geck = 0;
		var spin = 0;

		var finalGeck = 0;
		output += '<table class="table table-hover">';
		output += '<thead><tr><th style="width :25%; text-align: center;">����</th>'
		output += '<th style="width :25%; text-align: center;">1����</th>'
		output += '<th style="width :25%; text-align: center;">3����</th>'
		output += '<th style="width :25%; text-align: center;">6����</th></tr></thead>'
		$.each(resp, function(index, item) {
			nae += item.VISITORS;
			geck += item.GECK;
			spin += item.SPIN;
		})
		finalGeck = (geck / 3);
		//��
		output += '<tr><td style="width :25%; text-align: center;">�����</td>'
		output += '<td style="text-align: center; width :25%;">�����</td>'
		output += '<td style="text-align: center; width :25%;">�����</td>'
		output += '<td style="width :25%; text-align: center;">'+ spin.toFixed(0) + ' ȸ��</td></tr>'
		output += "</table>"
		$('.tableMain2').html(output);
	}
</script>
</html>
