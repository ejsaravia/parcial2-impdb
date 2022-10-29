use BDInmobiliaria
go

create procedure sp_accion_familiar
	@codigo char(6),
	@nombre varchar(30),
	@apellido varchar(30),
	@haber money,
	@est_civil char(1),
	@lugar_trabajo varchar(50)
as 
begin
	begin try
		begin tran
			insert Comercial.INQUILINO values (@codigo, @nombre, @apellido, @haber, @est_civil, @lugar_trabajo)

		commit tran
	end try
	begin catch
		if ERROR_NUMBER() = 2627
		begin
			rollback tran
			print 'Cliente duplicado'
		end
			
	end catch
end