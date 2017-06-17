<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<% 
if (session.getAttribute("usuario") != null)
	response.sendRedirect("menu");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reparaciones - FAST</title>
<link rel="stylesheet" type="text/css" href="css/estilo.css" />
<script src="js/conmutaAcceso.js"></script>
<script src="js/registro.js"></script>
</head>
<body>
	<noscript>
		<p>
			<span class="acceso"> Esta p&aacute;gina necesita JavaScript
				para funcionar </span>
		</p>
	</noscript>
	<script type="text/javascript">
		//Mostramos un texto u otro depediendo si JavaScript esta activo
		document.write("<a onclick='muestraFormAcceso()'>");
		document.write("<span class='acceso'>");
		document.write("Acceder");
		document.write("</span></a>");
	</script>
	<div id="formacceso">
		<form action="menu" method="post">
			<p>
				<label for="usu">Usuario:</label><br /> <input type="text"
					name="usu" size="10" id="usu" />
			</p>
			<p>
				<label for="contra">Clave:</label> <br /> <input type="password"
					name="contra" size="14" id="contra" />
			</p>
			<p>
				<input class="boton" type="submit" name="entrar" value="Entrar" />
				&nbsp;&nbsp; <input class="boton" type="button" name="cancelar"
					value="Cancelar" onclick="ocultaFormAcceso()" />
			</p>
		</form>
	</div>
	<div id="bienvenida">
		<h1>Bienvenido</h1>
		<h1>Reparaciones - FAST</h1>

		<h3>Acceda con su usuario y clave</h3>

	</div>

	<%@include file="pie.jsp"%>
</body>
</html>