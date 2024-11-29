import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConexionBD {
    private final  String url = "jdbc:mysql://localhost:3306/videojuegos1";
    private final String user = "root";
    private final String pass = "kkck12"; // la conteasenia cambia depende de como la hayas definido en tu bd

    private Connection conexion;

    public void conectar(){
        try{
            if(conexion == null  || conexion.isClosed()){
                conexion = DriverManager.getConnection(url, user, pass);
                System.out.println("Conexion exitosa.");
            }
        }catch(SQLException e){
            System.out.println("Error al realizar la conexion.");
            e.printStackTrace();
        }
    }

    public void desconectar(){
        try{
            if(conexion != null && !conexion.isClosed()){
                conexion.close();
                System.out.println("Conexion cerrada.");
            }
        }catch(SQLException e){
            System.out.println("Error al cerrar la conexion.");
            e.printStackTrace();
        }
    }

    public Connection getConexion(){
        return conexion;
    }
}
