package coneccionBD;

import java.sql.*;

public class GestorBD {
   private static Connection coneccion = null;
   
   static String url = "jdbc:mysql://localhost:3306/pub?autoReconnect=true&useSSL=false";
   static String user = "root";
   static String pass = "123456"; 
   
   public static Connection obtener() throws SQLException, ClassNotFoundException {
      if (coneccion == null) {
         try {
            Class.forName("com.mysql.jdbc.Driver");
            coneccion = DriverManager.getConnection(url, user, pass);
            
         } catch (SQLException ex) {
            throw new SQLException(ex);
         } catch (ClassNotFoundException ex) {
            throw new ClassCastException(ex.getMessage());
         }
      }
      System.out.println("coneccion establecida");
      return coneccion;
   }
   
   public static void cerrar() throws SQLException {
      if (coneccion != null) {
    	  System.out.println("coneccion 	cerrada");
    	  coneccion.close();
      }
   }
   
   public static void selectPrueba() throws SQLException {
	   Statement st = coneccion.createStatement();

	   ResultSet rs = st.executeQuery("SELECT * FROM autores;");
	   
	   System.out.println("id	|nombre		|apellido");
	  
	   while (rs.next()){
		   System.out.println(rs.getObject("au_id") + "\t|" + rs.getObject("au_nombre") +  "\t|" +rs.getObject("au_apellido"));
	   }
	   rs.close();
	}
}