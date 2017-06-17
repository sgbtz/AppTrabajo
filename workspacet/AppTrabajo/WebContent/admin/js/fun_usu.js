// VALIDATION FUNCTIONS

// Calls compruebaPass() for checking password
function validaFormulAut() {
	var pass = document.getElementById("contra").value;
	var error = compruebaPass(pass, 8, 15);
	var send = false;
	switch (error){
		case 1: alert("Password is too short!");
				break;
		case 2: alert("Password is too long!");
				break;
		case 3: alert("Password must contain a number");
				break;
		case 4: alert("Password must contain an upper case letter");
				break;
		case 5: alert("Password must contain a lower case letter");
				break;
		default: send = true;
	}
	
	return send;
}

/* Checks introduced password:
 * 	- Returns 0 if the password is correct
 * 	- Returns 1 if password is shorter than minimum length
 * 	- Returns 2 if password is longer than maximum length
 * 	- Returns 3 if password doesn't contain a number
 *  - Returns 4 if password doesn't contain an upper case letter
 *  - Returns 5 if password doesn't contain a lower case letter
 */
function compruebaPass(pass, lon_min, lon_max) {
		
	var error = 0;
	
	if (pass.length < lon_min)
		error = 1;
	else if (pass.length > lon_max)
		error = 2;
	else if (pass.search(/\d/) == -1)
		error = 3;
	else if (pass.search(/[A-Z]/) == -1)
		error = 4;
	else if (pass.search(/[a-z]/) == -1)
		error = 5;
		
	return error;
}

// EVENT FUNCTIONS

// Attaches an event to several elements with the same class
function aplicaEventoClase(eve, cla, fun) {
	
	var elements = document.getElementsByClassName(cla);
	
	for (var i = 0 ; i < elements.length ; i++){
		if (fun == "invierteColorElemento")
			elements[i].addEventListener(eve,invierteColorElemento);
		else if ( fun == "disminuyeElemento")
			elements[i].addEventListener(eve,disminuyeElemento);
		else
			elements[i].addEventListener(eve,aumentaElemento);
	}
}

// Increases element size
function aumentaElemento() {
	
	var px = window.getComputedStyle(this).fontSize.split("px");
	
	this.style.fontSize = parseFloat(px[0])*1.25+"px";
}

// Decreases element size
function disminuyeElemento() {
	
	var px = window.getComputedStyle(this).fontSize.split("px");
	
	this.style.fontSize = parseFloat(px[0])*0.75+"px";
}

// Switches element colors
function invierteColorElemento() {
	
	var sty = window.getComputedStyle(this);
	var temp = sty.color;
	
	this.style.color = sty.backgroundColor;
	this.style.backgroundColor = temp;
}

// Modifies user span throught AJAX
function checkExist() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
			
			if (xhttp.responseText == "si")
				document.getElementById("existe").innerHTML = "Usuario existe";
			else
				document.getElementById("existe").innerHTML = "Usuario no existe";
		
		}
	}
	
	var usu = document.getElementById("usu").value
	xhttp.open("GET", "http://localhost:8080/AppTrabajo/existeUsuario?usu=" + usu, true);
	xhttp.send();
}

// Attaches functions to the container buttons
function inicial() {
	
	document.getElementById("bot1").addEventListener("click", function(){
		aplicaEventoClase("click","invertible","invierteColorElemento");
	})
	
	document.getElementById("bot2").addEventListener("click", function(){
		aplicaEventoClase("click","tamvar","disminuyeElemento");
	})
	
	document.getElementById("bot2").addEventListener("contextmenu", function(){
		aplicaEventoClase("contextmenu","tamvar","aumentaElemento");
	})
	
	document.getElementById("usu").addEventListener("change", checkExist);
}

inicial();