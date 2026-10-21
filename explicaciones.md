# Explicaciones del Modelo - Paradigma Orientado a Objetos

En este documento se detallan los conceptos del paradigma de objetos aplicados en el desarrollo del juego "Snake" utilizando Wollok, correspondientes a los Checkpoints 1 y 2.

## Checkpoint 1: Objetos, Polimorfismo y Eventos

### 1. Objetos Autodefinidos (WKO) vs Clases
La decision entre usar Objetos Autodefinidos o instanciar Clases se baso en si necesitabamos una única entidad representativa o múltiples entidades con identidades separadas:
*   **Objetos Autodefinidos:** Utilizamos objetos como `serpiente`, `gestorDeNiveles` y `controles`. Dado que en nuestro dominio solo existe un jugador, un único flujo de niveles y un mapeo de teclas, instanciarlos como objetos fijos simplifica el acceso y evita variables globales innecesarias.
*   **Clases:** Creamos clases como `Nivel`, `Comida` y `Obstaculo`. Esto nos permite instanciar múltiples frutas (ej. dos manzanas distintas en un nivel) y diferentes niveles, cada uno manteniendo su propio estado interno.

### 2. Polimorfismo
El polimorfismo nos permitio tratar a distintos objetos de forma intercambiable mediante una misma interfaz, ignorando sus diferencias internas. 
El mejor ejemplo en nuestro codigo es la resolucion de colisiones. El bloque de Wollok Game `game.onCollideDo` simplemente le envía el mensaje `chocarCon(serpiente)` al objeto colisionado. 
*   Si el objeto es de la jerarquía `Comida`, la serpiente crece y suma puntos.
*   Si el objeto es de la jerarquía `Obstaculo` o un `Segmento` del cuerpo, la serpiente muere.
El motor del juego no necesita usar condicionales para saber qué tipo de objeto piso la serpiente; delega la responsabilidad a cada objeto.

### 3. Bloques (Lambdas) y Eventos
Los bloques de codigo aislaron el comportamiento que debía ejecutarse diferido en el tiempo o ante la interaccion del usuario[cite: 8]. 
*   **Eventos de Teclado:** En `controles.wlk`, usamos bloques junto a `onPressDo` para capturar la pulsacion y enviar el mensaje `cambiarDireccion(...)` a la serpiente.
*   **Eventos Temporales:** Usamos `game.onTick(20, ...)` pasandole un bloque que ordena a la serpiente avanzar automaticamente.

---

## Checkpoint 2: Colecciones y Herencia

### 1. Colecciones
Usamos listas para modelar relaciones de uno a muchos y evitar codigo repetitivo[cite: 8]:
*   **Segmentos de la Serpiente:** La serpiente conoce a todos los `Segmento` de su cuerpo guardandolos en la coleccion `cuerpo = []`. Al moverse, recorremos la lista actualizando la posicion de cada segmento a la posicion del segmento anterior.
*   **Elementos del Nivel:** La clase `Nivel` posee una coleccion `elementos = []`. Usando el método de orden superior `forEach`, el nivel recorre polimorficamente todos sus interactuables para agregarlos (`game.addVisual`) o quitarlos del tablero.

### 2. Herencia y Redefinicion (Uso de `super`)
Para evitar la repeticion de logica común de reposicionamiento, dibujo y colision, organizamos los interactuables en jerarquías. Creamos clases "base" (`Comida`, `Obstaculo`) de las cuales heredan objetos mas específicos.

Implementamos una logica interesante usando **redefinicion con `super`** para extender (no solo reemplazar) el comportamiento heredado:
*   **En la Comida:** La clase base `Comida` define que `puntaje() = 10`. La subclase `Banana` hace un *override* de este método devolviendo `super() + 10`. Así reaprovecha el valor base y le suma su propio bono.
*   **En los Obstaculos:** La clase base `Obstaculo` define que al recibir `chocarCon(serpiente)` envía a la serpiente el mensaje `morir()`. La subclase `Lava` hace un *override* de este método llamando a `super(serpiente)` (para matarla de todos modos) y luego agrega su castigo específico: `serpiente.puntaje(0)`.

