<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menú administrador</title>
<link rel="stylesheet" type="text/css" href="css/estilo.css" />
<script src="js/registro.js"></script>

</head>
<body>
	<jsp:include page="../cabecera.jsp" />

	<div id="menu">
		<h1>Menú administrador</h1>
		<ul>
			<li><a href="clientes/dis.html">Añadir dispositivo</a></li>
			<li><a href="clientes/ver.jsp">Ver sus dispositivos</a></li>
			<li><a href="admin/usu.html">Editar usuarios</a></li>
			<li><a href="admin/modificar.jsp">Modificar estados de los dispositivos</a></li>
		</ul>
	</div>

	<%@include file="../pie.jsp" %>
</body>
</html>