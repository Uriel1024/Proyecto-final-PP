        import java.sql.*;
        import java.time.LocalDate;



public class VideojuegosDAO {
    private Connection conexion;

    public VideojuegosDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public void consultarVideojuego(int id){
        String consulta = "SELECT *FROM videojuegos WHERE id_videojuego = ?";

        try(PreparedStatement ps = conexion.prepareStatement(consulta)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int idVideojuego = rs.getInt("id_videojuego");
                String nombre = rs.getString("titulo");
                double precio = rs.getDouble("Precio");
                String plataforma = rs.getString("plataforma");
                int stock = rs.getInt("stock");
                String desarrollador = rs.getString("desarrollador");
                LocalDate fecha = rs.getDate("fecha_lanzamiento").toLocalDate();

                System.out.println("ID: " + idVideojuego);
                System.out.println("Nombre: " +  nombre);;
                System.out.println("Precio: " + precio);
                System.out.println("Plataforma:" + plataforma);
                System.out.println("Stock: " + stock);
                System.out.println("Desarrollador: " + desarrollador );
                System.out.println("Fecha de lanzamiento: " + fecha + "\n\n\n\n\n\n");
            }else{
                System.out.println("No se encontro un videojuego con el ID: " + id);
            }
        }catch (SQLException e){
            System.out.println("Error al consultar videojuego: ");
            e.printStackTrace();
        }
    }

    public void agregarVideojuego(String titulo, String plataforma, double precio, int stock, String desarrollador, LocalDate fecha_lanzamiento ){
        int id_videojuego = obtenerID();
        if(id_videojuego == -1){
            System.out.printf("No se pudo generar un nuevo ID. Operacion cancelada.");
            return;
        }

        if (fecha_lanzamiento == null) {
            System.out.println("La fecha ingresada no es valida. Operacion cancelada.");
            return;
        }

        String sql = "INSERT INTO videojuegos (id_videojuego, titulo , plataforma ,precio, stock, desarrollador, fecha_lanzamiento) VALUES (?,?,?,?,?,?,?)";

        try(PreparedStatement ps = conexion.prepareStatement(sql)){
            ps.setInt(1,id_videojuego);
            ps.setString(2,titulo);
            ps.setString(3,plataforma);
            ps.setDouble(4,precio);
            ps.setInt(5,stock);
            ps.setString(6,desarrollador);
            ps.setDate(7, Date.valueOf(fecha_lanzamiento));
            int filas = ps.executeUpdate();
            if(filas > 0){
                System.out.println("Videojuego agregado correctamente su ID: " + id_videojuego  + "\n\n\n\n\n");
            }else{
                System.out.println("No se agrego el videojuego \n\n\n\n\n");
            }
        }catch(SQLException e){
            System.out.println("Error al agregar videojuego: ");
            e.printStackTrace();
        }
    }

    public void eliminarVideojuego(int id){
        String sql = "DELETE FROM videojuegos WHERE id_videojuego = ?";
        try(PreparedStatement ps = conexion.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsAffected = ps.executeUpdate();
            if(rowsAffected > 0) {
                System.out.println("Videojuego eliminado correctamente ");
            }else{
                System.out.println("No se encontro el videojuego con ID: " + id);
            }
        }catch(SQLException e){
            System.out.println("Error al eliminar videojuego. ");
            e.printStackTrace();
        }
    }


    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_videojuego), 0) + 1 AS nuevo_id FROM videojuegos";
        try (       PreparedStatement ps = conexion.prepareStatement(consulta);
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
