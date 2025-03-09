document.getElementById("scraper-form").addEventListener("submit", async function (event) {
    event.preventDefault(); // Evitar recarga de la página

    const url = document.getElementById("url").value.trim();
    const xpath = document.getElementById("xpath").value.trim();
    const resultadosDiv = document.getElementById("resultados");
    const paginationDiv = document.getElementById("paginacion"); // Nuevo div para paginación

    // Mostrar mensaje de carga
    resultadosDiv.innerHTML = "<p class='text-blue-500'>Cargando...</p>";
    paginationDiv.innerHTML = ""; // Limpiar paginación anterior

    try {
        const response = await fetch(`https://api.allorigins.win/get?url=${encodeURIComponent(url)}`);
        if (!response.ok) throw new Error("Error al obtener la página");

        const data = await response.json();
        const parser = new DOMParser();
        const doc = parser.parseFromString(data.contents, "text/html");

        // Aplicar XPath correctamente en el documento parseado
        const nodes = doc.evaluate(xpath, doc, null, XPathResult.ANY_TYPE, null);
        let resultNode = nodes.iterateNext();

        let resultados = []; // Array para almacenar los resultados
        while (resultNode) {
            let content = resultNode.textContent.normalize("NFC").trim(); // Normalizar caracteres especiales
            let imgSrc = null;

            if (resultNode.nodeType === Node.ELEMENT_NODE) {
                let imgElement = resultNode.querySelector("img");
                imgSrc = imgElement ? imgElement.src : null;
            }

            resultados.push({ content, imgSrc }); // Guardar cada resultado como un objeto

            resultNode = nodes.iterateNext();
        }

        // Mostrar mensaje con el número de registros obtenidos
        const totalResultados = resultados.length;
        if (totalResultados === 0) {
            resultadosDiv.innerHTML = "<p class='text-red-500'>No se encontraron resultados con el XPath proporcionado.</p>";
            return;
        }

        resultadosDiv.innerHTML = `<p class='text-green-600 font-bold mb-2'>Se encontraron ${totalResultados} registros.</p>`;

        // Implementar paginación
        const resultadosPorPagina = Math.floor(window.innerHeight / 150); // Calcula cuántos caben en pantalla
        let paginaActual = 1;
        const totalPaginas = Math.ceil(totalResultados / resultadosPorPagina);

        function mostrarPagina(pagina) {
            let inicio = (pagina - 1) * resultadosPorPagina;
            let fin = inicio + resultadosPorPagina;
            let paginaResultados = resultados.slice(inicio, fin);

            let output = ""; // Ahora no hay grilla, es solo una lista
            paginaResultados.forEach(({ content, imgSrc }) => {
                output += "<div class='bg-white p-4 rounded-lg shadow-md hover:shadow-xl transition duration-300 ease-in-out mb-4'>";
                
                if (imgSrc) {
                    output += `<img src="${imgSrc}" class="max-w-full h-48 object-cover mb-4 rounded-lg">`; // Imagen con diseño limpio
                }
                
                output += `<p class="text-gray-800">${content}</p>`; // Contenido
                output += "</div>";
            });

            resultadosDiv.innerHTML = output;
        }

        function actualizarPaginacion() {
            let botones = "";

            // Botón de "Anterior"
            if (paginaActual > 1) {
                botones += `
                    <button 
                        class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-full transition duration-200"
                        onclick="cambiarPagina(${paginaActual - 1})">
                        &lt; Anterior
                    </button>
                `;
            }

            // Mostrar la página actual y los botones de flecha
            botones += `
                <span class="text-lg font-semibold mx-4">${paginaActual} de ${totalPaginas}</span>
            `;

            // Botón de "Siguiente"
            if (paginaActual < totalPaginas) {
                botones += `
                    <button 
                        class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-full transition duration-200"
                        onclick="cambiarPagina(${paginaActual + 1})">
                        Siguiente &gt;
                    </button>
                `;
            }

            paginationDiv.innerHTML = `
                <div class="flex justify-center items-center space-x-4">
                    ${botones}
                </div>
            `;
        }

        // Función para cambiar de página
        window.cambiarPagina = function (pagina) {
            paginaActual = pagina;
            resultadosDiv.innerHTML = `<p class='text-green-600 font-bold mb-2'>Se encontraron ${totalResultados} registros.</p>`;
            mostrarPagina(pagina);
            actualizarPaginacion();
        };

        // Mostrar la primera página y la paginación
        mostrarPagina(paginaActual);
        actualizarPaginacion();

    } catch (error) {
        resultadosDiv.innerHTML = `<p class="text-red-500">Error: ${error.message}</p>`;
    }
});
