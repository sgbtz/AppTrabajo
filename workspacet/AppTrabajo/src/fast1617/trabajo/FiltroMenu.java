package fast1617.trabajo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet Filter implementation class FiltroMenu
 */
@WebFilter("/menu")
public class FiltroMenu implements Filter {

	/**
	 * Default constructor.
	 */
	public FiltroMenu() {
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		//Comprueba si es un login
		String usu = req.getParameter("usu");
		String contra = req.getParameter("contra");
		
		if (usu != null && contra != null)
		{
			Usuario usuario = new Usuario();
			//Valida contraseña y usuario
			boolean verificado = false;
			try {
				// Usando DataSource ya definido en el servidor
				DataSource ds = (DataSource) req.getServletContext().getAttribute("ds");
				Connection conn = ds.getConnection();
				String sql = "SELECT es_admin FROM usuarios WHERE id_usuario=? AND password=?";
				PreparedStatement st = conn.prepareStatement(sql);
				st.setString(1, usu);
				st.setString(2, contra);
				ResultSet rs = st.executeQuery();
				//System.out.println(usuario);
				if (rs.next()) {
					verificado = true;
					usuario.setUsu(usu);
					usuario.setContra(contra);
					usuario.setEsAdmin(rs.getBoolean("es_admin"));
				}
				rs.close();
				st.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("Error de acceso a la base de datos.");
			}
			
			//Si es correcto, crea objetos en session
			if (verificado)
			{
				req.getSession().setAttribute("usuario", usuario);
				//System.out.println(usuario);
				
				// Creamos la cookie
				Cookie usuCookie = new Cookie( "usuario", usu);
				res.addCookie(usuCookie);
			}
			
		}
		
		Usuario usuario = (Usuario) req.getSession().getAttribute("usuario");
		if (usuario != null) {
			if (usuario.getEsAdmin())
				request.getRequestDispatcher("/admin/menu.jsp").forward(request, response);
			else
				request.getRequestDispatcher("/clientes/menu.jsp").forward(request, response);
		} else
			request.getRequestDispatcher("/").forward(request, response);

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
