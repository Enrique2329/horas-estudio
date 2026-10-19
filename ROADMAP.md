# Hoja de ruta — app Horas de Estudio

Una fase por día. Cada fase marcada `[x]` ya está publicada. La siguiente a implementar es la primera `[ ]`.

- [x] Fase 0 — Menú desplegable de secciones; el contador pasa a "Registro de horas" (19 oct 2026)
- [ ] Fase 1 — Agenda y recordatorios
- [ ] Fase 2 — Horario semanal
- [ ] Fase 3 — Recursos por asignatura
- [ ] Fase 4 — Flashcards

## Especificación de cada fase

### Fase 1 — Agenda y recordatorios
- **Incluye también esta mejora del Registro de horas (pedida el 19 oct): descansos y horas efectivas.**
  - Las pausas ya se guardan por sesión en el campo `paused` (ms). Añadir el número de pausas: `active.pauseCount` (se incrementa en cada Pausar) y `pauses` (número) en la sesión guardada. Las sesiones antiguas sin `pauses` cuentan como 0 pausas conocidas.
  - En el Resumen, para Hoy y Esta semana: tiempo total de sesión (de inicio a fin), descansos, horas efectivas (sin pausas) y porcentaje de efectividad (efectivas / total). Las horas efectivas son las que ya cuentan para objetivos y estadísticas, así que no cambies esos cálculos.
  - En la cabecera de cada día del registro: "efectivo Xh · descansos Ym".
  - En cada sesión del registro: número de pausas y su duración total.
  - En el gráfico de 7 días: opción de mostrar los descansos apilados en un tono neutro encima de la barra de estudio.
  - Durante una pausa, mostrar en el bloque del cronómetro el descanso acumulado de la sesión.
- **Incluye también (pedido el 19 oct): porcentaje de aprovechamiento por sesión, por asignatura y por cuatrimestre.**
  - Definición: tiempo real de sesión = fin − inicio (incluye descansos); tiempo efectivo = tiempo real − descansos (`paused`). Aprovechamiento = efectivo / real × 100, redondeado a entero.
  - Los agregados se calculan sumando tiempos (Σ efectivo / Σ real), nunca promediando porcentajes, para que una sesión de 15 min no pese lo mismo que una de 3 h.
  - Por sesión: mostrar el % en cada entrada del registro (junto a pausas y su duración) y en el bloque del cronómetro al cerrar la sesión (antes de guardar el resumen), y en directo durante la sesión.
  - Por asignatura en el cuatrimestre: en la vista "Cuatrimestre" de la gráfica, una tabla con una fila por asignatura: tiempo real, descansos, efectivo, aprovechamiento % (con barra) y nº de sesiones. Debajo, una fila "Global" con el aprovechamiento real de todas las sesiones del cuatrimestre. Usa el mismo cuatrimestre seleccionado en la vista (fechas de `config.terms`).
  - Sesiones añadidas a mano: no tienen datos reales de descansos, así que no cuentan para el aprovechamiento (sí para las horas). A partir de ahora, guardarlas con `manual:true` y añadir al formulario manual un campo opcional "Descansos (min)": si se rellena, la sesión guarda `paused` y sí cuenta. Las sesiones antiguas sin campo `paused` se tratan como manuales. Indicar en la tabla cuántas sesiones quedan fuera del cálculo, si hay alguna.
  - Colores del %: neutro por defecto; sin juicios de valor en el texto.
- **Incluye también (pedido el 19 oct): gráficas mensual y cuatrimestral en el Registro de horas.**
  - Selector de vista en el panel de la gráfica: "7 días" (la actual) · "Mes" · "Cuatrimestre".
  - Mes: una barra por día del mes, apilada por asignatura (horas efectivas), con flechas para mes anterior y siguiente. Debajo, el total del mes, la media por día estudiado y el reparto por asignatura.
  - Cuatrimestre: una barra por semana (lunes a domingo) apilada por asignatura, con el total del cuatrimestre y la media semanal comparada con el objetivo semanal (línea de referencia). Fechas editables en la app, por defecto 1.er cuatrimestre del 15 sep al 14 feb y 2.º del 15 feb al 15 jul (fechas de la UCO indicadas por Enrique); fuera de esos periodos (del 16 jul al 14 sep), mostrar el último cuatrimestre terminado; por defecto, el que contiene la fecha de hoy. Se guardan en `config` (por ejemplo `config.terms`, campo nuevo y opcional, sin cambiar los existentes).
  - Las tres vistas usan la misma escala vertical rotulada en horas, con etiquetas que no se solapan a 400 px (en Mes, etiquetar solo cada 5 días y el día de hoy).
- Vista de calendario mensual (lunes primero) y vista del día seleccionado; por defecto, hoy.
- Eventos con: título, fecha, hora de inicio y fin (opcional, "todo el día"), tipo (Clase, Examen, Entrega, Tarea, Otro), asignatura opcional (de las asignaturas del registro de horas), notas y recordatorio opcional (al momento, 10 min, 1 h, 1 día antes).
- Repetición semanal opcional (para clases), con fecha de fin opcional.
- Tareas marcables como hechas.
- Recordatorios: pedir permiso de notificaciones con un botón (nunca al cargar). Mientras la app está abierta, comprobar cada 30 s y lanzar la notificación (vía service worker `showNotification` si existe) y además un aviso dentro de la app. Al abrir la app, mostrar los recordatorios vencidos que no se vieron. Explicar en la propia página, en una línea, que con la app cerrada los avisos no están garantizados.
- Próximos exámenes y entregas destacados arriba con cuenta atrás en días.

