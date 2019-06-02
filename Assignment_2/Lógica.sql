--Secuencia para la tabla programci�n_mtto
CREATE SEQUENCE PROG_MTTO_SEQ
START WITH 100510
MINVALUE 100510
MAXVALUE 100999
INCREMENT BY 1
CYCLE;

--Secuencia para la tabla detalle_prog_mtto
CREATE SEQUENCE DETALLE_MTTO_SEQ
START WITH 100100
MINVALUE 100100
MAXVALUE 100499
INCREMENT BY 1
CYCLE;

--Secuencia para la tabla cotizador
CREATE SEQUENCE COTIZADOR_SEQ
START WITH 103000
MINVALUE 103000
MAXVALUE 128000
INCREMENT BY 1
CYCLE;

--select COTIZADOR_SEQ.nextval from dual;
--SET SERVEROUTPUT ON SIZE UNLIMITED
--drop sequence COTIZADOR_SEQ
--DROP SEQUENCE PROG_MTTO_SEQ
--DROP SEQUENCE DETALLE_MTTO_SEQ

/*1. Crear datos para la soluci�n de problemas, para esto pueden utilizar mockaroo.com, lo m�nimo requerido es:
50 empleados
100 clientes
10 veh�culos
Los centros de recibo reales de Coordinadora https://www.coordinadora.com/centros-de-recibo/
Los planes de mantenimiento expuestos en el problema pasado.
500 env�os o gu�as entre diferentes ciudades y en diferentes estados (La mayor�a que est�n en estado "pendiente" o "por enviar") */

select count(*) from empleados
select count(*) from clientes
select count(*) from vehiculos
select count(*) from guia
select * from plan_mtto
select count (*) from centro_recibos

/* 2 .Crear una vista llamada "plan_mantenimiento_detallado" el cu�l deber� mostrar que cosas se realizan en ese plan de mantenimiento. 
La idea es invocarlo de esta manera "select * from plan_mantenimiento_detallado where kilometraje = 5000" 
(Ya usted decide si quiere crear una columna num�rica o si quiere manejarlo usando LIKE en el campo del nombre del mantenimiento)*/

create or replace view plan_mantenimiento_detallado as
select p.nombre as Nombre_Plan, i.nombre as Nombre_Item
from plan_mtto p
inner join detalle_plan_mtto d on d.id_plan_mtto=p.id
inner join items i on i.id=d.id_item

--Ejecuci�n Vista plan_mantenimiento_detallado
select * from plan_mantenimiento_detallado where Nombre_Plan LIKE '%&plan%'

/*3. Crear un procedimiento almacenado llamado "Programar_mantenimiento" el cu�l debe recibir el id de un veh�culo. 
El procedimiento deber� calcular cu�ntos kil�metros faltan para el pr�ximo mantenimiento, 
si faltan menos de 200 kil�metros deber� programar el mantenimiento con fecha prevista de mantenimiento 
2 dias despu�s de la fecha en la cual se invoque el procedimiento el mantenimiento y 
debera tener sus respectivos items con estado pendiente. 
El procedimiento deber� tener una excepci�n si el id que se pase como par�metro es negativo o igual a cero.
El mantenimiento debe hacerse en el centro de recibo que est� asignado para ese veh�culo y deber� asignar un mec�nico del mismo lugar.
Ejemplo: Un veh�culo tiene 14900 km y se invoca el procedimiento, 
deber� crear y programar el siguiente mantenimiento que es de 15.000km con todos sus items en estado pendiente.*/

--select * from vehiculos whe

create or replace procedure Programar_mantenimiento (id_vehiculo vehiculos.id%type) 
is
total_registros integer;
idvehiculo vehiculos.id%type;
kilometraje vehiculos.kilometraje%type;
idcentror vehiculos.id_centror%type;
empleado empleados.id%type;
id empleados.id%type;
invalid exception;
plan1 number := 5000;
plan2 number := 10000;
plan3 number := 20000;
plan4 number := 40000;
plan5 number := 50000;
plan6 number := 100000;
comparacion number := 0;
fecha date;
begin
idvehiculo := id_vehiculo;
if idvehiculo <= 0 then
    raise invalid;
