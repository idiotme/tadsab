<?php 
	require "conn.php";
	session_start();
	if(!isset($_SESSION["username"])) {
		header("Location: login.php");
	}

	$username = "louis.carter";//$_SESSION["username"];
?>

<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
	<title>Data Profil - SI Asisten</title>
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
			<li class="active"><a href="#">Profil Asisten</a></li>
			<li><a href="#">Log Asistensi</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</ul>
	</div>
</nav>

<?php 
	if(isset($_POST['password'])) {
		$sql1 = "update mahasiswa set password=".$_POST['password'].", email_aktif=".$_POST['email-aktif'].", waktu_kosong=".$_POST['waktu-kosong'].", bank=".$_POST['bank'].", norekening=".$_POST['no-rek'].", url_mukatab=".$_POST['url-mukatab'].", url_foto=".$_POST['url-foto']." where username=".$username;
		$result1 = pg_query($conn, $sql1);
	}
	
	$sql = "select * from mahasiswa where username='".$username."'";
	$result = pg_query($conn, $sql);
	$row = pg_fetch_row($result);
	print_r($row);;

?>

<div class="container">
	<h2>Data Profils</h2>
		<div class="table-responsive">
			<table class="table">
				<div class="form-group" method="post">
					<button type="submit" class="btn btn-primary">Simpan</button>
					<button type="button" class="btn btn-primary">Batal</button>

					<tr>
						<th class="col-xs-3">NPM</th>
						<td><?php echo $row[0];?></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Nama</th>
						<td>Louis Carter</td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Username</th>
						<td>louis.carter</td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Password</th>
						<td><input id="password" type="password" class="form-control" name="password" placeholder="Password" value="$row[3]" required></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">E-mail</th>
						<td>louis.carter@ui.ac.id</td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">E-mail Aktifs</th>
						<?php 
							print_r($row);
							echo '
						<td><input id="email-aktif" type="email" class="form-control" name="email-aktif" placeholder="E-mail Aktif" value="'.$row[5].'" required></td>
						<td class="col-xs-2" />';
						?>
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Waktu Kosong</th>
						<td><textarea id="waktu-kosong" class="form-control" name="waktu-kosong" placeholder="Waktu Kosong" required>Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22</textarea></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">No. Telp</th>
						<td><input id="no-telp" type="tel" class="form-control" name="no-telp" placeholder="No. Telp." value="081259239689" required></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Bank</th>
						<td><input id="bank" type="text" class="form-control" name="bank" placeholder="Bank" value="BNI" required></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">No. Rekening</th>
						<td><input id="no-rek" type="text" class="form-control" name="no-rek" placeholder="No. Rekening" value="1000596984" required></td>
						<td class="col-xs-2" />
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Halaman Muka Buku Tabungan (*.jpg)</th>
						<td>
						<img src="http://dummyimage.com/241x154.png/ff4444/ffffff" alt="butab"> <br>
						<input id="url-mukatab" type="url" class="form-control" name="url-mukatab" placeholder="Halaman Muka Buku Tabungan (*.jpg)" value="http://dummyimage.com/241x154.png/ff4444/ffffff" required></td>
						<td class="col-xs-2"><button type="button" class="btn btn-primary">Browse</button></td>
					</tr>
				</div>
				<div class="form-group">
					<tr>
						<th class="col-xs-3">Foto (*.jpg)</th>
						<td><img src="https://robohash.org/veleumtenetur.png?size=50x50&set=set1" alt="foto"> <br>
						<input id="url-foto" type="url" class="form-control" name="url-foto" placeholder="Foto (*.jpg)" value="https://robohash.org/veleumtenetur.png?size=50x50&set=set1" required></td>
						<td class="col-xs-2"><button type="button" class="btn btn-primary">Browse</button></td>
					</tr>
				</div>
			</table>
		</div>
</div>


</body>

<script src="bootstrap/js/bootstrap.min.js"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>

</html>