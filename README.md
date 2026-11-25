# 🐍 Wollok Game: Snake

**Grupo:** Bits

**Integrantes:**
- Christian Huarachi
- Jhon Jairo Pastor Tumiri Cuellar
- Leonel Chejo
- Alex Nicolas Larramendi
- Nicolas Basile
- Jazmin Callizaya
  
## Consignas

Todo lo que necesitan saber está explicado en [este documento](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.wnm2lu4cls8j). Para todo lo demás, aseguren prestar atención a los comunicados por Discord.

Revisen los archivos de base y cambien lo que quieran para ajustarlo a sus necesidades. Lo primero que deberían hacer es actualizar 

Recuerden que para cada checkpoint hay [expectativas mínimas](https://docs.google.com/document/d/1KoB12RIZk_xPhmnOJ-EfLIPNwkETD_EaYMp2srDu9QY/edit?tab=t.0#heading=h.56t0qdv908v3) respecto a los conceptos aplicados. Procuren:
- Validar su idea con el equipo docente que corresponda por su canal de Discord
- Para cada checkpoint, asegurar que implementaron lo necesario para esa instancia, y crear un **tag** en el repositorio para facilitar la comparación entre versiones final e intermedias.
- Para la demo final, crear un nuevo tag **demo** y actualizar este README con todo lo necesario.

# 🎮 ¿Cómo jugar?
Nuestro juego es una versión del clásico **Snake**. Controlás una serpiente que se mueve por un tablero de 16x16. El objetivo es comer la mayor cantidad de frutas posibles para sumar puntos, avanzar de nivel y evitar chocar contra los bordes, tu propio cuerpo o los obstáculos del escenario.

El juego cuenta con **5 niveles** con dificultad progresiva. A medida que sumás puntos, avanzás al siguiente nivel, donde aparecen más obstáculos y frutas especiales.

## Objetivo

El juego consiste en conseguir la mayor cantidad de puntos posibles comiendo frutas, evitando chocar contra los bordes del tablero, contra el propio cuerpo de la serpiente y los obstaculos del escenario 

## 🕹️ Controles
| Tecla | Acción |
| :---: | :--- |
| **W** o **↑** | Mover hacia arriba |
| **S** o **↓** | Mover hacia abajo |
| **A** o **←** | Mover hacia la izquierda |
| **D** o **→** | Mover hacia la derecha |
| **R** | Reiniciar la partida (vuelve al Nivel 1) |
| **F** | Detener el juego |

*(Nota: La serpiente no puede girar 180° sobre sí misma en el mismo movimiento).*

## 🍎 Frutas y Puntajes
Cada fruta otorga una cantidad distinta de puntos y modifica la velocidad de la serpiente:
*   **Manzana:** +10 puntos. (Velocidad normal)
*   **Banana:** +20 puntos. (Aumenta un poco la velocidad)
*   **Cereza:** +30 puntos. (Aumenta más la velocidad)
*   **Fruta Dorada:** +50 puntos. (Aumenta mucho la velocidad)

Comer cualquier fruta hace que la serpiente **crezca un segmento**.

## 🪨 Obstáculos y Peligros
*   **Piedra:** Si chocás, **perdés la partida** (Game Over).
*   **Cactus:** Si chocás, **perdés 5 puntos** y tu velocidad **se reduce a la mitad** (vas más lento). El cactus luego cambia de posición.
*   **Lava:** Si chocás, **perdés 10 puntos** y la serpiente **pierde un segmento de su cuerpo** (se acorta). La lava luego cambia de posición.
*   **Tu propio cuerpo / Bordes:** Si chocás contra un borde del tablero o contra tu propio cuerpo, **perdés la partida**.

## 🏆 Sistema de Niveles
*   **Nivel 1:** 100 puntos para pasar.
*   **Nivel 2:** 200 puntos para pasar.
*   **Nivel 3:** 300 puntos para pasar.
*   **Nivel 4:** 400 puntos para pasar.
*   **Nivel 5:** 500 puntos para ganar el juego (Fin del juego).

Al morir, aparece una pantalla de Game Over y la serpiente se detiene. Podés presionar **R** para reiniciar todo desde el Nivel 1.

# Explicaciones

Las explicaciones teóricas y diagramas van a encontrarse en [explicaciones.md](explicaciones.md) a partir del Checkpoint #2.
