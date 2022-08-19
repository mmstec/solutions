<?php 
if ($_SERVER["REQUEST_METHOD"] == "POST"){ 
	header("Location: baixardanfe.php?arquivo=".$_POST["name"].".pdf");
}
?>
<?php
	// define variables and set to empty values
	$name = $erro = "";
	if ($_SERVER["REQUEST_METHOD"] == "POST") {
	  if (empty($_POST["name"])) {
			$erro = "<span class='glyphicon glyphicon-exclamation-sign'></span> Informação obrigatória";
	  } else {
		$name = test_input($_POST["name"]);
		if (!preg_match("/^[a-zA-Z ]*$/",$name)) {
		  $erro = "Somente letras e espaços em branco são permitidos"; 
		}
	  }
	}
?>
	

<!DOCTYPE HTML>  
<html>
<head>
	<meta http-equiv="refresh" content="300">
	<meta charset="utf-8">
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<title>GRUPO BARRETO | myDANFE</title>
	<meta name="author" content="MARCOS MORAIS">
	<link rel="icon" type="image/ico" href="favicon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-reset.css">
	<link rel="stylesheet" type="text/css" href="css/arjuna.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.login.css">
	<style>
	.error {color: #FF0000;}
	</style>
</head>
<body class="cl-default fixed" id="login" onselectstart="return false" oncontextmenu="return false" ondragstart="return false" onMouseOver="window.status='..message perso .. '; return true;" > 


	<div class="header-login">
		<div class="text-center" style="margin-top:-80px;">
			<a href="http://marcosmoraisjr.com.br" style="color:#fff"
				data-toggle="tooltip"
                data-placement="bottom"
                title="Desenvolvido por MARCOSMORAISJR ®">
				<h1><i class="glyphicon glyphicon-download"></i><br />&nbsp <i>my</i>DANFE</h1>
				</a>
		</div>
	</div>
	
	<div class="row" style="margin-left: 15px; margin-right: 15px">
	
    <div class="body-login">
		
		<h2>Digite a chave e pegue sua nota fiscal</h2>
		<form id="loginform" method="post" action="index.php" role="form" > 
			<div style="margin-bottom: 25px" class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-barcode"></i></span>
				<input 
				id="login-username" 
				name="name" 
				type="text" 
				class="form-control input-lg" 
				data-toggle="tooltip"
				data-placement="top"
				title="Digite a chave da sua nota fiscal e baixe seu DANFE"	
				value="<?php echo $name;?>" placeholder="Chave da nota fiscal">
			</div>
			<span class="error"><?php echo $erro;?></span>
			<input  
			type="submit"  
			name="" 
			value="BAIXAR DANFE"
			class="btn btn-success btn-block btn-lg btn-perspective" style="width:100%;">
			
		</form>
		
		<?php
			$types = array( 'pdf' );
			$path = 'p:/danfe/';
			$dir = new DirectoryIterator($path);
			$i=0;
			echo "<div class='container'><div class='row'>Últimas notas fiscais geradas<br />";
			foreach ($dir as $fileInfo) {
				$i++;
				$ext = strtolower( pathinfo( $fileInfo->getFilename(), PATHINFO_EXTENSION) );
				if( in_array( $ext, $types ) ) {
					if($i<=5) echo "<span style='font-size: 11px'>".substr($fileInfo->getFilename(), 0 ,strrpos($fileInfo->getFilename(), '.') + 0)."</span><br />";
				}
			}
			echo "</div></div>";
			?>
		<!--
		Abaixo, opções alternativas de terceiros para gerar seu DANFE a partir da chave: <br />
		<a href='https://www.webdanfe.com.br/'><b>WebDanfe</b></a> ou 
		<a href='https://www.danfeonline.com.br/'><b>DanfeOnline</b></a>
		/-->
			
	</div>
	</div>
	
	
	<div class="container">
		<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation" style="background-color:#2c3e50;">
			<br />
			<center>
				<a href="http://marcosmoraisjr.com.br" style="color:#fff"
				data-toggle="tooltip"
                data-placement="top"
                title="Desenvolvido por MARCOSMORAISJR ®">
				GRUPO VALDIR BARRETO
				</a>
			</center>
		</nav>
	</div>

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/arjuna.js"></script>
	<script>
	$(document).ready(function () {
		$('[data-toggle="tooltip"]').tooltip();
	});
	</script>
</body>
</html>