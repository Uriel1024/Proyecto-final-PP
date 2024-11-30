import java.sql.*;
import java.time.LocalDate;
import java.util.Scanner;

public class PedidosDAO {
    private Connection con;
    Scanner in = new Scanner(System.in);

    public PedidosDAO(Connection con) {
        this.con = con;
    }

    public void consultarPedidos(int id) {
        String sql = "Select * from Pedidos where id_pedido = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id_usuario = rs.getInt("id_usuario");
                LocalDate fecha = rs.getDate("fecha_pedido").toLocalDate();
                String Estado = rs.getString("estado");

                System.out.println("El ID del pedido es: " + id);
                System.out.println("EL ID del usuario es: " + id_usuario);
                System.out.println("La fecha del pedido es: " + fecha);
                System.out.println("El estado del pedido es: " + Estado + "\n\n\n\n\n");
            }else{
                System.out.println("No existe el pedido con el ID" + id);
            }
        } catch (SQLException e) {
            System.out.println("Error al acceder al pedido");
            e.printStackTrace();
        }
    }

    public void ingresarPedido(int id_usuario, LocalDate fecha,estadoPedidos estado) {
        int id_pedido = obtenerID();
        if(id_pedido == - 1){
            System.out.println("No se pudo generar un nuevo ID, Operacion cancelada");
            return;
        }

        if (fecha == null){
            System.out.println("La fecha ingresada no es valida, Operacion cancelada");
            return;
        }

        String sql = "INSERT INTO Pedidos(id_pedido, id_usuario, fecha_pedido, estado) VALUES(?,?,?,?)";

        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id_pedido);
            ps.setInt(2,id_usuario);
            ps.setDate(3, Date.valueOf(fecha));
            ps.setString(4,estado.name());

            int filas = ps.executeUpdate();
            if (filas > 0 ){
                System.out.println("Se ha agregado el pedido, su ID: "+ id_pedido);
                System.out.println("Se agregan los detalles del pedido \n");
                DetallesPedido(id_pedido);
            }else{
                System.out.println("No se pudo agregar el pedido \n\n\n\n\n");
            }
        }catch (SQLException e){
            System.out.println("Error al agregar el pedido");
            e.printStackTrace();
        }
    }

    public void DetallesPedido(int id){
        DetallesPedidoDAO d1 = new DetallesPedidoDAO(con);
        System.out.println("Ingresa el ID del videojuego: ");
        int id2 = in.nextInt();
        System.out.println("Ingresa la cantidad de videojuegos:  ");
        int cant = in.nextInt();
        d1.agregarDetallesPedido(id,id2,cant);
    }

    public void eliminarDetallesPedido(int id){
        DetallesPedidoDAO d1 = new DetallesPedidoDAO(con);
        d1.eliminarDetallePedido(id);
    }

    public void eliminarPedido(int id){
        String sql = "DELETE FROM Pedidos WHERE id_pedido = ?";
        eliminarDetallesPedido(id);
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1,id);
            int rowsA  = ps.executeUpdate();
            if (rowsA > 0){
                System.out.println("Pedido eliminado con exito.");
            }else{
                System.out.println("No existe el pedido con id: " + id);
            }
        }catch (SQLException e){
            System.out.println("Error al eliminar pedido");
            e.printStackTrace();
        }

    }

    public int obtenerID() {
        String consulta = "SELECT COALESCE(MAX(id_pedido), 0) + 1 AS nuevo_id FROM Pedidos";
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

    public enum estadoPedidos{
        pendiente,
        enviado,
        entregado
    }
}
