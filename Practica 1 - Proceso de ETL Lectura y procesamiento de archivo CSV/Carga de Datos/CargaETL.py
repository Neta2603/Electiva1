import pyodbc
import pandas as pd
from graphviz import Digraph

# Función de Extracción
def extract_data(connection_string, query):
    print("Extrayendo datos...")
    try:
        connection = pyodbc.connect(connection_string)
        df = pd.read_sql(query, connection)
        connection.close()
        print("Datos extraídos exitosamente.")
        return df
    except Exception as e:
        print(f"Error durante la extracción: {e}")
        raise

# Función de Transformación
def transform_data(df):
    print("Transformando datos...")
    try:
        if "OrderDate" in df.columns:
            df["OrderDate"] = pd.to_datetime(df["OrderDate"], errors='coerce')
        if "ShippedDate" in df.columns:
            df["ShippedDate"] = pd.to_datetime(df["ShippedDate"], errors='coerce')
            df["DaysToShip"] = (df["ShippedDate"] - df["OrderDate"]).dt.days
        print("Transformación completada.")
        return df
    except Exception as e:
        print(f"Error durante la transformación: {e}")
        raise

# Función de Carga
def load_data(df, archivoSalida):
    print(f"Cargando datos en {archivoSalida}...")
    try:
        df.to_csv(archivoSalida, index=False, encoding="utf-8")
        print("Datos cargados exitosamente.")
    except Exception as e:
        print(f"Error durante la carga: {e}")
        raise

# Representar el flujo ETL con Graphviz
def create_etl_diagram(archivoSalida):
    print(f"Creando diagrama ETL en {archivoSalida}.png...")
    try:
        dot = Digraph(comment='Proceso ETL')
        dot.node('A', 'Extracion de Datos')
        dot.node('B', 'Transformación de datos')
        dot.node('C', 'Exportacion de archivo')

        dot.edge('A', 'B')
        dot.edge('B', 'C')
        dot.render(archivoSalida, format='png', cleanup=True)
        print(f"Diagrama creado exitosamente en {archivoSalida}.png.")
    except Exception as e:
        print(f"Error al crear el diagrama: {e}")
        raise

def main():
    connection_string = (
        "Driver={SQL Server};"
        "Server=NEFTALIPC;"
        "Database=Northwind;"
        "Trusted_Connection=yes;"
    )
    query = "SELECT * FROM Orders"
    output_csv = "orders.csv"
    diagram_file = "diagrama"

    # Ejecución del proceso ETL
    try:
        df = extract_data(connection_string, query)
        transformed_df = transform_data(df)
        load_data(transformed_df, output_csv)
        create_etl_diagram(diagram_file)
    except Exception as e:
        print(f"Error en el proceso ETL: {e}")

if __name__ == "__main__":
    main()