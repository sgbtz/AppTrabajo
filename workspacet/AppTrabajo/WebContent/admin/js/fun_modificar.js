// Asociates a click event to "bModificar" class buttons
function ini() {
	
	 var botones = document.getElementsByClassName("bModificar");
	 
	 for (i in botones)
		 botones[i].addEventListener("click", changeState)
}

function changeState() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
			
			document.getElementById("accion-" + mac).innerHTML = xhttp.responseText;
		}
	}
	
	var mac = this.value;
	
	xhttp.open("POST", "http://localhost:8080/AppTrabajo/admin/modificar", true);
	xhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xhttp.send("mac=" + mac);
}