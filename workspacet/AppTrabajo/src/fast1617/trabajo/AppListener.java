package fast1617.trabajo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;


/**
 * Application Lifecycle Listener implementation class AppListener
 *
 */
@WebListener
public class AppListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AppListener() {
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent event)  {
    	String autor = "Guisasola Benítez, Sebastiá - sebguiben";
    	event.getServletContext().setAttribute("autor", autor);
    	
    	System.out.println("Creado atributo autor: "+ autor);
    	
    	try {
			// Usando DataSource ya definido en el servidor
			InitialContext ctx = new InitialContext();
			// /jdbc/dit is the name of the resource above
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/dit");
			Connection conn = ds.getConnection();

			String sql = "SELECT * FROM tipos";
			// Statement st = conn.createStatement();
			PreparedStatement st = conn.prepareStatement(sql);
			ResultSet rs = st.executeQuery();
			Map<String,String> tipos = new HashMap<String, String>();
			while (rs.next()) {
				tipos.put(rs.getString("id_tipo"),rs.getString("descripcion"));
				
			}
			
			event.getServletContext().setAttribute("tipos", tipos);
			System.out.println("Creado atributo tipos: "+ tipos);
			
			event.getServletContext().setAttribute("ds", ds);
			System.out.println("Creado atributo ds: "+ ds);
			rs.close();
			st.close();
			conn.close();
		} catch (NamingException e) {
			System.out.println("No está definida la base de datos en el servidor.");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Error de acceso a la base de datos.");
		}
    
    }
	
}