### Diagrama de Clases (UML)
A continuacion se ilustra la jerarquía y polimorfismo de los elementos del juego.

```mermaid
classDiagram
    direction TB

    class colision {
        <<object>>
        colisionar(objeto)
    }
    class marcador {
        <<object>>
        text()
        chocarCon(serpiente)
    }
    class gestorDeNiveles {
        <<object>>
        indiceNivelActual
        niveles
        nivelActual()
        verificarProgreso(puntajeActual)
        resetear()
    }
    class serpiente {
        <<object>>
        direccion
        puntaje
        velocidad
        cuerpo
        avanzar()
        cambiarDireccion(nuevaDireccion)
        comer(comida)
        ocupa(unaPosicion)
        morir()
    }
    class Nivel {
        elementos
        puntajeObjetivo
        iniciar()
        terminar()
        ocupa(posicion, elementoIgnorado)
    }
    class Segmento {
        position
        chocarCon(serpiente)
    }

    class arriba {
        <<object>>
        siguientePosicion(pos)
        opuesta()
    }
    class abajo {
        <<object>>
        siguientePosicion(pos)
        opuesta()
    }
    class izquierda {
        <<object>>
        siguientePosicion(pos)
        opuesta()
    }
    class derecha {
        <<object>>
        siguientePosicion(pos)
        opuesta()
    }

    class Comida {
        position
        chocarCon(serpiente)
        reposicionar(serpiente)
        puntaje()
        image()
        aumentarRapidez(serpiente)
    }
    class Manzana {
        puntaje()
        image()
    }
    class Banana {
        puntaje()
        image()
        aumentarRapidez(serpiente)
    }
    class Cereza {
        puntaje()
        image()
        aumentarRapidez(serpiente)
    }
    class FrutaDorada {
        puntaje()
        image()
        aumentarRapidez(serpiente)
    }

    class Obstaculo {
        <<abstract>>
        position
        chocarCon(serpiente)
        reposicionar(serpiente)
        image()*
    }
    class Piedra {
        image()
    }
    class Cactus {
        image()
    }
    class Lava {
        image()
        chocarCon(serpiente)
    }

    Comida <|-- Manzana
    Comida <|-- Banana
    Comida <|-- Cereza
    Comida <|-- FrutaDorada
    Obstaculo <|-- Piedra
    Obstaculo <|-- Cactus
    Obstaculo <|-- Lava

    gestorDeNiveles --> Nivel
    Nivel --> Comida
    Nivel --> Obstaculo
    serpiente --> Segmento
    serpiente --> arriba
    serpiente --> abajo
    serpiente --> izquierda
    serpiente --> derecha

    colision ..> serpiente
    marcador ..> serpiente
    serpiente ..> gestorDeNiveles
```

**Polimorfismo:** `Comida`, `Obstaculo`, `Segmento` y `marcador` entienden `chocarCon(serpiente)`. colision no pregunta de qué tipo es el objeto, solo le manda el mensaje.
**Herencia y redefinicion:** Comida define el comportamiento base y cada fruta redefine `puntaje()`, `image()` y `aumentarRapidez()`. En Obstaculo, `image()` es abstracto, y Lava redefine `chocarCon con super()` y además le pone el puntaje en 0.
**Objetos únicos (wko):** `serpiente`, `gestorDeNiveles`, `colision`, `marcador` y las cuatro direcciones son objetos porque no necesitan varias instancias. Nivel es clase porque tenés cinco con distinta configuracion.
**Direcciones como objetos:** cada direccion implementa `siguientePosicion()` y `opuesta()`, así serpiente no usa ningún if para decidir hacia donde se mueve.
**Composicion:** gestorDeNiveles conoce a los Nivel, y cada Nivel conoce a sus Comida y Obstaculo. serpiente conoce a sus Segmento.