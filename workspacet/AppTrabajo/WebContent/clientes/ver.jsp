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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ver dispositivos</title>
<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
<script src="../js/registro.js"></script>
</head>
<body>
    <jsp:include  page="../cabecera.jsp" />


	<div id="lista">
		<%
			try {

				Connection conn = ds.getConnection();

				String sql = "SELECT mac, descripcion, estado FROM dispositivos, tipos WHERE dispositivos.id_usuario=? AND dispositivos.id_tipo=tipos.id_tipo";
				PreparedStatement st = conn.prepareStatement(sql);
				st.setString(1, usuario.getUsu());

				ResultSet rs = st.executeQuery();
		%>
		<h2>Lista de sus dispositivos:</h2>
		<table id="resultados">
			<tr>
				<th>MAC</th>
				<th>TIPO</th>
				<th>ESTADO</th>
			</tr>
			<%
				while (rs.next()) {
						String mac = rs.getString(1);
						String tipo = rs.getString(2);
						Boolean estado = rs.getBoolean(3);
			%>

			<tr>
				<td><%=mac%></td>
				<td><%=tipo%></td>
				<td><%=estado ? "Arreglado" : "Pendiente"%></td>

			</tr>

			<%
				}

					rs.close();
					st.close();
					conn.close();

				} catch (SQLException e) {
					out.println("Excepción SQL Exception: " + e.getMessage());
					e.printStackTrace();
				}
			%>
		</table>
	</div>
	
	<%@include file="../pie.jsp" %>

</body>
</html>