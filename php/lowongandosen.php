<?php
	include "conn.php";
	
	if(!connect())
		die(pg_last_error());
	
	$limit= $_GET['limit'];
	$min = $limit - 10;
		
	$query = "SELECT K.kode_mk, M.nama AS MataKuliah, D.nama, L.status AS Status, L.jumlah_asisten, L.jumlah_pelamar, L.jumlah_diterima
				FROM siasisten.lowongan L, siasisten.kelas_mk K, siasisten.mata_kuliah M, siasisten.dosen D
				WHERE L.idkelasmk=K.idkelasmk AND K.kode_mk=M.kode AND L.nipdosenpembuka=D.nip AND D.nama='Helen Woods' order by M.nama offset " . $min . " limit 10";
				
	if(!$res = pg_query($query))
		die(pg_last_error());
		
	$result = "";
	
		$result = $result . "<div class='table table-responsive'>
					<table class='table table-striped'>
						<thead>
							<tr>
								<th>Kode</th>
								<th>Mata Kuliah</th>
								<th>Dosen Pengajar</th>
								<th>Status</th>
								<th>Jumlah Asisten Dibutuhkan</th>
								<th>Jumlah Pelamar</th>
								<th>Jumlah Pelamar Diterima</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>"; 
	
	while($line =pg_fetch_row($res)) {
	
		$result = $result . "<tr>\n";
		
		$result = $result . "<td>$line[0]</td>\n";
		$result = $result . "<td>$line[1]</td>\n";
		$result = $result . "<td>$line[2]</td>\n";
		
		if ($line[3]=='f')
			$col_value = "Tutup";
		else
			$col_value = "Buka";
		$result = $result . "<td>$col_value</td>\n";
		
		$result = $result . "<td>$line[4]</td>\n";
		$result = $result . "<td>$line[5]</td>\n";
		$result = $result . "<td>$line[6]</td>\n";
		$result = $result . "<td><button>Edit</button><button>Delete</button></td>\n";
		
		$result = $result . "</tr>\n";
	}
	
	$result = $result . "</tbody></table></div>\n";
	pg_close();
	echo $result;
?> 