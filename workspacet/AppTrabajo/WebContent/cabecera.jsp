<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div id="cabecera">
	<a id="volver" class="acceso" href="${pageContext.servletContext.contextPath}/menu">Volver al menú</a>
	<a class="acceso" href="${pageContext.servletContext.contextPath}/cerrar">Cerrar sesión</a>
	<span id="nombreusuario" class="acceso">${sessionScope.usuario.usu}</span>
</div>