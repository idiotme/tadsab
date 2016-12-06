<!DOCTYPE html>
<html lang="en">
 	<head>
  	<meta charset="utf-8">
  	<title>Sistem Informasi Asisten</title>
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
			<h1>Tambah Lowongan</h1>
			<br><br>
    		<div class="table-responsive">
	       		<table class="table table-striped">
	        		<tbody>
			            <tr>
			              <th>Term</th>
			              <td>Genap, 2016</td>
			            </tr>
			            <tr>
			              <th>Mata Kuliah</th>
			              <td>CSGE602070 Basis Data</td>
			            </tr>
			            <tr>
			              <th>Status</th>
			              <td><input type="radio" name="gender" value="male"> Buka
			              <br> <input type="radio" name="gender" value="female"> Tutup<br></td>
			            </tr>
			            <tr>
			              <th>Jumlah Asisten Dibutuhkan</th>
			              <td><input type="number" name="jmlasisten"></td>
			            </tr>
			            <tr>
			              <th>Syarat Tambahan</th>
			              <td><textarea name="syarat"></textarea></td>
			            </tr>
			            <tr>
			              <th>Daftar Pengajar</th>
			              <td>Willie Morales <br> Helen Woods</td>
			            </tr>
			          </tbody>
		        </table>
      		</div>
      		<button type="button" class="btn btn-primary">Simpan</button>
      		<button type="button" class="btn btn-primary">Batal</button>
		</div>
	</body>
	<br><br>
	<footer id="copyright" class="container">
		<p>&copy; A05 SIAsisten. All rights reserved.</p>
	</footer>
</html>