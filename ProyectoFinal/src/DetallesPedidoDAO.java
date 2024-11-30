import java.sql.*;
public class DetallesPedidoDAO{

    private Connection con;

    public DetallesPedidoDAO(Connection con){
        this.con = con;
    }

    public void consultarDetallesPedido(int id){
        String consulta = "SELECT *FROM DetallesPedido WHERE id_detalle_pedido = ?";
        try(PreparedStatement ps = con.prepareStatement(consulta)){
            ps.setInt(1,id);
            ResultSet rs =  ps.executeQuery();
            if(rs.next()){
                int id_detalle = rs.getInt("id_detalle_pedido");
                int id_pedido = rs.getInt("id_pedido");
                int id_videojuego = rs.getInt("id_videojuego");
                int cantidad = rs.getInt("cantidad");
                double precio_total = rs.getDouble("precio_total");

                System.out.println("ID detalle: " + id_detalle);
                System.out.println("ID pedido: " + id_pedido);
                System.out.println("ID videojuego: " + id_videojuego);
                System.out.println("Cantidad: " + cantidad);
                System.out.println("Precio total: " + precio_total + "\n\n\n\n\n");
            }else{
                System.out.println("No se encontro el detalle de pedido con ID: " + id);
            }
        }catch(SQLException e){
            System.out.println("Error al acceder al detalle de pedido");
            e.printStackTrace();
        }
    }

    public void agregarDetallesPedido(int id_pedido, int id_videojuego, int cantidad){
        int id_detalles_pedido =  obtenerID();

        if(id_detalles_pedido == -1){
            System.out.println("No se pudo generar un nuevo ID. Operacion Cancelada");
            return;
        }

        String sql = "INSERT INTO DetallesPedido(id_detalle_pedido,id_pedido,id_videojuego, cantidad,precio_total) VALUES(?,?,?,?,?)";

        double total = precioTotal(id_videojuego, cantidad);

        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id_detalles_pedido);
            ps.setInt(2,id_pedido);
            ps.setInt(3,id_videojuego);
            ps.setInt(4,cantidad);
            ps.setDouble(5,total);

            int filas = ps.executeUpdate();
            if (filas > 0){
                System.out.println("Se ha agregado el detalle de pedido con ID: " + id_detalles_pedido + "\n\n\n\n");
            }else{
                System.out.println("No se pudo agregar el detall del pedido \n\n\n\n");
            }
        }catch(SQLException e){
            System.out.println("Error al agregar detalle de pedido");
            e.printStackTrace();
        }

    }

    public void eliminarDetallePedido(int id){
        String sql = "DELETE FROM DetallesPedido WHERE id_pedido = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsA = ps.executeUpdate();
            if (rowsA > 0){
                System.out.println("Detalles de pedido eliminados con exito.");
            }else{
                System.out.println("No existe el detalle de  pedido con ese ID");
            }
        }catch (SQLException e){
            System.out.println("Error al eliminar detalle de pedido");
            e.printStackTrace();
        }
    }

    public double precioTotal(int id, int cantidad){

        String consulta = "SELECT *FROM videojuegos WHERE id_videojuego = ?";
        try(PreparedStatement ps = con.prepareStatement(consulta)){
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                double precio = rs.getDouble("precio");
                return cantidad * precio;
            }else{
                System.out.println("No existe un videojuego con ID:" +id);
            }
        }catch(SQLException e){
            System.out.println("No se pudo acceder al precio del juego");
            e.printStackTrace();
        }
        return -1;
    }

    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_detalle_pedido), 0) + 1 AS nuevo_id FROM DetallesPedido";
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

}
