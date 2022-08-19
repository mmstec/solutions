
<?php
// Aqui vale qualquer coisa, desde que seja um diretório seguro :)
define('DIR_DOWNLOAD', '//192.168.10.222/dados/pdf/');
// Vou dividir em passos a criação da variável $arquivo pra ficar mais fácil de entender, é possível juntar tudo
$arquivo = $_GET['arquivo'];
// Retira caracteres especiais
$arquivo = filter_var($arquivo, FILTER_SANITIZE_STRING);
// Retira qualquer ocorrência de retorno de diretório que possa existir, deixando apenas o nome do arquivo
$arquivo = basename($arquivo);
// Aqui a gente só junta o diretório com o nome do arquivo
$caminho_download = DIR_DOWNLOAD . $arquivo;
// Verificação da existência do arquivo

if (!file_exists($caminho_download))
   die(' 
			
			<!DOCTYPE HTML>  
			
			<html>
			<head>
			<meta charset="utf-8">
			<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
			<title>GRUPO BARRETO | myFILES</title>
			<meta name="author" content="MARCOS MORAIS">
			<link rel="icon" type="image/ico" href="favicon.ico">
			<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
			<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
			<link rel="stylesheet" type="text/css" href="css/bootstrap-reset.css">

			<link rel="stylesheet" type="text/css" href="css/bootstrap.login.css">
			<style>
			.error {color: #FF0000;}
			.col-centered{
			float: none;
			margin: 0 auto;
			}
			</style>
			</head>
			<body>

			<br />
			<div class="container-fluid">
			<div class="row-fluid">
			<div class="col-lg-8 col-centered">
			<h3>Ops! Chave informada não foi localizada. <br /><br /> CHAVE: ['.substr($arquivo,0,-4).'] </h3>
			<a href="../www.pdf" class="btn btn-success btn-block btn-lg btn-perspective">TENTAR NOVAMENTE</a> 
			</div>
		
			<script src="js/jquery-1.11.1.min.js"></script>
			<script src="js/bootstrap.min.js"></script>
			<script src="js/arjuna.js"></script>
			
		</body>
		</html>

		   ');
		header("Content-type: application/pdf");
		// Indica o nome do arquivo como será "baixado". Você pode modificar e colocar qualquer nome de arquivo
		//header('Content-disposition: attachment; filename="'.$arquivo.'";'); 
		header("Content-Length: " . filesize($caminho_download));
		// Indica ao navegador qual é o tamanho do arquivo
		header('Content-Length: '.filesize($caminho_download));
		// Busca todo o arquivo e joga o seu conteúdo para que possa ser baixado
		readfile($caminho_download);
exit;
?>



