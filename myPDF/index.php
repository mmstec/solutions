<?php 
if ($_SERVER["REQUEST_METHOD"] == "POST"){ 
	header("Location: visualizar.php?arquivo=".$_POST["name"]);
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
<?php 
$nomedosistema="Arquivos para Impressão";  //NOME DO SISTEMA
?>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html lang="pt-br">
<head>
	<meta http-equiv="refresh" content="300">
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='pragma' content='no-cache'>

	<meta charset="utf-8">
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<title>GRUPO BARRETO | myPDF´s</title>
	<meta name="author" content="MARCOS MORAIS">
	<link rel="icon" type="image/ico" href="favicon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-reset.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.login.css">
	<link rel="stylesheet" type="text/css" href="css/arjuna.css">
	<style>
	.no-gutters {
		margin-right: 10px;
		margin-left: 10px;

  > .col,
  > [class*="col-"] {
    padding-right: 0;
    padding-left: 0;
	background-color: powderblue;
  }
}
	</style>

	
	
</head>
<!--<body class="cl-default fixed" id="login" onselectstart="return false" oncontextmenu="return false" ondragstart="return false" onMouseOver="window.status='..message perso .. '; return true;" > /-->

<div class="row" style="margin-left: 15px; margin-right: 15px">
<body id="login">
	
	<div class="header-login">
		<div class="text-center" style="margin-top:-80px;">
			<a href="http://marcosmoraisjr.com.br" style="color:#fff"
				data-toggle="tooltip"
                data-placement="bottom"
                title="Desenvolvido por MARCOSMORAISJR ®">
				<h1><i class="glyphicon glyphicon-download"></i><br />&nbsp <i>my</i>PDF</h1>
				</a>
		</div>
	</div>
	
	<div class="row" style="margin-left: 10px; margin-right: 10px">
    <div class="body-login">
		
			
		<?php
			$path = "e:/pdf/";
			$diretorio = dir($path);
			echo "<br />";
			echo "<h2>Lista de Arquivos PDF para Impressão</h2><br />";
			echo "<span>¹Os arquivos ficam disponíveis temporariamente.</span><br />";
			echo "<span>²Pressione CRTL+F para pesquisar.</span><br />";
			echo "<span>³Para imprimir, clicar no ícone da impressora <img src='.\img\icons\impressora.png' alt='Imprima' width='16' height='16'> a esquerda do nome do arquivo desejado.</span>";
			echo "<hr />";
			while($arquivo = $diretorio -> read()){
				if(strtolower($arquivo) == '$recycle.bin' || $arquivo == '.' || $arquivo == '..' || $arquivo =='System Volume Information' || $arquivo =='recycle') continue;                     
					?>
					
					<!-- 
					esta parte é para o caso de querer usar form (post) para baixar/visualizar o pdf
					<form method="post" action="index.php" role="form" > 
						<input type="hidden" name="name" value="<?php echo $arquivo;?>" />
						<button class="glyphicon glyphicon-eye-open"></button>	
						<button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></button>		
						<button class="btn btn-default btn-sm"><span class="glyphicon glyphicon-print" aria-hidden="true"></span></button>			
					</form> -->
				
					<?php
					echo "<a href='visualizar.php?arquivo=".$path.$arquivo."'><span style='font-size: 12px' class='glyphicon glyphicon-print'></span></a>&nbsp;&nbsp;";
					echo "<a href='baixar.php?arquivo=".$path.$arquivo."'><span style='font-size: 12px' class='glyphicon glyphicon-download'>&nbsp;".substr($arquivo, 0 ,strrpos($arquivo, '.') + 0)."</span></a><br />";
					/*echo "<a href='baixar.php?arquivo=".$path.$arquivo."'><img src='.\img\icons\impressora.png' alt='Imprima' width='16' height='16'></a> ".$arquivo."<br />";*/
					/*echo "<a href='".$path.$arquivo."'><img src='.\img\icons\impressora.png' alt='Imprima' width='16' height='16'></a> ".$arquivo."<br /> ";*/
					
			}
			$diretorio -> close();
		?>
		
	
	</div>
	</div>
	
	<div class="container">
		<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation" style="background-color:#2c3e50;">
			<br />
			<center>
				<a href="https://www.linkedin.com/in/marcosmoraisjr/" style="color:#fff"
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