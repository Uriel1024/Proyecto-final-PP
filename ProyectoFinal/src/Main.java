import java.sql.Connection;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;
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
                            System.out.println(stringToLocalDate(fecha));
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
                            }catch(IllegalArgumentException e){
                                System.out.println("Rol no valido.");
                            }
                            u1.agregarUsuario(nombreu,apellido1,apellido2,email,direccion,telefono,rolUsuario);
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
        System.out.println("2.Usuario");
        System.out.println("Selecciona una tabla para buscar un elemento: ");
    }

    public static void ingresarDatos(){
        System.out.println("1.Videojuegos.");
        System.out.println("2.Usuario");
        System.out.println("Selecciona una tabla para agregar un elemento: ");
    }

    public static void eliminarDatos(){
        System.out.println("1.Videojuegos");
        System.out.println("2.Usuarios");
        System.out.println("Selecciona una tabla para eliminar un elemento: ");
    }
}