end if; 
    select v.id, v.kilometraje, v.id_centror into idvehiculo, kilometraje, idcentror from vehiculos v where v.id = idvehiculo;
        select id into empleado from   
            (select e.id from empleados e
                where e.id_centror = idcentror and e.cargo='Mec�nico'
                order by dbms_random.value)  
                where rownum = 1;
           case true
                when kilometraje < plan1 then
                    comparacion := plan1 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100050,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                        end if;
                when kilometraje < plan2 then
                    comparacion := plan2 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100051,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                    end if;
                when kilometraje < plan3 then
                    comparacion := plan3 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100052,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                    end if;
                when kilometraje < plan4 then
                    comparacion := plan4 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100053,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                    end if;
                when kilometraje < plan5 then
                    comparacion := plan5 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100054,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                    end if;
                 when kilometraje < plan6 then
                    comparacion := plan6 - kilometraje;
                    if comparacion <= 200 then
                        fecha := SYSDATE + 2;
                        insert into programacion_mtto values (PROG_MTTO_SEQ.NEXTVAL,idvehiculo,to_date (fecha, 'DD/MM/YYYY'),
                        empleado,100055,'Pendiente','Por atender');
                        dbms_output.put_line('Vehiculo Programado Con �xito');
                            else dbms_output.put_line('A�n no se cumple el kilometraje m�nimo para programar mantenimiento al vehiculo');  
                    end if;
                else dbms_output.put_line('El kilometraje no ha sido asignado por el taller, consulte con el jefe de taller');  
            end case;
    total_registros := sql%ROWCOUNT;
    dbms_output.put_line('El numero de registros es: ' || total_registros);
    --dbms_output.put_line('El vehiculo : ' || idvehiculo || ' Tiene un total de ' || kilometraje || ' Kilometros' || empleado);
    exception
when invalid then
    dbms_output.put_line('El valor ingresado debe ser mayor a 0');
when no_data_found then
    dbms_output.put_line('No se encontraron registros con el id ingresado');
end;	

--Ejecuci�n procedimiento Programar_mantenimiento
EXEC Programar_mantenimiento(&id);

--select * from vehiculos
--select * from programacion_mtto
--select * from detalle_prog_mtto
--select * from plan_mtto
--select * from empleados where cargo='Mec�nico' and id_centror=100063
--select * from centro_recibos where id=100069

/*Para este punto fue necesario crear un trigger (after) sobre la tabla programacion_mtto para que cuando una vez se realice la 
programaci�n del mantenimiento se asigne en estado "Pendiente" todos lis items que correspondan al plan.*/

create or replace trigger items_x_mtto after insert on programacion_mtto for each row
declare
    iddetalle detalle_prog_mtto.id_detalle%type;
    idprogramacion detalle_prog_mtto.id_programacion%type;
    idplanmtto detalle_plan_mtto.id_plan_mtto%type;
        CURSOR items_x_mtto is select d.id
                               from plan_mtto p inner join detalle_plan_mtto d on d.id_plan_mtto=p.id inner join items i on i.id=d.id_item
                               where d.id_plan_mtto=idplanmtto;
begin
    idprogramacion := :new.id;
    idplanmtto := :new.id_plan_mtto;
open items_x_mtto;
        loop
            fetch items_x_mtto into iddetalle;
            exit when items_x_mtto%notfound;
            --dbms_output.put_line('EL id de detalle es ' || iddetalle); 
            insert into detalle_prog_mtto values(DETALLE_MTTO_SEQ.NEXTVAL,idprogramacion,iddetalle,'Pendiente','Sin novedad');
        end loop;
close items_x_mtto;  
end;

/*select d.id, d.id_programacion, d.id_detalle, i.nombre, d.estado, d.observaciones 
from detalle_prog_mtto d
inner join detalle_plan_mtto de on de.id=d.id_detalle
inner join items i on i.id=de.id_item*/
--delete from detalle_prog_mtto
--delete from programacion_mtto

/*4. Crear un trigger sobre la tabla de los veh�culos, cuando cambie el kilometraje de veh�culo deber� invocar el procedimiento 
"Programar_mantenimiento"*/

