<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Catalogo Film</title>
        <!-- Collegamento a Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" 
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <!-- Collegamento a FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                background-image: url('theearth.jpg');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                margin: 0;
                padding: 0;
                height: 100vh;
            }

            .transparent-container {
                background-color: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 10px;
                margin-top: 100px;
                transition: box-shadow 0.3s, background-color 0.3s;
                box-shadow: 0px 0px 15px 5px rgba(0, 0, 0, 0.3);
            }

            .transparent-container:hover {
                background-color: rgba(255, 255, 255, 1);
            }

            .form-group {
                margin-bottom: 10px;
            }

            .row{
                align-items: center;
            }

            .rating{
                user-select: none;
            }

            .rating .fa-star {
                font-size: 24px;
                cursor: pointer;
            }

            .rating .fa-star:hover,
            .rating .fa-star.active {
                color: gold;
            }

            @keyframes color {
                0%{
                    color: transparent;
                }
                100%{
                    color: gold;
                }
            }

            #submitButton {
                float: right;
            }

            .fas{
                animation-name: color;
                animation-duration: 2.5s;
                animation-delay: 0s;
                animation-timing-function: cubic-bezier(0.18, 0.39, 0.17, 1.05);
                animation-iteration-count: 1;
                animation-fill-mode: forwards;
            }
        </style>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-md-6 transparent-container text-center">
                    <form oninput="checkInputs()" method="get" action="/Catalogo/apiFilm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="titolo">Barra di Ricerca</label>
                                    <input type="text" name="titolo" value="" class="form-control" id="titolo" placeholder="Cerca...">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="anno">Inserimento Normale</label>
                                    <input type="number" name="anno" value="" class="form-control" id="anno" placeholder="Inserisci qualcosa">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="categoria">Menù a Tendina</label>
                                    <select name="categoria" class="form-control form-select" id="categoria">
                                        <option value="" selected>Seleziona una categoria</option>
                                        <option value="Animazione">Animazione</option>
                                        <option value="Azione">Azione</option>
                                        <option value="Drammatico">Drammatico</option>
                                        <option value="Fantasy">Fantasy</option>
                                        <option value="Comico">Comico</option>
                                        <option value="Horror">Horror</option>
                                        <option value="Romantico">Romantico</option>
                                        <option value="Fantascienza">Fantascienza</option>
                                        <option value="Commedia">Commedia</option>
                                        <option value="Documentario">Documentario</option>
                                        <option value="Reality">Reality</option>
                                        <option value="Thriller">Thriller</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="rating">Valutazione (da 1 a 5)</label><br>
                                    <div class="rating" data-rating="0" onclick="checkInputs()" ondblclick="resetStars()">
                                        <i class="far fa-star" data-value="1"></i>
                                        <i class="far fa-star" data-value="2"></i>
                                        <i class="far fa-star" data-value="3"></i>
                                        <i class="far fa-star" data-value="4"></i>
                                        <i class="far fa-star" data-value="5"></i>
                                    </div>
                                    <input type="hidden" name="valutazione" id="rating" value="">
                                </div>
                            </div>
                        </div>
                        <!-- Bottone di invio -->
                        <input type="submit" class="btn btn-primary" id="submitButton" disabled>
                    </form>
                </div>
            </div>
        </div>
        <script>
            const submitButton = document.getElementById('submitButton');
            const titolo = document.getElementById('titolo');
            const anno = document.getElementById('anno');
            const categoria = document.getElementById('categoria');
            const stars = document.querySelectorAll('.rating .fa-star');
            const ratingInput = document.getElementById('rating');
            
            function checkInputs() {
                //se i campi sono vuoti ci si aspetta di ottenere false quindi bottone disattivato
                let checkTitolo = titolo.value.trim() == '';
                let checkCategoria = categoria.value == '';
                let checkAnno = anno.value.trim() == '';
                console.log(ratingInput.value);
                let checkStars = countStelle(ratingInput.value);

                if(checkTitolo && checkCategoria && checkAnno && checkStars) submitButton.disabled = true;
                else submitButton.disabled = false;
            }

            function resetStars() {
                stars.forEach(star => {
                    star.classList.add('far');
                    star.classList.remove('fas');
                });
                ratingInput.value = "";
                checkInputs();
            }

            function countStelle(ratingInput) {
                if(ratingInput == "") return true;
                else return false;
            } 

            stars.forEach(star => {
                star.addEventListener('click', function () {
                    const value = parseInt(this.getAttribute('data-value'));
                    ratingInput.value = value;
                    stars.forEach(s => {
                        if (parseInt(s.getAttribute('data-value')) <= value) {
                            s.classList.add('fas');
                            s.classList.remove('far');
                        }else {
                            s.classList.add('far');
                            s.classList.remove('fas');
                        }
                    });
                });
            });
        </script>
    </body>
</html>