package fast1617.trabajo;

/*
 * User class with the three user attributes.
 */
public class Usuario {
	
	private String usu; // username
	private String contra; // user password
	private Boolean esAdmin; // differences beetwen an admin or client user

	
	public Usuario() {}
	
	public String getUsu() {
		return usu;
	}
	public void setUsu(String usu) {
		this.usu = usu;
	}
	
	public String getContra() {
		return contra;
	}
	public void setContra(String contra) {
		this.contra = contra;
	}
	
	public Boolean getEsAdmin() {
		return esAdmin;
	}
	public void setEsAdmin(Boolean esAdmin) {
		this.esAdmin = esAdmin;
	}
}