--select * from vehiculos
--select * from programacion_mtto
--update vehiculos set kilometraje=49900 where id=4000
--select * from vehiculos where id=4000
--drop trigger Programar_mantenimiento
--select * from detalle_plan_mtto
--select * from plan_mtto
--select * from detalle_prog_mtto

create or replace trigger Programar_mantenimiento for update on vehiculos compound trigger
    valor number;
    after each row is
    begin
        valor := :new.id;
    end after each row;
    after statement is
    begin
        Programar_mantenimiento(valor);
        dbms_output.put_line('El id actualizado es ' || valor);
    end after statement;
end;

/*5. La junta directiva desea realizar un cotizador de precios de los env�os, para esto es necesario crear una matriz de precios 
similar a la que se maneja en la realidad (Ver secci�n Tarifas de mensajer�a y paquetes hasta 5 kilos). 
Para esto se decide crear una nueva tabla que tendr� las siguientes columnas: centro_recib_id (Clave for�nea con la tabla 
de centros de recibo), destino_id (Clave for�nea a la tabla c�digos postales o ciudades), precio_kilo (decimal).*/

/*Para llenar esta tabla usted crear� una procedimiento llamado "recalcular_tarifas", este procedimiento lo que har� es los siguiente:

Borrar todos los datos de la tabla donde se guardan los precios.
Leer todos los centros de recibo y empezar a recorrerlos uno a uno.
Por cada centro de recibo deber� leer todas las ciudades o c�digos postales.
Deber� generar un decimal aleatorio entre 400 y 1500
Luego insertar� en la tabla el id del centro de recibo, el id de la ciudad o del c�digo postal y el valor generado.*/

--20 centros de recibo * 1122= 22440

--TABLA COTIZADOR
create table cotizador(
id number primary key not null,
id_centror number,
id_mpio_destino number,
id_depto_destino number,
precio_x_kilo decimal
);

alter table cotizador
add (
foreign key (id_mpio_destino) references MUNICIPIOS (ID),
foreign key (id_centror) references CENTRO_RECIBOS (ID),
foreign key (id_depto_destino) references DEPARTAMENTOS (ID)
);

--select * from cotizador
--delete from cotizador
--select count(*) from cotizador
--select * from municipios

create or replace procedure recalcular_tarifas is
idcentror centro_recibos.id%type;
idmpiodestino municipios.id%type;
iddeptodestino departamentos.id%type;
result cotizador.precio_x_kilo%type;
    cursor precio_x_kilo is select c.id from centro_recibos c;
begin
delete from cotizador;
dbms_output.put_line('Precios borrados �xito'); 
    open precio_x_kilo;
    loop
            fetch precio_x_kilo into idcentror;
                exit when precio_x_kilo%notfound;
                    for idmpiodestino in (select m.id, m.id_depto from municipios m) loop
                            result := dbms_random.value(400,1500);
                            insert into cotizador values(COTIZADOR_SEQ.NEXTVAL,idcentror,idmpiodestino.id,idmpiodestino.id_depto,result);
                            --dbms_output.put_line('EL id es ' || COTIZADOR_SEQ.NEXTVAL || ' EL centro de re es ' || idcentror || ' El mpio destino es ' || idmpiodestino.id || ' El aleatorio es ' || result || ' El id ' || idmpiodestino.id_depto); 
                    end loop;
    end loop;
    close precio_x_kilo;
end;

--Ejecuci�n procedimiento recalcular_tarifas
EXEC recalcular_tarifas;

/*6, Crear una vista la cual traiga todos los precios por kilo de todas las ciudades destino y como ciudad origen recibir� 
un string "Barranquilla, Medell�n, Cali". Es importante recordar que la liquidaci�n de precios solo se hizo teniendo 
como base las ciudades de cada centro de recibo. 
Ejemplo SELECT * FROM PRECIOS WHERE ORIGEN = 'BARRANQUILLA'. (Observe que no se est� pasando el id del centro de recibo, 
se est� pasando la ciudad a la que pertenece el centro de recibo, por ende hay que hacer los JOINS correspondientes para 
obtener el listado de precios.

Origen	Destino	Nombre Destino	Precio
BARRANQUILLA	234	Acac�as	300
BARRANQUILLA	235	Armenia	500
BARRANQUILLA	236	Marinilla	1200*/


