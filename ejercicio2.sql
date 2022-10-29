use BDInmobiliaria
go

create procedure sp_insertar_actualizar_familiar
	@cod_fam char(6),
	@cod_usuario char(6),
	@nombre varchar(25),
	@apellido_ma varchar(25),
	@apellido_pa varchar(25),
	@parentesco varchar(50)
as 
BEGIN
	begin try 
    BEGIN TRAN
      if not exists (SELECT * FROM Comercial.FAMILIARES WHERE COD_FAMI = @cod_fam)
		    insert Comercial.FAMILIARES values (@cod_fam, @cod_usuario, @nombre, @apellido_ma, @apellido_pa, @parentesco)
	  else
      begin
        update Comercial.FAMILIARES set
		  COD_USUA = @cod_usuario,
		  NOM_FAMI = @nombre,
		  APEMATER_FAMI = @apellido_ma,
		  APEPATER_FAMI = @apellido_pa,
		  GRADO_PARENTES_FAMI = @parentesco
		where 
          COD_FAMI = @cod_fam
      end
	  commit tran
  end TRY
  BEGIN catch
    ROLLBACK TRAN
    print 'Error al registrar al familiar'
  end CATCH
end 
go

create procedure sp_accion_familiar
	@cod_fam char(6),
	@accion varchar(25),
	@cod_usuario char(6),
	@nombre varchar(25),
	@apellido_ma varchar(25),
	@apellido_pa varchar(25),
	@parentesco varchar(50)
as 
begin
	if @accion = 'eliminar'
		delete from Comercial.FAMILIARES where COD_FAMI = @cod_fam
	else if @accion = 'actualizar'
		exec sp_insertar_actualizar_familiar @cod_fam, @cod_usuario, @nombre, @apellido_ma, @apellido_pa, @parentesco
	else 
		select * from Comercial.FAMILIARES where COD_FAMI = @cod_fam
end 