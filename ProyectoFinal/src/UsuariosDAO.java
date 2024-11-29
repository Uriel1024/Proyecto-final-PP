import java.awt.*;
import java.sql.*;
import java.time.LocalDate;


public class UsuariosDAO {
    private Connection con;

    public UsuariosDAO(Connection con) {
            this.con = con;
    }



    public void consultarUsuario(int id){
        String consulta = "select * from usuarios where id_usuario = ?";

        try(PreparedStatement ps = con.prepareStatement(consulta)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                String nombre = rs.getString("nombre");
                String primer_ap = rs.getString("primer_apellido");
                String segundo_ap = rs.getString("segundo_apellido");
                String email = rs.getString("email");
                String direccion = rs.getString("direccion");
                String telefono = rs.getString("telefono");

                System.out.println("Los datos del usuario con ID " + id);
                System.out.println("El nombre del usuario es: " + nombre);
                System.out.println("El primer apellido del usuario es: " + primer_ap);
                System.out.println("El segundo apellido del usuario es: " + segundo_ap);
                System.out.println("El email del usuario es: " + email);
                System.out.println("La direccion es: "  + direccion );
                System.out.println("El telefono es: " + telefono + "\n\n\n\n\n");
            }else{
                System.out.println("No se encontro un usuario con el ID: " + id + " \n\n\n\n\n");
            }
        }catch (SQLException e) {
            System.out.println("Error al consultar el usuario");
            e.printStackTrace();
        }
    }

    public void agregarUsuario(String nombre, String primer_ap, String segundo_ap, String email, String direccion, String telefono,RolUsuario rol){

        int id_usuario = obtenerID();
        if(id_usuario == 0) {
            System.out.println("No se pudo generar un nuevo ID. Operacion cancelada");
            return;
        }

        String sql =  "INSERT INTO usuarios (id_usuario, nombre ,primer_apellido, segundo_apellido, email, direccion, telefono,rol) VALUES (?,?,?,?,?,?,?,?)";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id_usuario);
            ps.setString(2,nombre);
            ps.setString(3,primer_ap);
            ps.setString(4,segundo_ap);
            ps.setString(5,email);
            ps.setString(6,direccion);
            ps.setString(7,telefono);
            ps.setString(8,rol.name());
            int filas = ps.executeUpdate();
            if(filas > 0) {
                System.out.println("Usuario agregado exitosamente, su ID: " + id_usuario + "\n\n\n\n\n");
            }else{
                System.out.println("No se pudo agregar el usuario");
            }
        }catch (SQLException e) {
            System.out.println("Error al agregar el usuario");
            e.printStackTrace();
        }
    }


    public void eliminar_usuario(int id){
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsA = ps.executeUpdate();
            if(rowsA > 0) {
                System.out.println("Usuario eliminado.");
            }else{
                System.out.println("No se encontro al usuario con ID:  "+id);
            }
        }catch (SQLException e) {
            System.out.println("Error al eliminar el usuario");
            e.printStackTrace();
        }

    }


    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_usuario), 0) + 1 AS nuevo_id FROM usuarios";
        try (PreparedStatement ps = con.prepareStatement(consulta);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("nuevo_id");
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener el nuevo ID.");
            e.printStackTrace();
        }
        return -1; // Devuelve -1 si ocurre un error
    }

    public enum RolUsuario {
        administrador,
        cliente
    }


}
