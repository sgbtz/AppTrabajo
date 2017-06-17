<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menú clientes</title>
<link rel="stylesheet" type="text/css" href="css/estilo.css" />
<script src="js/registro.js"></script>

</head>
<body>
	<jsp:include page="../cabecera.jsp" />

	<div id="menu">
		<h1>Menú clientes</h1>
		<ul>
			<li><a href="clientes/dis.html">Añadir dispositivo</a></li>
			<li><a href="clientes/ver.jsp">Ver sus dispositivos</a></li>
		</ul>
	</div>

	<%@include file="../pie.jsp" %>
</body>
</html>