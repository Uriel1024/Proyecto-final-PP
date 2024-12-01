import java.sql.Connection;
import java.sql.SQLOutput;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Scanner;
import java.time.*;

public class Main {
    public static void main(String[] args){
        Scanner in = new Scanner(System.in);

        ConexionBD c1 = new ConexionBD();
        c1.conectar();
        Connection connection = c1.getConexion();
        VideojuegosDAO v1 = new VideojuegosDAO(connection);
        UsuariosDAO u1 = new UsuariosDAO(connection);
        UsuariosDAO.RolUsuario rolUsuario = null;
        DetallesPedidoDAO d1 = new DetallesPedidoDAO(connection);
        PedidosDAO p1 = new PedidosDAO(connection);
        PedidosDAO.estadoPedidos estadoPedido = null;
        ExtensionesVIdeojuegosDAO e1 = new ExtensionesVIdeojuegosDAO(connection);

        boolean test;
        int op,op1, id;

        do{
            menu();
            op = in.nextInt();
            switch(op){
                case 1:
                    consultarDatos();
                    op1 = in.nextInt();
                    switch(op1){
                        case 1:
                            System.out.println("Ingresa el ID del videojuego a buscar: ");
                            id = in.nextInt();
                            v1.consultarVideojuego(id);
                            break;
                        case 2:
                            System.out.println("Ingresa el ID del usuario a buscar:");
                            id = in.nextInt();
                            u1.consultarUsuario(id);
                            break;
                        case 3:
                            System.out.println("Ingresa el ID del pedido a buscar: ");
                            id = in.nextInt();
                            p1.consultarPedidos(id);
                            break;
                        case 4:
                            System.out.println("Ingresa el ID de los detalles del  pedido a buscar:");
                            id = in.nextInt();
                            d1.consultarDetallesPedido(id);
                            break;
                        case 5:
                            System.out.println("Ingresa el ID de la extension a buscar: ");
                            id = in.nextInt();
                            e1.consultarExtensiones(id);
                            break;
                        default:
                            System.out.println("Opcion no valida, inserta un opcion valida.");
                            break;
                    }
                    break;
                case 2:
                    ingresarDatos();
                    op1 = in.nextInt();
                    switch(op1){
                        case 1:

                            System.out.println("Ingresa el nombre del videojuego:");
                            in.nextLine();
                            String nombre = in.nextLine();
                            System.out.println("Ingresa la plataforma del videojuego: ");
                            String plataforma = in.nextLine();
                            System.out.println("Ingresa el precio del videojuego: ");
                            double precio = in.nextDouble();
                            System.out.println("Ingresa la cantidad de stock del videojuego: ");
                            int stock = in.nextInt();
                            System.out.println("Ingresa el desarrollador del videojuego: ");
                            in.nextLine();
                            String desarrol = in.nextLine();
                            System.out.println("Ingresa la fecha de lanzamiento del videojuego (dd/mm/yyyy):");
                            String fecha = in.next();

                            v1.agregarVideojuego(nombre,plataforma,precio,stock,desarrol,stringToLocalDate(fecha));
                            break;
                        case 2:
                            System.out.println("Ingresa el nombre del usuario :");
                            in.nextLine();
                            String nombreu = in.nextLine();
                            System.out.println("Ingresa el primer apellido del usuario: ");
                            String apellido1 = in.nextLine();
                            System.out.println("Ingresa el segundo apellido del usuario: ");
                            String apellido2 = in.nextLine();
                            System.out.println("Ingresa el email del usuario: ");
                            String email = in.nextLine();
                            System.out.println("Ingresa la direccion del usuario: ");
                            String direccion = in.nextLine();
                            System.out.println("Ingresa el telefono del usuario: ");
                            String telefono = in.nextLine();
                            System.out.println("Ingresa el rol del usuario (administrador / cliente)");
                            String rol = in.nextLine().trim().toLowerCase();
                            try{
                                rolUsuario = UsuariosDAO.RolUsuario.valueOf(rol);
                                System.out.println("Rol seleccionado: " + rolUsuario);
                                u1.agregarUsuario(nombreu,apellido1,apellido2,email,direccion,telefono,rolUsuario);
                            }catch(IllegalArgumentException e){
                                System.out.println("Rol no valido.");
                            }
                            break;
                        case 3:
                            System.out.println("Ingresa el ID del usuario: ");
                            int id1 = in.nextInt();
                            System.out.println("Ingresa la fecha del pedido (dd/mm/yyyy): ");
                            in.nextLine();
                            String fecha1 = in.next();
                            System.out.println("Ingresa el estado del pedido(pendiente,enviado,entregado): ");
                            in.nextLine();
                            String estado1 = in.nextLine().trim().toLowerCase();
                            try{
                                estadoPedido = PedidosDAO.estadoPedidos.valueOf(estado1);
                                System.out.println("El estado es: " + estado1);
                                p1.ingresarPedido(id1, stringToLocalDate(fecha1),estadoPedido);
                            }catch (IllegalArgumentException e){
                                System.out.println("Estado no valido.");
                            }
                            break;
                        case 4:
                            System.out.println("Ingresa el ID del videojuego: ");
                            id = in.nextInt();
                            test = v1.buscarVideojuego(id);
                            if(test){
                                System.out.println("Ingresa el nombre de la extension:   ");
                                in.nextLine();
                                String extension = in.nextLine();
                                System.out.println("Ingresa el precio de la extension: ");
                                double prec = in.nextDouble();
                                System.out.println("Ingresa la descripcion de la extension: ");
                                in.nextLine();
                                String descripcion = in.nextLine();
                                System.out.println("Ingresa le fecha de la extension (dd/mm/yyyy):");
                                String fecha2 = in.next();
                                e1.agregarExtension(id,extension,prec,descripcion,stringToLocalDate(fecha2));
                            }else{
                                System.out.println("Videojuego con ID no encontrado. ");
                            }
                            break;
                    }
                    break;
                case 3:
                    eliminarDatos();
                    op1 = in.nextInt();
                    switch(op1){
                        case 1:
                            System.out.println("Ingresa el ID del videojuego a eliminar: ");
                            id = in.nextInt();
                            v1.eliminarVideojuego(id);
                            break;
                        case 2:
                            System.out.println("Ingresa el ID del usuario a eliminar: ");
                            id = in.nextInt();
                            u1.eliminar_usuario(id);
                            break;
                        case 3:
                            System.out.println("Ingresa el ID del pedido a eliminar:");
                            id = in.nextInt();
                            p1.eliminarPedido(id);
                            break;
                        case 4:
                            System.out.println("Ingresa el ID de la extension a eliminar: ");
                            id = in.nextInt();
                            e1.eliminarExtension(id);
                            break;
                    }
                    break;
                case 4:
                    System.out.println("Programa finalizado");
                    c1.desconectar();
                    break;
                default:
                    System.out.println("Opcion no valida, ingresa una opcion valida.");
                    break;
            }
        }while(op != 4);

    }


