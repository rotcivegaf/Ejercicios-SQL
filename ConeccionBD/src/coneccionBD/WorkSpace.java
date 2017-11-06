package coneccionBD;

import java.sql.SQLException;

public class WorkSpace {
	
	public static void main (String [] args) throws ArithmeticException, ClassNotFoundException, SQLException {
		GestorBD.obtener();
		
		GestorBD.selectPrueba();
		
		GestorBD.cerrar();
	}
	
	
}