--NOTA: Ac� se presenta duplicidad de datos ya que hay municipios que tienen el mismo nombre pero en diferente departamente ej:RIONEGRO
create or replace view recalcular_tarifas_view as
select c.id_centror, m.nombre_mpio AS Origen, c.id_mpio_destino as Id_Destino, mm.nombre_mpio as Nombre_Destino, c.precio_x_kilo as Precio,
        d.id as Id_Depto_Destino, d.nombre_depto as Nombre_Departamento
from cotizador c
inner join centro_recibos ce on ce.id=c.id_centror
inner join municipios m on m.id=ce.id_mpio
inner join municipios mm on mm.id=c.id_mpio_destino
inner join departamentos d on d.id=c.id_depto_destino

--Ejecuci�n Vista
select * from recalcular_tarifas_view where Origen LIKE '&nombre_origen' 

--Ejecuci�n Vista Alternativa para conocer los departamentos en comun.
select * from recalcular_tarifas_view 
where Origen LIKE '&nombre_origen' and Nombre_Destino = '&nombre_destino' or Nombre_Departamento = '&nombre_depto_destino'

--Ejecuci�n Vista Final
select * from recalcular_tarifas_view 
where Origen LIKE '&nombre_origen' and Nombre_Destino = '&nombre_destino' and Nombre_Departamento = '&nombre_depto_destino'

/*7. Crear un procedimiento llamado "calcular_peso_volumetrico", dicho procedimiento deber� leer todos los registros de la tabla 
de env�os y llenar el campo "peso volumen", para esto aplicar� la f�rmula expuesta en el taller anterior: se obtiene 
multiplicando el ancho x el alto x el largo y luego se multiplica por 400 que es el factor de equivalencia por cada metro c�bico)*/

--SELECT * FROM GUIA
--select peso_real, ancho, largo, alto, round(peso_volumen) from guia

create or replace procedure calcular_peso_volumetrico
is
idguia guia.id%type;
ancho guia.ancho%type;
largo guia.largo%type;
alto guia.alto%type;
pesovolumen guia.peso_volumen%type;
    CURSOR calculo_volumen is 
        select g.id, g.ancho, g.largo, g.alto from guia g;
begin
    open calculo_volumen;
        loop
            fetch calculo_volumen into idguia, ancho, largo, alto;
            exit when calculo_volumen%notfound;
            pesovolumen := ((ancho/100)*(alto/100)*(largo/100))*400;
            --dbms_output.put_line('EL id es ' || idguia || ' EL ancho es ' || ancho || ' El largo es ' || largo || ' El alto es ' || alto); 
            --dbms_output.put_line('EL resultado es ' || pesovolumen );
            update guia set peso_volumen=pesovolumen where id = idguia;
        end loop;
    close calculo_volumen;
end;

--Ejecuci�n procedimiento Programar_mantenimiento
EXEC calcular_peso_volumetrico;

--select * from guia
--update guia set valor_servicio=0

/*8. Crear una funci�n que retornar� un decimal, dicha funci�n recibir� las siguientes variables: peso_real, peso_volumen, 
centro_recibo_origen, ciudad_destino. Dicha funci�n deber� comparar el valor mayor entre peso_real y peso_volumen, 
con ese valor deber� buscar el precio por kilo de la ciudad hacia donde se dirige el paquete. 
Para esto invocar� la vista del punto anterior y el precio deber� multiplicarlo por la cantidad del peso del paquete. 
Validar con excepciones que los pesos sean mayores a 0 y los centros de recibo y la ciudad destino no est�n en blanco.*/

--NOTA: Ac� se presenta duplicidad de datos ya que hay municipios que tienen el mismo nombre pero en diferente departamente ej:RIONEGRO
--Para evitar eso es necesario agregar otra variable de entrada (id_municipio)

