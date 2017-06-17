<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:useBean id="ds" type="javax.sql.DataSource" scope="application" />
<jsp:useBean id="paramUsu" class="fast1617.trabajo.Usuario" scope="page" />

<jsp:setProperty property="usu" name="paramUsu" param="usu"/>
<jsp:setProperty property="contra" name="paramUsu" param="contra"/>
<jsp:setProperty property="esAdmin" name="paramUsu" value="false"/>

<%!private static final int LON_MIN = 8;
	private static final int LON_MAX = 15;

	private boolean compruebaContra(String pass) {
		boolean res = false;
		
		if (!(pass.length() < LON_MIN) && !(pass.length() > LON_MAX) && pass.matches(".*\\d.*")
				&& pass.matches(".*[A-Z].*") && pass.matches(".*[a-z].*"))
			res = true;

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
    <jsp:include page="../cabecera.jsp" />

	<%
		//Usando DataSource ya definido en el servidor
		Connection conn = ds.getConnection();

		// Comprobar parámetros 
		boolean errorDatos = false;
		boolean usuExiste = false;
		boolean errorSql = false;
		boolean error = false;
		String mensaje = "";
		String sql;
		try {
			if (paramUsu.getUsu().length() < 1 || paramUsu.getUsu().length() > 10
					|| !compruebaContra(paramUsu.getContra())) {
				//Error comprobación usuario
				errorDatos = true;
				mensaje = "Error en los datos del usuario.";
			} else {
				//Obtener si el usuario existe
				sql = "SELECT id_usuario FROM usuarios WHERE id_usuario=?";

				PreparedStatement st = conn.prepareStatement(sql);
				st.setString(1, request.getParameter("usu"));
				ResultSet rs = st.executeQuery();
				if (rs.next()) {
					usuExiste = true;
				}
				rs.close();
				st.close();

				//Realizar la operación
				if (usuExiste) {
					//Actualizar contraeña de usuario
					sql = "UPDATE usuarios SET password=? WHERE id_usuario=?";


					st = conn.prepareStatement(sql);
					st.setString(1, paramUsu.getContra());
					st.setString(2, paramUsu.getUsu());
					int rows = st.executeUpdate();
					if (rows == 1) {
						mensaje = "Modificación correcta.";
					} else {
						errorSql = true;
						mensaje = "Error modificando la contraseña";
					}
					st.close();
				} else {
					//Crear usuario con su contraseña y no es administrador
					sql = "INSERT INTO usuarios (id_usuario, password, es_admin) VALUES (?, ?, false)";
					
					st = conn.prepareStatement(sql);
					st.setString(2, paramUsu.getContra());
					st.setString(1, paramUsu.getUsu());
					int rows = st.executeUpdate();
					if (rows == 1) {
						mensaje = "Creación correcta.";
					} else {
						errorSql = true;
						mensaje = "Error creando el usuario";
					}
					st.close();
				}
			}
		} catch (SQLException e) {
			mensaje = "Error creando el usuario";
			
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

	<div id="listado">
		<%
			try {
				//Obtener usuarios ordenados por su identificador
				sql = "SELECT * FROM usuarios ORDER BY id_usuario";

				PreparedStatement st = conn.prepareStatement(sql);

				ResultSet rs = st.executeQuery();
		%>
		<h2>Listado de usuarios existentes:</h2>
		<table id="lista">
			<tr>
				<th>Nombre del usuario</th>
			</tr>
			<%
				while (rs.next()) {
			%>
			<tr>
				<td>
					<%= rs.getString(1) %>
				</td>

			</tr>

			<%
				}

					rs.close();
					st.close();

				} catch (SQLException e) {
					out.println("Excepción SQL Exception: " + e.getMessage());
				}
			%>
		</table>
	</div>
	<%
		conn.close();
	%>

	<%@include file="../pie.jsp" %>
</body>
</html>