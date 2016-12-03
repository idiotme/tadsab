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

<div class="container">
	<h2>Detail Pelamar <span style="color:red"><i>(Dosen)</i></span></h2>
	<div class="table-responsive">
		<table class="table table-striped">
			<tr>
				<th>Nama</th>
				<td>Louis Carter</td>
			</tr>
			<tr>
				<th>Email</th>
				<td>louis.carter@ui.ac.id</td>
			</tr>
			<tr>
				<th>NPM</th>
				<td>1537676327</td>
			</tr>
			<tr>
				<th>Telepon</th>
				<td>081259239689</td>
			</tr>
			<tr>
				<th>Waktu Kosong</th>
				<td>Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22</td>
			</tr>
			<tr>
				<th>Detail Rekening</th>
				<td>BNI - 1000596984<br>
				a/n LOUIS CARTER</td>
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
		<p>Silahkan klik tombol <strong>Rekomendasikan</strong> jika ingin memilih <strong>Louis Carter</strong> sebagai Asisten, Administrator akan menerima lamaran mahasiswa tersebut jika mahasiswa tersebut jika beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai.</p>

		<button type="button" class="btn btn-primary">Rekomendasikan</button>
</div>


</body>

<script src="bootstrap/js/bootstrap.min.js"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>

</html>