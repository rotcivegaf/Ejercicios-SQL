package coneccionBD;

import java.sql.*;

public class WorkSpace {
	
	public static void main (String [] args) throws ArithmeticException, ClassNotFoundException, SQLException {
		Connection coneccion = GestorBD.obtener();
		
		Statement st = coneccion.createStatement();
		
		ResultSet rs = st.executeQuery("SELECT * FROM autores;");
			   
		System.out.println("id	|nombre		|apellido");
			  
		while (rs.next()){
			System.out.println(rs.getObject("au_id") + "\t|" + rs.getObject("au_nombre") +  "\t|" +rs.getObject("au_apellido"));
		}
		rs.close();
		
		GestorBD.cerrar();
	}
	
	
}
