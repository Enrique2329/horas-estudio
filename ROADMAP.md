# Hoja de ruta — app Horas de Estudio

Una fase por día. Cada fase marcada `[x]` ya está publicada. La siguiente a implementar es la primera `[ ]`.

- [x] Fase 0 — Menú desplegable de secciones; el contador pasa a "Registro de horas" (19 oct 2026)
- [ ] Fase 1 — Agenda y recordatorios
- [ ] Fase 2 — Horario semanal
- [ ] Fase 3 — Recursos por asignatura
- [ ] Fase 4 — Flashcards

## Especificación de cada fase

### Fase 1 — Agenda y recordatorios
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
- Recursos: enlace (URL), nota de texto, o archivo (PDF/imagen) guardado en IndexedDB con aviso de espacio ocupado.
- Etiquetas (Apuntes, Boletín, Examen anterior, Vídeo, Otro), búsqueda y filtro.
- Abrir enlaces en pestaña nueva; los archivos se abren desde un blob URL.

### Fase 4 — Flashcards
- Mazos por asignatura; tarjetas con anverso y reverso (texto, admitir saltos de línea).
- Crear, editar y borrar tarjetas en la app; importar tarjetas desde JSON (formato `{"cards":[{"subject":"<id o nombre>","front":"…","back":"…"}]}`) para que Claude las genere desde los apuntes.
- Modo juego: mezcla tarjetas de todas las asignaturas (o las elegidas), repetición espaciada sencilla (Leitner, 5 cajas), botones "La sabía" / "No la sabía", racha, puntos y sesión corta de 10 tarjetas para ratos muertos.
- Estadísticas: tarjetas dominadas por asignatura.

## Convenciones técnicas
- Todo en `index.html` (HTML, CSS y JS en un único archivo). Sin frameworks ni librerías nuevas.
- Datos en `localStorage`. El registro de horas usa la clave `horas-estudio-v1` (`{config, sessions}`) y NO debe cambiar de forma. Cada sección nueva usa su propia clave (`he-agenda-v1`, `he-horario-v1`, `he-recursos-v1`, `he-flashcards-v1`). Los archivos de recursos van en IndexedDB.
- "Exportar copia" e "Importar copia" deben incluir los datos de todas las secciones (la importación de copias antiguas, que solo tienen el registro, tiene que seguir funcionando).
- Reutilizar los tokens de color y tipografía existentes (`:root`), los componentes `.panel`, `.btn`, `.chip`, y respetar modo claro y oscuro.
- Interfaz en español. Diseño pensado primero para móvil (400 px).
- En cada publicación, subir la versión de caché de `sw.js` (`horas-estudio-vN`).