    public static LocalDate stringToLocalDate(String date) {
        final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        try {
            return LocalDate.parse(date, dateTimeFormatter);
        } catch (DateTimeParseException e) {
            System.out.println("Error: La fecha no tiene el formato correcto (dd/MM/yyyy).");
            return null;
        }
    }


    public static void menu(){
        System.out.println("1.Consultar datos");
        System.out.println("2.Ingresar datos");
        System.out.println("3.Eliminar datos");
        System.out.println("4.Salir");
        System.out.println("Ingresa una opcion para poder continuar");
    }

    public static void consultarDatos(){
        System.out.println("1.Videojuegos.");
        System.out.println("2.Usuario.");
        System.out.println("3.Pedidos.");
        System.out.println("4.Detalle de pedidos.");
        System.out.println("5.Extension de videojuegos");
        System.out.println("Selecciona una tabla para buscar un elemento: ");
    }

    public static void ingresarDatos(){
        System.out.println("1.Videojuegos.");
        System.out.println("2.Usuario.");
        System.out.println("3.Pedidos.");
        System.out.println("4.Extensiones videojuegos");
        System.out.println("Selecciona una tabla para agregar un elemento: ");
    }

    public static void eliminarDatos(){
        System.out.println("1.Videojuegos.");
        System.out.println("2.Usuarios.");
        System.out.println("3.Pedidos.");
        System.out.println("4.Extensiones videojuegos");
        System.out.println("Selecciona una tabla para eliminar un elemento: ");
    }
}