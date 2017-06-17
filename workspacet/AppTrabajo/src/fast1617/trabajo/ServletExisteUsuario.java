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
 * Servlet implementation class ServletExisteUsuario
 */
@WebServlet("/existeUsuario")
public class ServletExisteUsuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletExisteUsuario() {
        super();
        // TODO Auto-generated constructor stub
    }

	/** 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String usu = request.getParameter("usu");
		String res = "";
		
		try {
			// Open DB connection
			DataSource ds = (DataSource) request.getServletContext().getAttribute("ds");
			Connection conn = ds.getConnection();
		
			String sql = "SELECT * FROM usuarios WHERE id_usuario=?";
			
			PreparedStatement st = conn.prepareStatement(sql);
			st.setString(1, usu);
			ResultSet rs = st.executeQuery();
			if (rs.next())
				res = "si";
			else
				res = "no";
			
			// Close DB connection
			st.close();
			rs.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println("Error de acceso a la base de datos.");
		}
		
		// Send response
		response.setContentType("text/plain");
		response.getWriter().print(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
