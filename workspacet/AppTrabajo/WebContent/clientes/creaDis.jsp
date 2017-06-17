<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="ds" type="javax.sql.DataSource" scope="application" />
<jsp:useBean id="usuario" type="fast1617.trabajo.Usuario" scope="session" />

<%!
private static final int LON = 17;
private boolean compruebaMac(String cad) {
		boolean res = false;
		
		if (cad.length() == 17)
			res = true;

		for (int i = 0 ; i < 17 && res ; i++) {
			if (i == 2 || i == 5 || i == 8 || i == 11 || i == 14)
				res = cad.substring(i,i+1).matches("[:]");
			else
				res = cad.substring(i,i+1).matches("[a-fA-F0-9]");
		}
		
		return res;
	}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista de usuarios</title>
<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
<script src="../js/registro.js"></script>
</head>
<body>
    <jsp:include page="../cabecera.jsp" />

	<%
		//Usando DataSource ya definido en el servidor
		Connection conn = ds.getConnection();
		
		String mac = request.getParameter("mac");
		String tipo = request.getParameter("dis");
		
		// Comprobar parámetros 
		boolean errorDatos = false;
		boolean errorSql = false;
		boolean error = false;
		String mensaje = "";
		try {
			if (tipo == null || mac == null || tipo.isEmpty() || !compruebaMac(mac)) {
				//Error comprobación usuario
				errorDatos = true;
				mensaje = "Error en los datos del dispositivo.";
			} else {

				//Realizar la operación
				String sql = "INSERT INTO dispositivos (mac, id_usuario, id_tipo, estado) VALUES (?, ?, ?, false)";

				PreparedStatement st = conn.prepareStatement(sql);
				st.setString(1, mac);
				st.setString(2, usuario.getUsu());
				st.setString(3, tipo);
				int rows = st.executeUpdate();
				if (rows == 1) {
					mensaje = "Creación correcta.";
				} else {
					errorSql = true;
					mensaje = "Error creando el dispositivo";
				}
				st.close();

			}
		} catch (SQLException e) {
			mensaje = "Error creando el dispositivo";
			errorSql = true;
		}
		error = (errorDatos || errorSql);
	%>
	<div id="resultado">
		<%  
			String result = "";
			if(error)
				result = "error";
			else
				result = "exito";
		%>
		<h2 class=<%= result %>><%= mensaje %></h2>
		

	</div>


	<%
		conn.close();
	%>
	
	<%@include file="../pie.jsp" %>
</body>
</html>