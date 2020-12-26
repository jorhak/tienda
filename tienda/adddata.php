<?php

	include 'conexion.php';
	
	$username = $_POST['username'];
	$password = $_POST['password'];
	$nivel = $_POST['nivel'];
	
	
	$connect->query("INSERT INTO usuarios (username,password,nivel) VALUES ('".$username."','".$password."','".$nivel."')")

?>