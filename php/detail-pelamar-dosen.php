<?php
	include "conn.php";

	$conn = connect();
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
			<li><a href="lihatlowongandosen.php">Daftar Lowongan</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="logout.php"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
		</ul>
	</div>
</nav>

<?php 
	$sql = "SELECT M.nama as nama, M.email as email, M.npm as npm, TM.nomortelepon as no_telp, M.waktu_kosong as waktu_kosong, M.bank as bank, M.norekening as no_rek 
			FROM LAMARAN L, MAHASISWA M, TELEPON_MAHASISWA TM 
			WHERE M.npm = L.npm AND M.npm = TM.npm AND L.idLamaran =".$_GET['idPelamar'];

	$result = pg_query($conn, $sql);
	if(!$result) {
		echo "An error occured.";
		exit;
	}

	$row = pg_fetch_row($result);
	$nama_mhs = $row[0];

	echo '
		<div class="container">
			<h2>Detail Pelamar</h2>
			<div class="table-responsive">
				<table class="table table-striped">
					<tr>
						<th class="col-xs-2">Nama</th>
						<td>'.$row[0].'</td>
					</tr>
					<tr>
						<th class="col-xs-2">Email</th>
						<td>'.$row[1].'</td>
					</tr>
					<tr>
						<th class="col-xs-2">NPM</th>
						<td>'.$row[2].'</td>
					</tr>
					<tr>
						<th class="col-xs-2">Telepon</th>
						<td>'.$row[3].'</td>
					</tr>
					<tr>
						<th class="col-xs-2">Waktu Kosong</th>
						<td>'.$row[4].'</td>
					</tr>
					<tr>
						<th class="col-xs-2">Detail Rekening</th>
						<td>'.$row[5].' - '.$row[6].'<br>
						a/n '.strtoupper($row[0]).'</td>
					</tr>
				</table>
			</div>
	';

	$sql1 = "SELECT mk.kode, mk.nama, lm.npm FROM lamaran lm, lowongan lo, kelas_mk k, mata_kuliah mk WHERE lm.idlowongan = lo.idlowongan AND lo.idkelasmk = k.idkelasmk AND k.kode_mk=mk.kode AND lm.idlamaran=".$_GET['idPelamar'];

	$result1 = pg_query($conn, $sql1);

	$row = pg_fetch_row($result1);
	$kode_mk = $row[0];
	$nama_mk = $row[1];
	$npm = $row[2];

	$nilai = "SELECT nilai from mhs_mengambil_kelas_mk a, kelas_mk b where a.idkelasmk=b.idkelasmk and b.kode_mk='".$kode_mk."' and a.npm='".$npm."'";

	$result2 = pg_query($conn, $nilai);

	$row = pg_fetch_row($result2);
	$nilai = $row[0];

	echo '<h2>Riwayat Akademis</h2>
			<div class="table-responsive">
				<table class="table table-striped">
					<tr>
						<td class="col-xs-1">'.$nama_mk.'</th>
						<td class="col-xs-1">'.$nilai.'</td>
					</tr>';

	$i = 1;
	while($result2 && $i < 4) {
		$prasyarat = "select nama, kode from mata_kuliah where prasyarat_dari='".$kode_mk."'";

		$result2 = pg_query($conn, $prasyarat);
		if($result2) {
			$row = pg_fetch_row($result2);
			$kode_mk = $row[1];
			$nama_mk = $row[0];
			if($nama_mk=='') $nama_mk = '-';
			echo '<tr>
							<td class="col-xs-1">Prasyarat '.$i.': '.$nama_mk.'</th>
							<td class="col-xs-1"></td>
						</tr>';
		}
		$i++;
	}

	echo '</table>
				</div>
				<p>Silahkan klik tombol <strong>Rekomendasikan</strong> jika ingin memilih <strong>'.$nama_mhs.'</strong> sebagai Asisten, Administrator akan menerima lamaran mahasiswa tersebut jika mahasiswa tersebut jika beban jam kerja yang dimiliki oleh mahasiswa tersebut masih memadai.</p>

				<button type="button" class="btn btn-primary">Rekomendasikan</button>
		</div>';
?>

</body>

<script src="bootstrap/js/bootstrap.min.js"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>

</html>