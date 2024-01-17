Object subclass: #Fabrica	instanceVariableNames: 'sectorCalidad sectorReproceso'	classVariableNames: ''	poolDictionaries: ''	category: 'PPRPrimerParcial_Resuelto_0409'!!Fabrica methodsFor: 'initialize' stamp: 'PPR2014 9/11/2014 11:39'!initialize

	super initialize.

	sectorCalidad := OrderedCollection new.
	sectorReproceso := OrderedCollection new.! !!Fabrica methodsFor: 'business' stamp: 'PPR2014 9/11/2014 12:09'!-= unCodigo
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
! !!Fabrica methodsFor: 'business' stamp: 'ps 9/6/2019 14:22'!costoPromedioLote: unLote
	|listaTemp totalAcumulado totalElementos|
	
	totalAcumulado := 0.
	listaTemp := sectorReproceso  select: [ :item | item analizado & item nroLote = unLote ].	totalElementos := listaTemp size.	listaTemp do: [:item | (item analizado & item nroLote =unLote ) ifTrue: [totalAcumulado := totalAcumulado + item costo ] ].   (totalElementos > 0)
		ifTrue: [ ^(totalAcumulado / totalElementos) asFloat. ] 
		ifFalse: [ ^0 ].! !!Fabrica methodsFor: 'business' stamp: 'PPR2014 9/11/2014 12:10'!addProducto: unProducto
	sectorCalidad  add: unProducto.! !!Fabrica methodsFor: 'business' stamp: 'martin 9/4/2015 10:07'!cantidadPiezasPorNivelBis: unNivelCalidad
	|cantidad|	cantidad := 0.	sectorCalidad do: [ :item | ((item isKindOf: LlaveConmutadora ) & ((item nivelCalidad ) = unNivelCalidad)) ifTrue:  [cantidad := cantidad + 1] ].	sectorReproceso do: [ :item | ((item isKindOf: LlaveConmutadora) & ((item nivelCalidad ) = unNivelCalidad)) ifTrue: [cantidad := cantidad + 1] ].	^ cantidad

! !!Fabrica methodsFor: 'business' stamp: 'ps 9/6/2019 14:53'!listarProductosCostoComprendido: desde hasta: hasta
	|productos cadena|	cadena := ''.
	productos := sectorCalidad  select: [ :item | (item costo between: desde and: hasta)].
	productos do: [:item | cadena := cadena, item asString, String cr. ].	^cadena
	
		! !!Fabrica methodsFor: 'business' stamp: 'ps 9/6/2019 14:12'!cantidadPiezasPorNivel: unNivelCalidad
	|piezas|
	piezas := sectorCalidad  select: [ :item | (item isKindOf: LlaveConmutadora ) & ((item nivelCalidad ) = unNivelCalidad)].
	piezas addAll: (sectorReproceso  select: [ :item | (item isKindOf: LlaveConmutadora) & ((item nivelCalidad ) = unNivelCalidad)]).
	^piezas  size.
	

! !!Fabrica methodsFor: 'business' stamp: 'ps 9/6/2019 14:11'!testearProductos
	sectorCalidad  do: [:item |	(item analizado not)ifTrue: 											[item analizado: true.
											 (item nivelCalidad <9) ifTrue:												[sectorReproceso  add: item.
												 sectorCalidad  remove: item.																													
												].
											 ]. 								
							  ].
