<?php

    include 'conexion.php';

    $username = $_POST['username'];
    $password = $_POST['password'];

    $consultar=$connect->query("SELECT * FROM usuarios WHERE username='".$username."' and password='".$password."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);

    ?>