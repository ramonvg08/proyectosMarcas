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
 Jerarquía de encabezados corregida.
 Formularios con etiquetas `<label>` y atributos `aria-required`.
 Botón con `type="submit"`.
 Tabla mejorada con `<thead>`, `<th>` y `<caption>`.
 Enlaces con `aria-label`.
 Imágenes con `alt` descriptivo y `role="img"`.

## Resultados de Validación
**Antes de las mejoras (`original.html`)**
-  Errores en contraste de color.
-  Falta de etiquetas semánticas adecuadas.
-  Elementos sin atributos ARIA necesarios.

**Después de las mejoras (`accesible.html`)**
-  Cumplimiento con **criterios A, AA y AAA**.
-  Corrección de errores detectados en WAVE y Axe.
-  Navegación optimizada para teclado y lectores de pantalla.


## Prompt
Requisitos de accesibilidad a aplicar:
Uso de etiquetas semánticas HTML5: Reemplaza  genéricos por , , , , , , etc.

Estructura jerárquica de encabezados: 
    Mantén una jerarquía lógica con  como título principal y , , etc., según corresponda.

Atributos ARIA:
    Agrega aria-label, aria-labelledby, aria-describedby, role, y otros atributos ARIA apropiados en botones, enlaces, imágenes y formularios.
    Usa aria-live en mensajes dinámicos para lectores de pantalla.

Formularios accesibles:
    Asegura que cada  tenga un  asociado.
    Usa fieldset y legend para agrupar campos relacionados.
    Implementa aria-invalid, aria-required y aria-describedby para accesibilidad en validaciones.

Imágenes con texto alternativo descriptivo:
    Agrega alt descriptivos y significativos a las imágenes.
    Si una imagen es decorativa, usa alt="" o role="presentation".

Contraste de color y accesibilidad visual:
    Ajusta colores para cumplir con un contraste mínimo de 7:1 en texto normal y 4.5:1 en texto grande.
    Evita el uso exclusivo del color para transmitir información.

Navegación accesible:
    Asegura que la página sea navegable solo con teclado.
    Implementa tabindex adecuadamente para el orden lógico de navegación.
    Agrega accesos rápidos (skip links) para saltar a contenido principal.

Compatibilidad con lectores de pantalla:
    Usa lang="es" en  para definir el idioma de la página.
    Implementa role="alert" en mensajes emergentes importantes.

Evitar contenido animado excesivo o parpadeante:
    Asegúrate de que cualquier animación pueda pausarse o desactivarse (prefers-reduced-motion).