! !Object subclass: #Producto	instanceVariableNames: 'analizado codigo costo nivelCalidad nroLote'	classVariableNames: ''	poolDictionaries: ''	category: 'PPRPrimerParcial_Resuelto_0409'!!Producto methodsFor: 'as yet unclassified' stamp: '1 9/27/2012 11:40'!descripcion	^descripcion! !!Producto methodsFor: 'as yet unclassified' stamp: 'Anonymous 9/1/2017 16:15'!cantidadFragiles	|cont|	cont := 0.	insumos do:[:unInsumo| (unInsumo fragil) ifTrue:[cont := cont + 1]]! !!Producto methodsFor: 'as yet unclassified' stamp: '1 9/27/2012 23:24'!cantidadSolidos	|cont|	cont:= 0.	insumos do:[:unInsumo| 		((unInsumo class asString) = 'Solido')			ifTrue: [cont:= cont +1]].	^cont! !!Producto methodsFor: 'as yet unclassified' stamp: '1 9/27/2012 11:40'!descripcion: unaDescripcion	descripcion:=unaDescripcion! !!Producto methodsFor: 'as yet unclassified' stamp: '1 9/27/2012 22:48'!valorTotal	|acu|	acu:= 0.	insumos do:[:unInsumo| acu:= acu + unInsumo valor].	^acu! !!Producto methodsFor: 'as yet unclassified' stamp: 'Anonymous 9/1/2017 16:22'!sumaValoresLiquidosFragiles|sumatoria|sumatoria := 0.insumos do:[:unInsumo|	(unInsumo fragil and: ((unInsumo class) asString  = 'Liquido'))		ifTrue: [sumatoria := sumatoria + unInsumo valor]].! !!Producto methodsFor: 'as yet unclassified' stamp: '1 9/27/2012 18:45'!addInsumo: unInsumo	insumos add: unInsumo! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!nroLote
	
	^ nroLote! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!nivelCalidad
	
	^ nivelCalidad! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!analizado: anObject
	
	analizado := anObject! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!nroLote: anObject
	
	nroLote := anObject! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!codigo: anObject
	
	codigo := anObject! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!nivelCalidad: anObject
	
	nivelCalidad := anObject! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!costo: anObject
	
	costo := anObject! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!analizado
	
	^ analizado! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!codigo
	
	^ codigo! !!Producto methodsFor: 'accesing' stamp: 'PPR2014 9/11/2014 11:42'!costo
	
	^ costo! !!Producto methodsFor: 'business' stamp: 'PPR2014 9/11/2014 11:46'!asString
	^ 'Codigo : ', codigo asString, ' - Nro Lote ', nroLote , ' - Costo: $ ', costo asString.! !!Producto methodsFor: 'initialize' stamp: 'PPR2014 9/11/2014 12:06'!initialize

	super initialize.

	analizado := false.
	codigo := 0.
	costo := 0.
	nivelCalidad := 5.
	nroLote := 0.! !Producto subclass: #LlaveConmutadora	instanceVariableNames: 'modelo'	classVariableNames: ''	poolDictionaries: ''	category: 'PPRPrimerParcial_Resuelto_0409'!!LlaveConmutadora methodsFor: 'accessing' stamp: 'PPR2014 9/11/2014 11:47'!modelo
	
	^ modelo! !!LlaveConmutadora methodsFor: 'accessing' stamp: 'PPR2014 9/11/2014 11:47'!modelo: anObject
	
	modelo := anObject! !!LlaveConmutadora methodsFor: 'business' stamp: 'PPR2014 9/11/2014 11:55'!asString
	|cad|
	cad := super asString, ' - Tipo: Llave Conmutadora'.
	(modelo = 1)
		ifTrue: [ cad := cad, ' Indicador analÛgico' ] 
		ifFalse: [ cad := cad, ' Indicador digital' ].
	^cad.

	
! !!LlaveConmutadora methodsFor: 'business' stamp: 'PPR2014 9/11/2014 12:02'!costo
	|costoFinal|
	costoFinal:=super costo.
	
	(nivelCalidad < 9) ifTrue:[ costoFinal:= costoFinal + (10-nivelCalidad )*0.05* costoFinal].
	
	^ costoFinal
	! !!LlaveConmutadora methodsFor: 'initialize' stamp: 'PPR2014 9/11/2014 12:06'!initialize

	super initialize.

	modelo := 1.! !Producto subclass: #PiezaIntermedia	instanceVariableNames: 'categoria'	classVariableNames: ''	poolDictionaries: ''	category: 'PPRPrimerParcial_Resuelto_0409'!!PiezaIntermedia methodsFor: 'initialize' stamp: 'PPR2014 9/11/2014 12:07'!initialize

	super initialize.

	categoria := 1.! !!PiezaIntermedia methodsFor: 'accessing' stamp: 'PPR2014 9/11/2014 11:51'!categoria: anObject
	
	categoria := anObject! !!PiezaIntermedia methodsFor: 'accessing' stamp: 'PPR2014 9/11/2014 11:51'!categoria
	
	^ categoria! !!PiezaIntermedia methodsFor: 'business' stamp: 'PPR2014 9/11/2014 11:57'!asString
	|cad|
	cad := super asString, ' - Tipo: Pieza Intermedia'.
	(categoria  = 1)
		ifTrue: [ cad := cad, ' Equipos 3ta GeneraciÛn' ] 
		ifFalse: [ cad := cad, '  Equipos 5ta GeneraciÛn' ].
	^cad.

	

! !!PiezaIntermedia methodsFor: 'business' stamp: 'PPR2014 9/11/2014 12:05'!costo
	|costoFinal|
	costoFinal:=super costo.
	
	(categoria = 1) ifTrue: [ 
			costoFinal:= costoFinal + 0.05* costoFinal
	 	]ifFalse:[
			costoFinal:= costoFinal + 0.13* costoFinal
		].
		
	
	^ costoFinal
	! !