create or replace function calculo_valor_precio (pesoreal in guia.peso_real%type, pesovolumen in guia.peso_volumen%type, 
                                                 centroreciboorigen in centro_recibos.id%type, ciudaddestino in municipios.nombre_mpio%type,
                                                 departamentodestino in departamentos.nombre_depto%type)
return decimal is
valor decimal;
result number;
preciot number;
invalid exception;
invalid2 exception;
begin
if pesoreal <= 0 or pesovolumen <= 0 then
    raise invalid;
end if;
if ciudaddestino is null then
    raise invalid2;
end if;
if pesoreal > pesovolumen then
    result := pesoreal;
    dbms_output.put_line('Es mayor el peso real' || pesoreal);
else
    result := pesovolumen;
    dbms_output.put_line('El mayor el peso volumen:' || pesovolumen);
end if;
select precio into preciot from recalcular_tarifas_view where id_centror=centroreciboorigen and nombre_destino LIKE ciudaddestino and Nombre_Departamento=departamentodestino;
valor := result*preciot;
return valor;
exception
when invalid then
    dbms_output.put_line('El valor ingresado debe ser mayor a 0');
when invalid2 then
    dbms_output.put_line('Este campo no puede estar vacio');
when others then
    dbms_output.put_line('Ha ocurrido un error vuelva a interntarlo');
end;

--Ejecuci�n de la fucnion calculo_valor_precio
select calculo_valor_precio (&peso_real,&peso_volumen,&id_centror,'&ciudad_destino','&depto_destino') from dual;

--SELECT * FROM GUIA WHERE ID=101284
--SELECT * FROM GUIA WHERE ID=101196

--Ejecici�n Vista Alternativa
select * from recalcular_tarifas_view 
where Origen LIKE '&nombre_origen' and nombre_destino = '&nombre_destino' or Nombre_Departamento = '&nombre_depto_destino'

/*9. Crear un procedimiento llamado "calcular_fletes", el cual seleccionar� aquellos env�os donde el campo "valor del servicio" 
est� 0 o nullo. Con cada uno de ellos deber� invocar la funci�n creada en el punto anterior y con el valor retornado, 
deber� llenar el campo "valor del servicio".*/

--SELECT * FROM GUIA

create or replace procedure calcular_fletes 
is
idguia guia.id%type;
pesoreal guia.peso_real%type;
ancho guia.ancho%type;
largo guia.largo%type;
alto guia.alto%type;
pesovolumen guia.peso_volumen%type;
idmpioorigen guia.id_mpio_origen%type;
idmpiodestino guia.id_mpio_destino%type;
valorservicio guia.valor_servicio%type;
idmpioorigennew guia.id_mpio_origen%type;
idmpioorigennew2 guia.id_mpio_origen%type;
nombrempio municipios.nombre_mpio%type;
nombrempionew municipios.nombre_mpio%type;
deptodestino municipios.id_depto%type;
deptodestinofor departamentos.id%type;
deptodestinonew departamentos.nombre_depto%type;

cursor calcular_fletes is select g.id, g.peso_real, g.ancho, g.largo, g.alto, g.peso_volumen, g.id_mpio_origen, g.id_mpio_destino
                          from guia g where g.valor_servicio=0 or g.valor_servicio is null;
begin
open calcular_fletes;
    loop
        fetch calcular_fletes into idguia, pesoreal, ancho, largo, alto, pesovolumen, idmpioorigen, idmpiodestino;
            exit when calcular_fletes%notfound;
            for idmpioorigennew in (select ce.id from centro_recibos ce where id_mpio=idmpioorigen) loop
                idmpioorigennew2 := idmpioorigennew.id;
                for nombrempio in (select m.nombre_mpio, m.id_depto from municipios m where id=idmpiodestino) loop
                    nombrempionew := nombrempio.nombre_mpio;
                    deptodestino := nombrempio.id_depto;
                        for deptodestinofor in (select d.nombre_depto from departamentos d where id=deptodestino) loop
                            deptodestinonew := deptodestinofor.nombre_depto;
                        end loop;
                end loop;
            end loop;
