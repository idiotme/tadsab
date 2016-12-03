<?php
	include "conn.php";

	$conn = connect();
	$id = $_GET['id'];
?>

<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
	<title>Detail Pelamar - SI Asisten</title>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css" media="all" />
</head>

<body>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Sistem Informasi Asistensi</a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="#">Daftar Lowongan</a></li>
			<li><a href="#">Profil Asisten</a></li>
			<li><a href="#">Log Asistensi</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</ul>
	</div>
</nav>

<?php 
	$sql = "SELECT M.nama as nama, M.email as email, M.npm as npm, TM.nomortelepon as no_telp, M.waktu_kosong as waktu_kosong, M.bank as bank, M.norekening as no_rek 
			FROM LAMARAN L, MAHASISWA M, TELEPON_MAHASISWA TM 
			WHERE M.npm = L.npm AND M.npm = TM.npm AND L.idLamaran = 180";

	$result = pg_query($conn, $sql);
	if(!$result) {
		echo "An error occured.";
		exit;
	}

	$row = pg_fetch_row($result);

	echo '
<div class="container">
	<h2>Detail Pelamar <span style="color:red"><i>(Admin)</i></span></h2>
	<div class="table-responsive">
		<table class="table table-striped">
			<tr>
				<th>Nama</th>
				<td>'.$row[0].'</td>
			</tr>
			<tr>
				<th>Email</th>
				<td>'.$row[1].'</td>
			</tr>
			<tr>
				<th>NPM</th>
				<td>'.$row[2].'</td>
			</tr>
			<tr>
				<th>Telepon</th>
				<td>'.$row[3].'</td>
			</tr>
			<tr>
				<th>Waktu Kosong</th>
				<td>'.$row[4].'</td>
			</tr>
			<tr>
				<th>Detail Rekening</th>
				<td>'.$row[5].' - '.$row[6].'<br>
				a/n '.$row[0].'</td>
			</tr>
		</table>
	</div>

		<h2>Riwayat Akademis</h2>
		<div class="table-responsive">
			<table class="table table-striped">
				<tr>
					<td class="col-xs-1">Persamaan Diferensial</th>
					<td class="col-xs-1">A</td>
				</tr>
				<tr>
					<td class="col-xs-1">Prasyarat 1: Matematika Dasar 2</th>
					<td class="col-xs-1"></td>
				</tr>
				<tr>
					<td class="col-xs-1">Prasyarat 2: Matematika Dasar 1</th>
					<td class="col-xs-1"></td>
				</tr>
				<tr>
					<td class="col-xs-1">Prasyarat 3: -</th>
					<td class="col-xs-1"></td>
				</tr>
			</table>
		</div>
		<p>Silahkan klik tombol <strong>Terima</strong> jika ingin memilih <strong>'.$row[0].'</strong> sebagai Asisten. Pastikan beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai.</p>

		<button type="button" class="btn btn-primary">Terima</button>
</div>
	';
?>

</body>

<script src="bootstrap/js/bootstrap.min.js"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>

</html>