use BDInmobiliaria
go 

create function fn_familiares(
  @cod_usuario char(6)
)
returns table
AS
  return (
    select * from Comercial.FAMILIARES f where f.COD_USUA = @cod_usuario
  )
