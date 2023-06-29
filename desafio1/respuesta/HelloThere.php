<?php

//Leyendo el JSON
$jsonString = file_get_contents('last_year.json');

//Decodificando el archivo y generando un array asociativo
$data = json_decode($jsonString, true);

//Se guarda el numero de avistamiento por cada día
$avistamientos_por_dia = [];
$meses_prohibidos = ['12','01']; //Diciembre, enero

foreach ($data as $key => $value) {

        $dias_con_avistamientos_en_tupla = array();

        for ($i = $value[0]+1; $i <= $value[1]+1; $i++) {
            $dias_con_avistamientos_en_tupla[] = $i;
        }
        
        //Dias donde hubo un titan presente, tomando como antecedente el primer y ultimo día representado en la tupla, además considerando los dias intermedios
        foreach ($dias_con_avistamientos_en_tupla as $dia) {

            //Para cada dia de la dupla, incluyendo los dias de los extremos y los dias intermedios, se sumará un avistamiento.


            //Acción de acuerdo a si existe o no registro previo de avistamiento en array para este dia
            $avistamientos_por_dia[$dia] = isset($avistamientos_por_dia[$dia]) ? $avistamientos_por_dia[$dia] + 1 : 1;
            

        }

}

//Variables para utilizar en siguiente ciclo
$dia_optimo_menos_avistamiento = null;
$numero_avistamientos = null;

//Determinando el mejor día del año presente, excluyendo diciembre y enero
foreach ($avistamientos_por_dia as $numeroDia => $n_av) {

    //Determinando si dia es de diciembre y enero
    //Incluyendo solo numeros de este año, no del siguiente(menores a dia 366).

    //Generando fecha para comparación, asumiendo que los registros corresponden al año 2022
    $mesFecha = date("m", strtotime("2022-01-01" . " +" . ($numeroDia - 1) . " days"));

    if (!in_array($mesFecha, $meses_prohibidos) && $numeroDia < 366) {
        
        if ($dia_optimo_menos_avistamiento === null || $n_av < $numero_avistamientos) {
            $dia_optimo_menos_avistamiento = $numeroDia;
            $numero_avistamientos = $n_av;
        }
    }

}

$Fecha_especifica = date("d-m-Y", strtotime("2022-01-01" . " +" . ($dia_optimo_menos_avistamiento - 1) . " days"));

echo "Fecha especifica expedición: $Fecha_especifica<br>";
echo "Día optimo: $dia_optimo_menos_avistamiento<br>";
echo "Numero de avistamientos: $numero_avistamientos<br>";
echo "Se excluyen los registros de diciembre y enero<br>";

?>
