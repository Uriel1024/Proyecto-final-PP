import java.sql.*;
import java.time.LocalDate;

public class DetalleCompraExtenxsionesDAO {
    private Connection con;

    public DetalleCompraExtenxsionesDAO(Connection con) {
        this.con = con;
    }

    public void DetallesExtensions(int id){
        String sql = "SELECT *FROM DetallesCompraExtensiones WHERE id_detalle_extension = ?";

        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int id_usuario = rs.getInt("id_usuario");
                int id_extension = rs.getInt("id_extension");
                LocalDate fecha = rs.getDate("fecha_compra").toLocalDate();
                int cant = rs.getInt("cantidad");
                double precio = rs.getDouble("precio_total");

                System.out.println("ID del usuario: " + id_usuario );
                System.out.println("ID de la extension: " + id_extension );
                System.out.println("Fecha de compra: " + fecha );
                System.out.println("Cantidad de extension: " + cant );
                System.out.println("Precio total: " + precio + "\n\n\n\n\n");

            }else{
                System.out.println("No se encontro el detalle extension con ID: " + id + "\n\n\n\n\n");
            }
        }catch(SQLException e){
            System.out.println("Error al consultar el detalle extension con ID: " + id + "\n\n\n\n\n");
            e.printStackTrace();
        }
    }

    public void agregarDetalleExtension(int idu, int ide, LocalDate fecha, int cant){
        int id = obtenerID();

        if(id == -1){
            System.out.println("Error al obtener ID. Operacion cancelada");
            return;
        }

        if(fecha == null){
            System.out.println("La fecha ingresada no es valida. Operacion cancelada");
            return;
        }

        double total = obtenerPrecio(ide, cant);

        String sql = "INSERT INTO DetallesCompraExtensiones (id_detalle_extension, id_usuario,id_extension, fecha_compra, cantidad, precio_total) VALUES (?,?,?,?,?,?)";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            ps.setInt(2,idu);
            ps.setInt(3,ide);
            ps.setDate(4, Date.valueOf(fecha));
            ps.setInt(5,cant);
            ps.setDouble(6,total);

            int filas = ps.executeUpdate();
            if(filas > 0){
                System.out.println("El precio del pedido es: " + total );
                System.out.println("Detalle compra extension agregada con exito, su ID es:  " + id + "\n\n\n\n");
            }else{
                System.out.println("No se pudo agregar el detalle extension \n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("Error al agregar compra de extension. \n\n\n\n");
            e.printStackTrace();
        }
    }

    public void eliminarDetalleExtension(int id){
        String sql = "DELETE FROM DetallesCompraExtensiones WHERE id_detalle_extension = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsAffected = ps.executeUpdate();
            if(rowsAffected > 0){
                System.out.println("Detalle compra extension eliminada. \n\n\n\n\n");
            }else{
                System.out.println("No se encontro una compra de  detalle extension con ID: " + id + "\n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("Error al eliminar detalle compra extension. \n\n\n\n");
            e.printStackTrace();
        }
    }

    public double obtenerPrecio(int id, int cantidad){
        String sql = "SELECT * FROM ExtensionesVideojuegos WHERE id_extension = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                double precio = rs.getDouble("precio");
                return precio * cantidad;
            }else{
                System.out.println("No existe una extension de  videojuego con ID: " + id + "\n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("No se pudo acceder al precio de la extension");
            e.printStackTrace();
        }
        return 0;
    }


    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_detalle_extension), 0) + 1 AS nuevo_id FROM DetallesCompraExtensiones";
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
