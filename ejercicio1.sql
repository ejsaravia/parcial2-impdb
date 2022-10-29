use BDInmobiliaria
go

/*select 
	COD_USUA [codigo],
	NOM_AVAL_INQ + ' ' + APELL_AVAL [nombre],
	EST_CIVIL_INQ [estado_civil], 
	HABER_BAS_INQ [haber]
from Comercial.INQUILINO
*/

declare cs_alquiler cursor  for 
select 
	COD_USUA [codigo],
	NOM_AVAL_INQ + ' ' + APELL_AVAL [nombre],
	EST_CIVIL_INQ [estado_civil], 
	HABER_BAS_INQ [haber]
from Comercial.INQUILINO


declare @codigo char(6), @nombre varchar(50), @estado_civil char(1), @haber int

open cs_alquiler
  fetch cs_alquiler into @codigo, @nombre, @estado_civil, @haber
  print replicate('=', 160)
  print space(70)
  print replicate('=', 160)

  PRINT cast('CODIGO' AS CHAR(10)) 
    + CAST('NOMBRE' AS CHAR(50)) 
    + CAST('ESTADO CIVIL' AS CHAR(15)) 
    + CAST('HABER' AS CHAR(12)) 
    + CAST('COSTO' AS CHAR(8))
  WHILE @@FETCH_STATUS = 0
  BEGIN
    declare @costo MONEY = @haber * 0.075

    if (@haber >= 1500 and @haber < 2500)
      set @costo = @haber * 0.1
    else if (@haber > 2500)
      set @costo = @haber * 0.125

    PRINT cast(@codigo AS CHAR(10)) 
      + CAST(@nombre AS CHAR(50)) 
      + CAST(@estado_civil AS CHAR(15)) 
      + '$ ' + CAST(@haber AS CHAR(8)) 
      + '$ ' +CAST(@costo AS CHAR(8))
    fetch cs_alquiler into @codigo, @nombre, @estado_civil, @haber
  END

close cs_alquiler
deallocate cs_alquiler
