# Mejora de Accesibilidad Web según WCAG 2.2

## Descripción del Proyecto
Este proyecto tiene como objetivo mejorar la accesibilidad de una página web siguiendo las normas **WCAG 2.2** (WAI) y utilizando atributos **ARIA** para optimizar la experiencia de navegación para personas con discapacidades.

## Archivos Incluidos
- `original.html` → Código HTML sin optimización de accesibilidad.
- `accesible.html` → Código optimizado con mejoras en semántica y accesibilidad.
- `styles.css` → Estilos para la pagina con contrastes adecuados.
- `capturas/` → Carpeta con capturas de pantalla antes y después de la validación.
- `img/` → Carpeta con las imagenes incluidas en la pagina.

## Herramientas de Validación Usadas
1. **WAVE** (https://wave.webaim.org/)

## Problemas Encontrados en `original.html`
1. Uso incorrecto de encabezados (`<h3>` en lugar de `<h1>`).
2. Formulario sin etiquetas `<label>` correctamente asociadas.
3. Botón sin tipo definido.
4. Tabla sin `<thead>` ni `<th>`.
5. Enlaces sin contexto claro.
6. Imágenes sin `alt` adecuado.

## Mejoras Aplicadas en `accesible.html`
✅ Jerarquía de encabezados corregida.
✅ Formularios con etiquetas `<label>` y atributos `aria-required`.
✅ Botón con `type="submit"`.
✅ Tabla mejorada con `<thead>`, `<th>` y `<caption>`.
✅ Enlaces con `aria-label`.
✅ Imágenes con `alt` descriptivo y `role="img"`.

## Resultados de Validación
**Antes de las mejoras (`original.html`)**
- 🔴 Errores en contraste de color.
- 🔴 Falta de etiquetas semánticas adecuadas.
- 🔴 Elementos sin atributos ARIA necesarios.

**Después de las mejoras (`accesible.html`)**
- ✅ Cumplimiento con **criterios A, AA y AAA**.
- ✅ Corrección de errores detectados en WAVE y Axe.
- ✅ Navegación optimizada para teclado y lectores de pantalla.

## Capturas de Pantalla
Las capturas de validación antes y después se encuentran en la carpeta `capturas/`.

