# Base de Datos AdventureWorks

## Descarga

[⬇️ Descargar backup](https://upds-my.sharepoint.com/:f:/g/personal/tj_orlando_aguilera_z_upds_net_bo/IgCvi_57xX07TZWFjlxdUzdxAeQ9ZsJdqkdXcfENv2TBNl0?e=Sd2Tjq)

> Si el enlace no funciona, copia y pega esta URL en el navegador:
> (https://upds-my.sharepoint.com/:f:/g/personal/tj_orlando_aguilera_z_upds_net_bo/IgCvi_57xX07TZWFjlxdUzdxAeQ9ZsJdqkdXcfENv2TBNl0?e=Sd2Tjq)

---

## Restauración en DBeaver

### 1. Crear la base de datos

1. En el panel izquierdo, hacer clic derecho sobre la conexión de PostgreSQL
2. Seleccionar **Create → Database**
3. Escribir el nombre: `adventureworks`
4. Clic en **OK**

### 2. Abrir la herramienta de restauración

1. Hacer clic derecho sobre la base de datos `adventureworks` recién creada
2. Seleccionar **Tools → Restore**

### 3. Configurar la restauración

1. En el campo **Backup file**, hacer clic en el ícono de carpeta 📁
2. Buscar y seleccionar el archivo `dump-adventureworks-...backup` descargado
3. En el campo **Format**, seleccionar **Custom**
4. Clic en **Start**

### 4. Verificar

1. Hacer clic derecho sobre `adventureworks` → **Refresh**
2. Expandir **Schemas → public → Tables**
3. Deben aparecer las tablas de AdventureWorks
