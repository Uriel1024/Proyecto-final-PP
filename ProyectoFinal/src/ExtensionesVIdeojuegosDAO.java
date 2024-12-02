import java.sql.*;
import java.time.LocalDate;

public class ExtensionesVIdeojuegosDAO {
    private Connection con;

    ExtensionesVIdeojuegosDAO(Connection con) {
        this.con = con;
    }

    public void consultarExtensiones(int id){
        String sql = "Select * from ExtensionesVideojuegos where id_extension = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int id_extension = rs.getInt("id_extension");
                int id_videojuego = rs.getInt("id_videojuego");
                String nombre_extension = rs.getString("nombre_extension");
                double precio = rs.getDouble("precio");
                String descripcion = rs.getString("descripcion");
                LocalDate fecha = rs.getDate("fecha_lanzamiento").toLocalDate();

                System.out.println("ID de la extension: " + id);
                System.out.println("Informacion del videojuego: \n");
                VideojuegosDAO v1 = new VideojuegosDAO(con);
                v1.consultarVideojuego(id_videojuego);

                System.out.println("Nombre de la  extension: " + nombre_extension);
                System.out.println("Precio de la extension: " + precio);
                System.out.println("Descripcion de la extension: " + descripcion);
                System.out.println("Fecha de lanzamiento de la extension: " + fecha +  "\n\n\n\n\n");

            }else{
                System.out.println("No se pudo encontrar una extension de videojuego con ID: " + id + "\n\n\n\n\n");
            }
        }catch(SQLException e){
            System.out.println("Error al consultar la extension del videojuego.\n\n\n\n\n");
            e.printStackTrace();
        }
    }

    public void agregarExtension(int videojuego, String extension, double precio,String descripcion,LocalDate fecha){
        int id_extension = obtenerID();
        if(id_extension == -1){
            System.out.println("Error al obtener nuevo ID. Operacion cancelada");
            return;
        }
        if(fecha == null){
            System.out.println("La fecha ingresada no es valida. Operacion cancelada");
            return;
        }
        String sql = "INSERT INTO ExtensionesVideojuegos (id_extension, id_videojuego,nombre_extension,precio,descripcion,fecha_lanzamiento) VALUES(?,?,?,?,?,?)";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id_extension);
            ps.setInt(2,videojuego);
            ps.setString(3,extension);
            ps.setDouble(4,precio);
            ps.setString(5,descripcion);
            ps.setDate(6, Date.valueOf(fecha));
            int filas = ps.executeUpdate();
            if(filas > 0){
                System.out.println("Extension agregada con exito, su ID:  " + id_extension + "\n\n\n\n\n");
            }else{
                System.out.println("No se pudo agregar la extension\n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("Error al agregar extension.\n\n\n\n\n");
            e.printStackTrace();
        }

    }

    public boolean buscarExtension(int id){
        String sql = "Select * from ExtensionesVideojuegos where id_extension = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                System.out.println("Nombre de la extension: " + rs.getString("nombre_extension") + "\n\n\n\n\n");
                return true;
            }else{
                System.out.println("No se encontro la extension con ID + " + id + "\n\n\n\n\n");
                return false;
            }
        }catch (SQLException e){
            System.out.println("Error al buscar la extension. \n\n\n\n\n");
            return  false;
        }
    }

    public void eliminarExtension(int id){
        String sql = "DELETE FROM ExtensionesVideojuegos WHERE id_extension = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsAffected = ps.executeUpdate();
            if(rowsAffected > 0){
                System.out.println("Extension eliminada con exito \n\n\n\n\n");
            }else{
                System.out.println("No se encontro una  extension con ID:" + id + "\n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("Error al eliminar extension: ");
            e.printStackTrace();
        }
    }

    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_extension), 0) + 1 AS nuevo_id FROM ExtensionesVideojuegos";
        try (       PreparedStatement ps = con.prepareStatement(consulta);
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
}
