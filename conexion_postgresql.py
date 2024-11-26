# Importamos las bibliotecas necesarias
# psycopg2: Proporciona una interfaz para interactuar con PostgreSQL desde Python.
# logging: Permite registrar eventos y errores de manera organizada.
# configparser: Para leer configuraciones desde un archivo externo.
# os: Para realizar operaciones relacionadas con el sistema de archivos, como verificar la existencia de archivos.
import psycopg2
import logging
from psycopg2 import sql
from configparser import ConfigParser
import os

# Configuración del sistema de logs
# Los logs permiten rastrear lo que hace el programa y detectar problemas fácilmente.
logging.basicConfig(
    level=logging.INFO,  # Nivel de registro (INFO muestra información general, ERROR para errores)
    format="%(asctime)s - %(levelname)s - %(message)s",  # Formato del mensaje en los logs
    handlers=[
        logging.StreamHandler(),  # Muestra los logs en la consola.
        logging.FileHandler("db_connection.log", mode="w", encoding="utf-8")  # Guarda los logs en un archivo.
    ]
)

def cargar_configuracion(config_file="db_config.ini"):
    """
    Carga la configuración de la base de datos desde un archivo INI.
    :param config_file: Nombre del archivo de configuración.
    :return: Diccionario con los parámetros de conexión.
    """
    # Verifica si el archivo de configuración existe.
    # Esto previene errores al intentar cargar un archivo inexistente.
    if not os.path.exists(config_file):
        logging.error("El archivo de configuración no existe.")  # Mensaje de error en los logs.
        raise FileNotFoundError(f"No se encontró el archivo: {config_file}")  # Detenemos la ejecución.

    # Si el archivo existe, lo leemos usando ConfigParser.
    config = ConfigParser()  # Instancia para manejar configuraciones tipo INI.
    config.read(config_file)  # Cargamos el archivo INI.
    # Retorna los parámetros bajo la sección [postgresql].
    return config['postgresql']

def conectar_base_datos(config):
    """
    Establece una conexión con la base de datos PostgreSQL.
    :param config: Diccionario con parámetros de conexión.
    :return: Objeto de conexión de psycopg2.
    """
    try:
        # Intenta conectarse a PostgreSQL usando los parámetros proporcionados.
        conexion = psycopg2.connect(**config)  # **config pasa los valores como argumentos clave-valor.
        logging.info("Conexión exitosa a la base de datos.")  # Mensaje de éxito en los logs.
        return conexion  # Devuelve el objeto de conexión para su uso posterior.
    except psycopg2.OperationalError as e:
        # Captura errores relacionados con conexión, como credenciales incorrectas.
        logging.error(f"Error de conexión: {e}")  # Registra el error en los logs.
        raise  # Lanza el error para que pueda ser manejado por el programa principal.
    except Exception as e:
        # Captura cualquier otro tipo de error inesperado.
        logging.error(f"Error inesperado al conectar: {e}")
        raise

def ejecutar_query(conexion, query, parametros=None):
    """
    Ejecuta un query SQL en la base de datos.
    :param conexion: Objeto de conexión a PostgreSQL.
    :param query: Sentencia SQL que se ejecutará.
    :param parametros: Tupla con parámetros para la consulta.
    :return: Resultado de la consulta en caso de SELECT; None en otros casos.
    """
    try:
        # Creamos un cursor usando 'with'. Esto asegura que se cierre automáticamente después de usarlo.
        with conexion.cursor() as cursor:
            # Ejecuta la consulta SQL. Si hay parámetros, se pasan de forma segura.
            cursor.execute(query, parametros)
            if query.strip().lower().startswith("select"):
                # Si el query es un SELECT, obtenemos los resultados.
                resultado = cursor.fetchall()  # fetchall() devuelve todas las filas.
                return resultado  # Retornamos los resultados para procesarlos más adelante.
            else:
                # Para consultas como INSERT, UPDATE o DELETE.
                conexion.commit()  # Confirmamos los cambios en la base de datos.
                return None  # No hay resultados que devolver.
    except psycopg2.DatabaseError as e:
        # Manejo de errores relacionados con la base de datos.
        logging.error(f"Error al ejecutar query: {e}")  # Mensaje de error en los logs.
        conexion.rollback()  # Revertimos cualquier cambio hecho antes del error.
        raise  # Re-lanzamos el error para que sea manejado más arriba.
    except Exception as e:
        # Captura errores no específicos.
        logging.error(f"Error inesperado: {e}")
        raise

