<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="ds" type="javax.sql.DataSource" scope="application" />
<jsp:useBean id="tipos" type="java.util.Map<String,String>" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modificar estados de los dispositivos</title>
<link rel="stylesheet" type="text/css" href="../css/estilo.css" />
<script src="../js/registro.js"></script>
<script src="js/fun_modificar.js"></script>

</head>
<body onload="ini()">
    <jsp:include page="../cabecera.jsp" />

	<div id="lista">
		<%
			try {

				Connection conn = ds.getConnection();
				//Obtiene los dispositivos
				String sql = "SELECT * FROM dispositivos";


				PreparedStatement st = conn.prepareStatement(sql);
				
				ResultSet rs = st.executeQuery();
		%>
		<h2>Lista de todos los dispositivos existentes:</h2>
		<table id="resultados">
			<tr>
				<th>MAC</th>
				<th>USUARIO</th>
				<th>TIPO</th>
				<th>ESTADO</th>
				<th>ACCIONES</th>
			</tr>
			<%
				while (rs.next()) {
						String mac = rs.getString(1);
						String usu = rs.getString(2);
						String tipo = tipos.get(rs.getString(3));
						Boolean estado = rs.getBoolean(4);
			%>

			<tr>
				<td><%=mac%></td>
				<td><%=usu%></td>
				<td><%=tipo%></td>
				<td id='accion-<%=mac%>'><%=estado ? "Arreglado" : "Pendiente"%></td>
				<td><button class="boton bModificar" value="<%=mac%>">Modificar estado</button></td>


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