/*dbms_output.put_line(' Primer id ' || idmpioorigen || ' Cambio centror a ' || idmpioorigennew2 || ' Id mpio uno ' || idmpiodestino
|| ' Cambia a nombre a ' || nombrempionew || ' departamaneto id ' || deptodestino || ' cambia a nombre a ' || deptodestinonew);*/
valorservicio := calculo_valor_precio (pesoreal,pesovolumen,idmpioorigennew2,nombrempionew,deptodestinonew);
/*dbms_output.put_line('valor servicio' || valorservicio);
dbms_output.put_line(' peso ' || pesoreal || ' peso volumen ' || pesovolumen || ' centro r orig ' || idmpioorigennew2
|| ' mpio destino ' || nombrempionew || ' departamaneto destino ' || deptodestinonew);*/
update guia set valor_servicio=valorservicio where id = idguia;    
end loop;        
close calcular_fletes;    
end;

--Ejecutar procedimiento calcular_fletes
EXEC calcular_fletes;

--Ejecici�n Vista Alternativa
select * from recalcular_tarifas_view 
where Origen LIKE '&nombre_origen' and nombre_destino = '&nombre_destino' or Nombre_Departamento = '&nombre_depto_destino'

--Ejecici�n Vista Alternativa
select * from recalcular_tarifas_view 
where Origen LIKE '&nombre_origen' and nombre_destino = '&nombre_destino' and Nombre_Departamento = '&nombre_depto_destino'

--SELECT * FROM GUIA

/*10. Usted escribir� una funci�n llamada CALCULAR_CAJAS_NECESARIAS que determine si un n�mero de items pueden ser despachados y el 
n�mero de cajas necesarias para empacar los items. Hay 2 tama�os de cajas: grandes que pueden almacenar hasta 5 art�culos y 
peque�as que pueden almacenar solamente 1 item. Un pedido no se puede despachar cuando se cumpla una de dos condiciones, 
que no alcancen las cajas para almacenar los items o que una caja grande no tenga su aforo completo, es decir, 
si tengo 4 items y solamente 1 caja grande, no podr�a despacharla porque la caja no est� llena en su totalidad. 
Usted deber� crear una funci�n que reciba 3 par�metros en el siguiente orden: n�mero de items, cantidad de cajas grandes 
disponibles y cantidad de cajas peque�as disponibles. La funci�n retornar� un n�mero, si el pedido no se puede despachar, 
deber� retornar -1, de lo contrario, deber� retornar el n�mero de cajas grandes y peque�as utilizadas para el despacho. 
Ejemplos: Items: 16 Cajas Grandes: 5 Cajas Peque�as: 10 En este caso deber� retornar 4, ya que son 3 cajas grandes (5*3 = 15) 
y 1 peque�a. Items: 14 Cajas grandes: 10 Cajas peque�as: 1 En este caso deber� retornar -1, 
ya que no hay el n�mero de cajas peque�as suficientes para empacar los 4 art�culos restantes. 
Nota: Siempre las cajas grandes tienen prioridad sobre las peque�as. Es decir si tengo 6 items y 1 caja grande y 10 peque�as, 
debo utilizar 2 cajas.*/

create or replace function calcular_cajas_necesarias (items in number, cajas_grandes in number, cajas_pequenas in number)
return number is
result number :=0;
numero number := 0;
numero2 number := 0;
contador_cg number := 0;
contador_cp number := 0;
numarticulos number :=0;
salida number;
salida2 number;
limite_grandes number := 5;
limite_pequenas number := 1;
begin
for i in 1..cajas_grandes loop
    numero := limite_grandes*i;
    if numero < items then
        contador_cg := contador_cg + 1;
        numarticulos := numero;
        else
        salida :=1;
        numero := 0;
    end if;
    exit when salida = 1;
end loop;    
    for j in 1..cajas_pequenas loop
        numero2 := numarticulos;
        if numero2 < items then
            contador_cp := contador_cp + 1;
            numarticulos := numarticulos + 1;
            else
            salida2 :=1;
        end if;
        exit when salida2 = 1;
    end loop;
    if numarticulos < items then
        result := -1;
        dbms_output.put_line('Retorna -1');
        else
        result := contador_cg + contador_cp;
        dbms_output.put_line('retorna ' || result);
    end if; 
return result;
end; 

