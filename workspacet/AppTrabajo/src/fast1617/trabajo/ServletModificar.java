package fast1617.trabajo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class ServletModificar
 */
@WebServlet("/admin/modificar")
public class ServletModificar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		String sql;
		String mac = request.getParameter("mac");

		if (mac != null) {
			try {
				// Usando DataSource ya definido en el servidor
				DataSource ds = (DataSource) request.getServletContext().getAttribute("ds");
				Connection conn = ds.getConnection();
				boolean valorActual;
				//Obtener estado del dispositivo
				sql = "SELECT estado FROM dispositivos WHERE mac=?";

				PreparedStatement st = conn.prepareStatement(sql);
				st.setString(1, mac);
				ResultSet rs = st.executeQuery();
				if (rs.next()) {
					valorActual = rs.getBoolean(1);
					//Actualizar estado del dispositivo
					sql = "UPDATE dispositivos SET estado=? WHERE mac=?";

					PreparedStatement st2 = conn.prepareStatement(sql);
					st2.setBoolean(1, !valorActual);
					st2.setString(2, mac);
					int rows = st2.executeUpdate();
					if (rows == 1) {
						response.getWriter().print( !valorActual ?  "Arreglado" : "Pendiente");
					} 
					st2.close();
					
				}
				st.close();
				rs.close();
				conn.close();
			} catch (SQLException e) {
				System.out.println("Error de acceso a la base de datos.");
			}
		}
	}

}