### Fase 2 — Horario semanal
- Rejilla lunes–domingo, 07:00–22:00, filas de 30 min; en móvil, un día por pantalla con flechas y deslizar.
- Muestra los eventos de la agenda de esa semana (incluidas repeticiones) y bloques de estudio planificados que el usuario añade (asignatura + franja).
- Navegación entre semanas; botón "Hoy". Marca la hora actual.
- Huecos libres resaltados de forma sutil; total de horas de estudio planificadas en la semana por asignatura frente a las estudiadas de verdad (del registro).
- Un bloque de estudio planificado tiene un botón "Empezar" que arranca el cronómetro del registro con esa asignatura.

### Fase 3 — Recursos por asignatura
- Una ficha por asignatura (las del registro de horas).
- Además de los recursos guardados en el móvil, la ficha lista los archivos del repositorio en `recursos/<Nombre de asignatura>/` (leídos de `recursos/indice.json`, que mantiene la tarea diaria) con enlace para abrirlos. Explicar en la página, en una línea, que para que se generen flashcards el recurso tiene que subirse a esa carpeta de GitHub, y enlazar a https://github.com/Enrique2329/horas-estudio/tree/main/recursos.
- Recursos: enlace (URL), nota de texto, o archivo (PDF/imagen) guardado en IndexedDB con aviso de espacio ocupado.
- Etiquetas (Apuntes, Boletín, Examen anterior, Vídeo, Otro), búsqueda y filtro.
- Abrir enlaces en pestaña nueva; los archivos se abren desde un blob URL.

### Fase 4 — Flashcards
- Mazos por asignatura; tarjetas con anverso y reverso (texto, admitir saltos de línea).
- Las tarjetas generadas por Claude están en `flashcards.json` del repositorio (formato abajo). La app lo descarga al abrirse (con red; si no, usa la última copia) y lo fusiona por `id` con las tarjetas propias. El progreso (caja Leitner, aciertos) se guarda en localStorage por `id`, nunca dentro de flashcards.json.
- La asignatura se asocia por nombre (sin distinguir mayúsculas ni tildes) con las del registro de horas; si no existe, se muestra con su nombre igualmente.
- Crear, editar y borrar tarjetas propias en la app (las de Claude solo se pueden ocultar).
- Modo juego: mezcla tarjetas de todas las asignaturas (o las elegidas), repetición espaciada sencilla (Leitner, 5 cajas), botones "La sabía" / "No la sabía", racha, puntos y sesión corta de 10 tarjetas para ratos muertos.
- Estadísticas: tarjetas dominadas por asignatura.

## Convenciones técnicas
- Todo en `index.html` (HTML, CSS y JS en un único archivo). Sin frameworks ni librerías nuevas.
- Datos en `localStorage`. El registro de horas usa la clave `horas-estudio-v1` (`{config, sessions}`) y NO debe cambiar de forma. Cada sección nueva usa su propia clave (`he-agenda-v1`, `he-horario-v1`, `he-recursos-v1`, `he-flashcards-v1`). Los archivos de recursos van en IndexedDB.
- "Exportar copia" e "Importar copia" deben incluir los datos de todas las secciones (la importación de copias antiguas, que solo tienen el registro, tiene que seguir funcionando).
- Reutilizar los tokens de color y tipografía existentes (`:root`), los componentes `.panel`, `.btn`, `.chip`, y respetar modo claro y oscuro.
- Interfaz en español. Diseño pensado primero para móvil (400 px).
- En cada publicación, subir la versión de caché de `sw.js` (`horas-estudio-vN`).

## Generación automática de flashcards (cada ejecución diaria, independiente de las fases)
- Enrique sube sus recursos (PDF, imágenes, .md, .txt, .docx) a `recursos/<Nombre de asignatura>/` desde GitHub.
- `flashcards.json` tiene la forma `{"version":1,"updated":"<fecha ISO>","sources":{"<ruta del archivo>":"<sha del blob>"},"cards":[{"id":"<estable>","subject":"<Nombre de asignatura>","source":"<ruta>","front":"…","back":"…","tags":["…"]}]}`.
- Cada día: para cada archivo de `recursos/` cuyo sha no coincida con `sources`, leerlo y generar entre 10 y 40 tarjetas según su extensión: preguntas concretas, una idea por tarjeta, respuestas cortas, con fórmulas en texto legible (Unicode o notación lineal). Si un archivo cambió, sustituir sus tarjetas. Si se borró, quitar sus tarjetas. Ids estables: `<slug de la ruta>-<n>`.
- Regenerar `recursos/indice.json` con la lista de archivos por asignatura (`{"<Asignatura>":[{"path":"…","name":"…","size":n}]}`).
- Si no hay cambios en `recursos/`, no tocar estos archivos.