def validar_parametros(query, parametros):
    """
    Valida que los parámetros coincidan con los marcadores del query.
    :param query: Sentencia SQL que contiene marcadores (%s).
    :param parametros: Tupla con los valores para los marcadores.
    :return: True si la validación es correcta.
    """
    if parametros and not isinstance(parametros, tuple):
        # Validamos que los parámetros sean una tupla.
        raise ValueError("Los parámetros deben estar en una tupla.")
    if query.count('%s') != len(parametros or []):
        # Validamos que el número de parámetros coincida con los marcadores en el query.
        raise ValueError("El número de parámetros no coincide con los marcadores en el query.")
    return True  # Si todo está correcto, devolvemos True.

def main():
    """
    Programa principal que gestiona la conexión y realiza consultas de prueba.
    """
    # Paso 1: Cargar configuración desde un archivo INI.
    try:
        # Intentamos cargar las configuraciones de conexión.
        config = cargar_configuracion()
    except Exception as e:
        # Si falla, registramos un error crítico y salimos del programa.
        logging.critical(f"No se pudo cargar la configuración: {e}")
        return

    # Paso 2: Conectarse a la base de datos.
    try:
        # Intentamos establecer la conexión.
        conexion = conectar_base_datos(config)
    except Exception as e:
        # Si falla, registramos un error crítico y salimos del programa.
        logging.critical(f"No se pudo establecer la conexión: {e}")
        return

    # Paso 3: Realizar consultas.
    try:
        # Consulta 1: Mostrar todos los usuarios registrados en la tabla 'usuarios'.
        query_usuarios = "SELECT * FROM usuarios;"
        usuarios = ejecutar_query(conexion, query_usuarios)
        logging.info("Usuarios registrados:")
        for usuario in usuarios:  # Iteramos sobre cada usuario obtenido.
            logging.info(usuario)  # Registramos la información en los logs.

        # Consulta 2: Insertar un nuevo videojuego en la tabla 'Videojuegos'.
        query_insertar_videojuego = """
        INSERT INTO Videojuegos (titulo, plataforma, precio, stock, desarrollador, fecha_lanzamiento)
        VALUES (%s, %s, %s, %s, %s, %s);
        """
        # Datos del nuevo videojuego.
        nuevo_videojuego = ('Pac-Man', 'PC', 199.99, 50, 'Namco', '1980-05-22')
        validar_parametros(query_insertar_videojuego, nuevo_videojuego)  # Validamos antes de ejecutar.
        ejecutar_query(conexion, query_insertar_videojuego, nuevo_videojuego)
        logging.info("Nuevo videojuego insertado.")

        # Consulta 3: Obtener videojuegos con stock mayor a 20 unidades.
        query_videojuegos = "SELECT titulo, stock FROM Videojuegos WHERE stock > %s;"
        videojuegos = ejecutar_query(conexion, query_videojuegos, (20,))
        logging.info("Videojuegos con stock mayor a 20:")
        for videojuego in videojuegos:  # Iteramos sobre cada videojuego obtenido.
            logging.info(videojuego)  # Registramos los datos en los logs.
    except Exception as e:
        # Si ocurre algún error durante las consultas, lo registramos.
        logging.error(f"Error durante las operaciones: {e}")
    finally:
        # Paso 4: Cerrar la conexión a la base de datos.
        try:
            conexion.close()  # Cerramos la conexión explícitamente.
            logging.info("Conexión cerrada.")
        except Exception as e:
            # Si falla al cerrar, registramos el error.
            logging.error(f"No se pudo cerrar la conexión: {e}")

# Punto de entrada del programa.
if __name__ == "__main__":
    main()
