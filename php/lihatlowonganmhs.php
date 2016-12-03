<?php

	include "conn.php";
	
	if(!connect())
		die(pg_last_error());
		
?>	

<!DOCTYPE html>
<html lang="en">
 	<head>
  	<meta charset="utf-8">
  	<title>Sistem Informasi Asisten</title>
  	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css" media="all" />
	
	<script type="text/javascript" src="bootstrap/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
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
		    <h1>Daftar Lowongan Asisten</h1>
		    <h6><span style="color:red">Mahasiswa</span></h6>
		    <button type="button" class="btn btn-primary">Tambah</button>
		    <br><br>
		    <div class="table table-responsive">
				<table class="table table-striped">
	    			<thead>
	      				<tr>
	        				<th>Kode</th>
	        				<th>Mata Kuliah</th>
	        				<th>Pengajar</th>
	        				<th>Status Lowongan</th>
	        				<th>Jumlah Asisten Dibutuhkan</th>
	        				<th>Jumlah Pelamar</th>
	        				<th>Jumlah Pelamar Diterima</th>
	        				<th>Status Lamaran</th>
	        				<th>Action</th>
	      				</tr>
	    			</thead>
	    			<tbody>
	    				<tr>
	        				<th>UIST601014</th>
	        				<th>Matematika Dasar 1</th>
	        				<th>Walter Porter</th>
	        				<th>Tutup</th>
	        				<th>2</th>
	        				<th>5</th>
	        				<th>2</th>
	        				<th></th>
	        				<th><button type="button" class="btn btn-primary">Daftar</button></th>
	      				</tr>
	      				<tr>
	        				<th>CSIM602160</th>
	        				<th>Administrasi Bisnis</th>
	        				<th>Willie Morales</th>
	        				<th>Tutup</th>
	        				<th>8</th>
	        				<th>8</th>
	        				<th>8</th>
	        				<th></th>
	        				<th><button type="button" class="btn btn-primary">Daftar</button></th>
	      				</tr>
	      				<tr>
	        				<th>CSGE602070</th>
	        				<th>Basis Data</th>
	        				<th>Helen Woods</th>
	        				<th>Buka</th>
	        				<th>3</th>
	        				<th>3</th>
	        				<th>1</th>
	        				<th>Melamar</th>
	        				<th><button type="button" class="btn btn-primary">Batal</button></th>
	      				</tr>
	      				<tr>
	        				<th>CSIM603189</th>
	        				<th>Manajemen Proyek TI</th>
	        				<th>Randy Peters</th>
	        				<th>Buka</th>
	        				<th>6</th>
	        				<th>4</th>
	        				<th>4</th>
	        				<th></th>
	        				<th><button type="button" class="btn btn-primary">Daftar</button></th>
	      				</tr>
	      				<tr>
	        				<th>CSGE603291</th>
	        				<th>Metodologi Penelitian & Penulisan Ilmiah</th>
	        				<th>Shirley Ray</th>
	        				<th>Buka</th>
	        				<th>8</th>
	        				<th>4</th>
	        				<th>4</th>
	        				<th></th>
	        				<th><button type="button" class="btn btn-primary">Daftar</button></th>
	      				</tr>
					</tbody>
				</table>
			</div>
			<button class="btn-primary" onclick="prev()">Prev</button>
			<button class="btn-primary" onclick="next()">Next</button>
		</div>
	</body>
	<br><br>
	<footer id="copyright" class="container">
		<p>&copy; A05 SIAsisten. All rights reserved.</p>
	</footer>
</html>

<script>
	
	var limit = 10;
	function sort(){
	$.ajax({
		method: "get",
		url: 'lowonganmhs.php',
		data: {limit:limit},
		success: function(data){
			$(".table-responsive").html(data);
		}
	});
	}
	sort();
	
	
	function next(){
		if((limit-10)%10==0)
			limit += 10;
		sort();
	}
	
	function prev(){
		if(limit != 10)
			limit -= 10;
		sort();
	}

</script>
