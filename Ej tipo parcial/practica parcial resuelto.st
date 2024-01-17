﻿Object subclass: #Fabrica

	super initialize.

	sectorCalidad := OrderedCollection new.
	sectorReproceso := OrderedCollection new.! !
	|objeto|
	objeto := sectorCalidad  detect: [ :item | item codigo = unCodigo ] ifNone: [ nil ].
	(objeto isNotNil)
		ifTrue: [ 
					sectorCalidad remove: objeto.
					^true.
				]
		ifFalse: [  
					objeto := sectorReproceso   detect: [ :item | item codigo = unCodigo ] ifNone: [ nil ].
					(objeto isNotNil)
						ifTrue: [ 
									sectorReproceso remove: objeto.
									^true.
							     ]
						ifFalse: [ ^false. ].
				].
! !
	|listaTemp totalAcumulado totalElementos|
	
	totalAcumulado := 0.
	listaTemp := sectorReproceso  select: [ :item | item analizado & item nroLote = unLote ].
		ifTrue: [ ^(totalAcumulado / totalElementos) asFloat. ] 
		ifFalse: [ ^0 ].! !
	sectorCalidad  add: unProducto.! !
	|cantidad|

! !
	|productos cadena|
	productos := sectorCalidad  select: [ :item | (item costo between: desde and: hasta)].
	productos do: [:item | cadena := cadena, item asString, String cr. ].
	
		! !
	|piezas|
	piezas := sectorCalidad  select: [ :item | (item isKindOf: LlaveConmutadora ) & ((item nivelCalidad ) = unNivelCalidad)].
	piezas addAll: (sectorReproceso  select: [ :item | (item isKindOf: LlaveConmutadora) & ((item nivelCalidad ) = unNivelCalidad)]).
	^piezas  size.
	

! !
	sectorCalidad  do: [:item |	(item analizado not)ifTrue: 
											 (item nivelCalidad <9) ifTrue:
												 sectorCalidad  remove: item.																													
												].
											 ]. 								
							  ].
! !
	
	^ nroLote! !
	
	^ nivelCalidad! !
	
	analizado := anObject! !
	
	nroLote := anObject! !
	
	codigo := anObject! !
	
	nivelCalidad := anObject! !
	
	costo := anObject! !
	
	^ analizado! !
	
	^ codigo! !
	
	^ costo! !
	^ 'Codigo : ', codigo asString, ' - Nro Lote ', nroLote , ' - Costo: $ ', costo asString.! !

	super initialize.

	analizado := false.
	codigo := 0.
	costo := 0.
	nivelCalidad := 5.
	nroLote := 0.! !
	
	^ modelo! !
	
	modelo := anObject! !
	|cad|
	cad := super asString, ' - Tipo: Llave Conmutadora'.
	(modelo = 1)
		ifTrue: [ cad := cad, ' Indicador analÛgico' ] 
		ifFalse: [ cad := cad, ' Indicador digital' ].
	^cad.

	
! !
	|costoFinal|
	costoFinal:=super costo.
	
	(nivelCalidad < 9) ifTrue:[ costoFinal:= costoFinal + (10-nivelCalidad )*0.05* costoFinal].
	
	^ costoFinal
	! !

	super initialize.

	modelo := 1.! !

	super initialize.

	categoria := 1.! !
	
	categoria := anObject! !
	
	^ categoria! !
	|cad|
	cad := super asString, ' - Tipo: Pieza Intermedia'.
	(categoria  = 1)
		ifTrue: [ cad := cad, ' Equipos 3ta GeneraciÛn' ] 
		ifFalse: [ cad := cad, '  Equipos 5ta GeneraciÛn' ].
	^cad.

	

! !
	|costoFinal|
	costoFinal:=super costo.
	
	(categoria = 1) ifTrue: [ 
			costoFinal:= costoFinal + 0.05* costoFinal
	 	]ifFalse:[
			costoFinal:= costoFinal + 0.13* costoFinal
		].
		
	
	^ costoFinal
	! !