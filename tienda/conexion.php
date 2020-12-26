<?php

$connect = new mysqli("localhost","root","toor","tienda");

if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}
