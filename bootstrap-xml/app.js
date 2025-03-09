let noticias = [];
let favoritos = [];

$(document).ready(function() {
    cargarFavoritos();
    $("#loadFeed").click(cargarNoticias);
    $("#mostrarFavoritos").click(mostrarFavoritos);
});

function cargarFavoritos() {
    let favoritosGuardados = localStorage.getItem('favoritos');
    if (favoritosGuardados) {
        favoritos = JSON.parse(favoritosGuardados);
    }
}

function cargarNoticias() {
    let feedUrl = $("#feedUrl").val().trim();
    if (feedUrl === "") {
        alert("Por favor, introduce una URL de un feed RSS.");
        return;
    }
    let proxyUrl = "https://api.allorigins.win/get?url=" + encodeURIComponent(feedUrl);
    $.ajax({
        url: proxyUrl,
        type: "GET",
        success: function (response) {
            let xmlString = response.contents;
            let parser = new DOMParser();
            let xml = parser.parseFromString(xmlString, "text/xml");
            procesarFeed(xml);
        },
        error: function (xhr, status, error) {
            console.error("Error AJAX:", status, error);
            alert("No se pudo cargar el feed. Verifica la URL.");
        }
    });
}

function procesarFeed(xml) {
    noticias = [];
    $(xml).find("item").each(function () {
        let noticia = {
            title: $(this).find("title").text(),
            link: $(this).find("link").text(),
            pubDate: $(this).find("pubDate").text(),
            author: $(this).find("dc:creator").text() || "Autor desconocido",
            description: $(this).find("description").text(),
            categories: $(this).find("category").map(function() { return $(this).text(); }).get().join(", "),
            imageUrl: $(this).find("media\\:content, content").attr("url") || "https://via.placeholder.com/150",
            favorite: favoritos.some(fav => fav.title === $(this).find("title").text())
        };
        noticias.push(noticia);
    });
    mostrarNoticias(noticias);
}

function mostrarNoticias(noticiasAMostrar, pagina = 1, esFavoritosPage = false) {
    let container = $("#newsContainer");
    container.empty();
    let inicio = (pagina - 1) * 10;
    let fin = inicio + 10;
    let noticiasEnPagina = noticiasAMostrar.slice(inicio, fin);

    noticiasEnPagina.forEach((noticia, index) => {
        let favoritoClass = noticia.favorite ? 'btn-warning' : 'btn-outline-warning';
        let favoritoText = noticia.favorite ? 'Quitar de favoritos' : 'Añadir a favoritos';
        let cardHTML = `
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="${noticia.imageUrl}" class="img-fluid rounded-start" alt="${noticia.title}">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title">${noticia.title}</h5>
                            <p class="card-text">${noticia.description}</p>
                            <p class="card-text"><small class="text-muted">${noticia.pubDate} | ${noticia.author}</small></p>
                            <button class="btn ${favoritoClass} favorito-btn" data-index="${inicio + index}" data-favoritos="${esFavoritosPage}">${favoritoText}</button>                        </div>
                    </div>
                </div>
            </div>
        `;
        container.append(cardHTML);
    });

    $(".favorito-btn").off('click').on('click', function(e) {
        e.preventDefault();
        let index = $(this).data("index");
        let esFavoritosPage = $(this).data("favoritos");
        toggleFavorito(index, esFavoritosPage);    });

    mostrarControlesPaginacion(noticiasAMostrar.length, pagina);
}

function toggleFavorito(index, esFavoritosPage = false) {
    let noticia;
    if (esFavoritosPage) {
        noticia = favoritos[index];
    } else {
        noticia = noticias[index];
    }

    noticia.favorite = !noticia.favorite;

    if (noticia.favorite) {
        if (!favoritos.some(fav => fav.title === noticia.title)) {
            favoritos.push(noticia);
        }
    } else {
        favoritos = favoritos.filter(fav => fav.title !== noticia.title);
    }

    localStorage.setItem('favoritos', JSON.stringify(favoritos));

    if (esFavoritosPage) {
        mostrarFavoritos();
    } else {
        mostrarNoticias(noticias, Math.floor(index / 10) + 1);
    }
}


function mostrarControlesPaginacion(totalNoticias, paginaActual) {
    let totalPaginas = Math.ceil(totalNoticias / 10);
    
    // Eliminar cualquier paginación existente antes de añadir la nueva
    $(".paginacion-noticias").remove();
    
    let paginacionHTML = `
        <nav aria-label="Paginación de noticias" class="paginacion-noticias">
            <ul class="pagination justify-content-center">
                <li class="page-item ${paginaActual === 1 ? 'disabled' : ''}">
                    <a class="page-link" href="#" data-pagina="${paginaActual - 1}">Anterior</a>
                </li>
                <li class="page-item ${paginaActual === totalPaginas ? 'disabled' : ''}">
                    <a class="page-link" href="#" data-pagina="${paginaActual + 1}">Siguiente</a>
                </li>
            </ul>
        </nav>
    `;
    $("#newsContainer").after(paginacionHTML);

    $(".pagination .page-link").off('click').on('click', function(e) {
        e.preventDefault();
        let nuevaPagina = $(this).data("pagina");
        mostrarNoticias(noticias, nuevaPagina);
    });
}


function mostrarFavoritos() {
    mostrarNoticias(favoritos, 1, true);
}
