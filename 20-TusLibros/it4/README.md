# TusLibros - Iteración 4

## Aclaraciones

Como bien se aclaro en la consigna, para poder correr el proyecto correctamente se deben importar los siguientes paquetes al entorno:
```
/Packages/Morphic/Morphic-Misc1/Morphic-Misc1.pck.st
/Packages/Morphic/Morphic-Widgets-Extras.pck.st
```
Por otro lado, el código fue programado sobre la imagén con versión 4972 de Cuis University.

## Como usar el sistema

Para facilitar el uso del sistema TusLibros dejamos una forma fácil de levantar el servidor y un cliente dentro del StoreTestObjectsFactory.

Para hacerlo, se puede utilizar el siguiente fragmento de código en un Workspace:
```Smalltalk
testObjects := StoreTestObjects new.
testObjects sampleTestStoreServerAndClient.
```

Si solo se quiere levantar el servidor se puede utilizar:
```Smalltalk
testObjects  sampleTestStoreServer
```
O para solo el cliente: 
```Smalltalk
testObjects launchTestClient 
```
Cada vez que se manda el mensaje sampleTestStoreServer se elimina el server anterior antes de crear otro, pero si se quiere eliminar de forma manual se debe ejecutar:
```Smalltalk
testObjects destroySampleServer.
```

Dejamos dos usuarios de prueba para poder probar todo el sistema

Usuario con tarjeta de credito valida
- usuario: Luis
- password: 1234

Usuario con tarjeta de credito expirada
- usuario: Seba
- password: 2345
