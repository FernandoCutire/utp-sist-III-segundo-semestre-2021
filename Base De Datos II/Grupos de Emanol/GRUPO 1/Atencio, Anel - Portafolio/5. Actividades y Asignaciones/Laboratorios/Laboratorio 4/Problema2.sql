/*
create table Estudiantes (
    num_est number(5) not null,
    ced_est varchar2(12) not null,
    nombre_est varchar(50) not null,
    calif_final number(3) not null,
    constraint pk_estudiantes_num_est primary key (num_est)
);

DECLARE -- Declaración de las variables para la tabla
    v_num_est  number := 000001;
    v_ced_est varchar2(12) := '8-950-100';
    v_nombre_est varchar(50) := 'Marcos Gonzalez';
    v_calif_final number := 71;
    v_salida_nombre_est varchar(50);
    v_salida_calif_final number(3);
    
BEGIN --Ahora se insertan las variables a la tabla
    insert into Estudiantes (num_est, ced_est, nombre_est, calif_final) 
    values (v_num_est, v_ced_est, v_nombre_est, v_calif_final);
    -- Ahora hago la consulta a la tabla
    select nombre_est, calif_final into v_salida_nombre_est, v_salida_calif_final
    from Estudiantes;
    dbms_output.put_line(v_salida_nombre_est);
    dbms_output.put_line(v_salida_calif_final);
END;
/

drop table Estudiantes

select nombre_est, calif_final from estudiantes;

*/

-------------------------------------------------------------------------------------------------------------------------

create table Estudiantes (
    num_est number(5) not null,
    ced_est varchar2(12) not null,
    nombre_est varchar(50) not null,
    calif_final number(3) not null,
    constraint pk_estudiantes_num_est primary key (num_est)
);

insert into Estudiantes values (1, '8-950-100', 'Marcos Gonzalez', 61);
insert into Estudiantes values (2, '8-950-200', 'Eduardo Perez', 71);
insert into Estudiantes values (3, '8-950-300', 'Alice Lara', 81);
insert into Estudiantes values (4, '8-950-400', 'Hayleen Torres', 91);
insert into Estudiantes values (5, '8-950-500', 'Tatiana Rodriguez', 100);

-------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
DECLARE -- Declaración de las variables para la tabla
    v_salida_nombre_est Estudiantes.nombre_est%TYPE;
    v_salida_calif_final Estudiantes.calif_final%TYPE;
    
BEGIN --Ahora se insertan las variables a la tabla
    FOR v_counter in 1..5 LOOP
        select nombre_est, calif_final into v_salida_nombre_est, v_salida_calif_final
        from Estudiantes
        where num_est = v_counter;
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_salida_nombre_est || '     Calificación: ' || v_salida_calif_final);
    END LOOP;
END;
/