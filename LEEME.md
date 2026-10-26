# Horas de Estudio — app instalable

Esta carpeta es la app completa. Para instalarla en el móvil hay que subirla a una web con `https`. GitHub Pages es gratis y no caduca.

## 1. Publicarla en GitHub Pages (una vez)

1. Entra en github.com (crea una cuenta si no tienes) y pulsa **New repository**.
2. Ponle de nombre `horas-estudio`, márcalo como **Public** y créalo.
3. En el repositorio, pulsa **uploading an existing file** y arrastra **todo el contenido** de esta carpeta: `index.html`, `manifest.webmanifest`, `sw.js` y la carpeta `icons`. Pulsa **Commit changes**.
4. Ve a **Settings → Pages**. En *Branch* elige `main` y `/ (root)`, y pulsa **Save**.
5. En uno o dos minutos la app estará en `https://TU-USUARIO.github.io/horas-estudio/`.

## 2. Instalarla en Android

1. Abre ese enlace en **Chrome** en el móvil.
2. Toca el menú **⋮ → Añadir a pantalla de inicio → Instalar**.
3. Aparece el icono *Estudio*. Se abre a pantalla completa y funciona sin conexión.

## Datos y sincronización

- Los datos se guardan en el navegador (la app funciona sin conexión) y, con la cuenta configurada, se sincronizan con Supabase: mismos datos en móvil, PC, tablet…
- Entrar: usuario `enrique` (equivale a `enrique@horas-estudio.app`) y la contraseña de ese usuario en Supabase.
- Si dos dispositivos cambian cosas a la vez (p. ej. uno sin red), se fusionan por elemento: no se pierden sesiones; un borrado hecho solo en uno puede reaparecer.
- Los **archivos** de Recursos (PDF, imágenes) no se suben: quedan en el dispositivo donde se añadieron. Enlaces y notas sí se sincronizan.
- **Exportar copia** sigue disponible como respaldo.

### Configurar la nube (una vez)

1. Crea un proyecto gratis en supabase.com.
2. **SQL Editor** → pega `supabase.sql` → **Run**.
3. **Authentication → Users → Add user → Create new user**: email `enrique@horas-estudio.app`, la contraseña, y marca **Auto Confirm User**.
4. **Authentication → Sign In / Providers**: desactiva **Allow new users to sign up**.
5. **Project Settings → API Keys**: copia la *Project URL* y la clave *publishable* (o *anon*) y ponlas en `SB_URL` y `SB_KEY` dentro de `index.html`. Esa clave es pública por diseño; los datos los protegen el usuario y las políticas de `supabase.sql`.

## Actualizar la app

Sube los archivos nuevos al mismo repositorio, sustituyendo los anteriores. La app se actualiza sola la próxima vez que la abras con conexión.
