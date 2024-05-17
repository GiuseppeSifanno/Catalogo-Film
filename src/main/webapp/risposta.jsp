<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
   <%@ page import="org.json.simple.*"%>
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
	<title>Catalogo Film</title>
    <style>
        .row{
            row-gap: 20px;
        }
        .card{
        	border: 1px solid;
            flex-direction: row;
            flex-wrap: nowrap;
            padding: 0;
            align-items: center;
        }
        .card:hover{
        	transform: translate(5px, 5px);
        }
        .card-body{
            width: 300px;
            border-left: inherit;
        }
        .card-text{
            width: max-content;
            text-align: left;
        }
        #intestazioni{
        	background-color: cornflowerblue;
        	border-radius: var(--bs-card-inner-border-radius);
        	border-top-right-radius: 0px !important;
        	border-bottom-right-radius: 0px !important;
        	border-right-width: 0px;
        	border-bottom-width: 0px;
        }
    </style>
	</head>
	<body>
        <%
	        String titolo = request.getParameter("titolo");
			String categoria = request.getParameter("categoria");
			String anno = request.getParameter("anno");
			String valutazione = request.getParameter("valutazione");
            JSONParser parser=new JSONParser();
            String status = "";
            JSONArray catalogoFilm = null;
            Iterator<Object> i = null;
        %>
        <% 
            try{
                Object obj= parser.parse( (String)request.getAttribute("catalogo"));
                JSONObject catalogo = (JSONObject) obj;
                status = String.valueOf(catalogo.get("status"));
                System.out.println(status);
                catalogoFilm = (JSONArray) catalogo.get("film");
                if(catalogoFilm != null) i = catalogoFilm.iterator();
            }catch(Exception e){ e.printStackTrace();}
        %>
        <div class="text-center mt-5 mb-4">
        	<button onclick="window.location.replace('index.jsp')" class="link-primary bg-transparent border-0" value="Torna indietro" contenteditable="false">Torna indietro</button>
            <h2 id="titolo" class="my-2">Risultati per film con
            	<% if(titolo != "")  {%> <%= "Titolo " + titolo %> <%} %>
            	<% if(categoria != "") {%> <%= "Categoria "+ categoria %> <%} %>
            	<% if(anno != "") {%> <%= "Anno " + anno %> <%} %>
            	<% if(valutazione != "") {%> <%= "Valutazione "+ valutazione %> <%} %>
            </h2>
        </div>
		<div class="container my-4">
            <%
            	if(status.equalsIgnoreCase("ok")){
           	%>
           	<div class="row">
           		<%
            		while(i.hasNext()){
            			JSONObject film = (JSONObject) i.next();
            	%>
            	<div class='col'>
            		<div class="card card-group shadow">
            			<div id="intestazioni" class="p-3 card-header">
            				<p class="lead card-text"><b>Titolo</b></p>
                            <p class="lead card-text"><b>Categoria</b></p>
                            <p class="lead card-text"><b>Anno</b></p>
                            <p class="lead card-text"><b>Valutazione</b></p>	
                        </div>
                        <div id="valori" class="card-body">
                            <div class="card-text">
                                <p class="lead card-text"><%= film.get("titolo") %></p>
                            	<p class="lead card-text"><%= film.get("categoria") %></p>
                            	<p class="lead card-text"><%= film.get("anno") %></p>
                            	<p class="lead card-text"><%= film.get("valutazione") %></p>
                            </div>
                        </div>
                    </div>
                 </div>
            	<% } %>
            <% }
            	else %> <h1>Nessun film trovato</h1> <% ;%>
            </div>
        </div>
        <div class="text-center mt-5 mb-4">
        	<button onclick="window.location.replace('index.jsp')" class="link-primary bg-transparent border-0" value="Torna indietro" contenteditable="false">Torna indietro</button>
        </div>
	</body>
</html>