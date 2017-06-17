// VALIDATION FUNCTIONS

// Calls preProcesaMac and procesaMac for form validation
function validaFormulDis() {
	
	var mac = document.getElementById("mac").value;
	var pmac = preProcesaMac(mac);
	var error = procesaMac(pmac);
	
	switch (error) {
	case -1: alert("The MAC is empty!");
			 break;
	case -2: alert("MAC is too short!");
			 break;
	case -3: alert("MAC is too long!");
			 break;
	case 0: break;
	default: alert("There is an error in MAC: position " + error);
	}
	
	return !error;
}

/* 
 * Takes a MAC string.
 * Returns the same string without spaces and tabs.
 */
function preProcesaMac(mac) {
	
	return mac.replace(/[\t\s]/g, "");
}

/*
 * Takes a pre-processed MAC string.
 * 	- Returns 0 if the string length is 17, expressed as
 * 	  6 groups of 2 hexadecimal digits separated by ":".
 * 	- If these conditions are not fulfilled, returns the
 * 	  position of the first wrong character.
 * 	- If the string is empty returns -1.
 * 	- If the string length is lower than 17, returns -2.
 * 	- If the string length is higher than 17, returns -3.
 */
function procesaMac(mac) {
	
	var error = 0;
	var flag = -1;
	
	if (mac.length == 0)
		error = -1;
	else if (mac.length < 17)
		error = -2;
	else if (mac.length > 17)
		error = -3;
	else
		for (var i = 0 ; i < 17 && flag == -1; i++) {
			if (i == 2 || i == 5 || i == 8 || i == 11 || i == 14)
				flag = mac[i].search(/[^:]/);
			else
				flag = mac[i].search(/[^a-fA-F\d]/);
			
			if (flag != -1)
				error = i+1;
		}	
	
	return error;
}

// Changes the list through AJAX
function changeList() {
	
	var dis = document.getElementById("dis");
	
	if (dis.value == "otr"){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (xhttp.readyState == 4 && xhttp.status == 200) {
				
				var list = JSON.parse(xhttp.responseText);
				dis.innerHTML = "";
			
				for (i in list) {
				
					var opt = document.createElement("option");
					opt.setAttribute("value",i);
					opt.innerHTML = list[i];
					dis.appendChild(opt);
				}
			
			}
		}
		
		xhttp.open("GET", "../data/dispositivos.json", true);
		xhttp.send();
	}

}

// It is called at the end of the script
function inicial() {
	
	document.getElementById("dis").addEventListener("change", changeList);
	
}

inicial();