--Ejecuci�n de la fucnion calculo_valor_precio
select calcular_cajas_necesarias (&items,&cajas_grandes,&cajas_pequenas) from dual;

--11. Crear un backup y adjuntar una imagen donde se evidencie el resultado del backup usando RMAN.

/*12. Leer el siguiente art�culo Netflix: What Happens When You Press Play?, tener presente c�mo funciona Netflix y hacer �nfasis 
especialmente en la parte de bases de datos, qu� bases de datos usan? C�mo las usan? 
Qu� hay de importante con el manejo de bases de datos?*/

--Soluci�n:
/*Las tres partes fundamentales de Netflix son: cliente, backend y CDN. Netflix opera en dos nubes: AWS (Amazon Web Services) y Open Connect que es la arquitectura y red de entrega de contenido global desarrollados por Netflix para la distribuci�n de videos en diferentes lugares del mundo en donde se encuentran los CDN (Red de distribuci�n de contenidos) que est�n alojados en los ISP (Proveedor de servicios de Internet) y que a su vez est�n ubicados equipos de infraestructura llamados OCAs (Open Connect Appliances). 
Netflix tiene tres nodos principales: Norte de Virginia, Portland, Oregon, y Dubl�n, Irlanda lo que le permite tener una redundancia y un tiempo de respuesta alto en caso de presentar fallas en algunos de sus nodos. Una vez se presiona play se ejecuta el backend, este proceso se resume en preparar contenido y solicitudes realizadas por las aplicaciones, web y otros dispositivos que despu�s es operado por Open Connect.
En resumen, Open Connect es colocar sus clusters OCA dentro de la red de los ISP para que la reproducci�n del contenido sea m�s cercana al cliente sin pasar nunca a Internet.
 
A nivel de base de datos, al tener la infraestructura en la nube de AWS Netflix reduce sustancialmente los costos de almacenamiento ofreciendo base de datos relacionales y no relaciones que satisfagan las necesidades puntuales del modelo de negocio, ampliando as� su capacidad almacenamiento desde terabytes hasta petabytes de nuevos tipos de datos y proporcionando el acceso a los datos con una latencia de milisegundos, procesar millones de solicitudes por segundo y con la ventaja de tener una base de datos distribuida y escalable para admitir millones de usuarios en cualquier parte del mundo. 
Netflix utiliza DynamoDB y Cassandra como bases de datos que son de tipo no relaciones y que utilizan un dise�o especifico para su modelo y esquema de negocio lo que lo hace ideal para almacenar gran vol�menes de datos debido a la anal�tica generada, por ejemplo, para almacenar gran cantidad de informaci�n del usuario, como preferencias de pel�culas, estad�sticas de reproducci�n, t�tulos m�s demandados, informaci�n del perfil etc, as� logra obtener resultados y calidad de servicio para los clientes finales mejorando la flexibilidad, escalabilidad, alto rendimiento y funcionalidad.
Como se mencion� anteriormente, las bases de datos de Netflix ofrecen una distribuci�n de almacenamiento, esto significa que no solo se ejecuta en una infraestructura como tal si no que la informaci�n es replicada en varias infraestructuras adicionales por lo que si sucede una falla la informaci�n va a estar segura y disponible cuando se requiera. Para el lado de ser una base de datos escalable, cuando se requiera informaci�n adicional o se incremente la demanda de servicio estas se adaptan a las nuevas infraestructuras requeridas sin ninguna complicaci�n.
 */

/*Hacer un video en el cual se comparta la pantalla y se explique punto por punto lo que hicieron para resolver cada problema, 
ejecutarlos y hacer demostraci�n de cada funci�n, procedimiento y dem�s. 
En el punto del art�culo simplemente deben hablar sobre el mismo teniendo en cuenta las preguntas planteadas. 
Todos los integrantes del equipo deber�n hablar, NO USAR licencias de prueba o versiones "trial" ya que es ilegal, 
tener en cuenta la calidad del sonido y de video al momento de hacer el video, todos estos factores son tenidos en cuenta durante 
la calificaci�n de mismo.*/

--La url del video es:
--http://bit.ly/2QGS72E