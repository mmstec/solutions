
<?php
// Aqui vale qualquer coisa, desde que seja um diretório seguro :)
define('DIR_DOWNLOAD', '//servidororacle/p/danfe/');
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
			<title>MMSTEC | DANFE</title>
			<meta name="author" content="MARCOS MORAIS">
			<link rel="icon" type="image/ico" href="favicon.ico">
			<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
			<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
			<link rel="stylesheet" type="text/css" href="css/bootstrap-reset.css">
			<link rel="stylesheet" type="text/css" href="css/arjuna.css">
			<link rel="stylesheet" type="text/css" href="css/bootstrap.login.css">
			<style>
			.error {color: #FF0000;}
			.col-centered{
			float: none;
			margin: 0 auto;
			}
			</style>
			</head>
			<body class="cl-default fixed" id="login" onselectstart="return false" oncontextmenu="return false" ondragstart="return false"; return true;" > 

			<div class="row">
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
			</div>
			
			<div class="row">					
				<div class="body-login">
					<h3>Ops! Chave informada não foi localizada. <br /><br /> CHAVE: ['.substr($arquivo,0,-4).'] </h3>
					<a href="../www.danfe" class="btn btn-success btn-block btn-lg btn-perspective">TENTAR NOVAMENTE</a> 
				</div>
			</div>
			
			<div class="row">
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
			
		</body>
		</html>

		   ');
//header('Content-type: octet/stream');
// Indica o nome do arquivo como será "baixado". Você pode modificar e colocar qualquer nome de arquivo
//header('Content-disposition: attachment; filename="'.$arquivo.'";'); 
// Indica ao navegador qual é o tamanho do arquivo
//header('Content-Length: '.filesize($caminho_download));
// Busca todo o arquivo e joga o seu conteúdo para que possa ser baixado
//readfile($caminho_download);
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



