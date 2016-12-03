<?php
	//siapkan variable untuk koneksi DBMS
	
function connect(){	
	require "dbhost.php";
	
	if(!$database = pg_connect("host=$dbhost user=$dbuser password=$dbpass")) //syntax php koneksi ke DBMS PGSQL dengan parameter sesuai variable diatas
        die("Could not connect to database"); //jika gagal akan ditampilkan pesan error
    if(!$result = pg_query("set search_path to 'silutel';")) //query set search_path to <schema>
		die("Could not execute query"); //jika gagal akan ditampilkan pesan error
	return true;	
}
?>