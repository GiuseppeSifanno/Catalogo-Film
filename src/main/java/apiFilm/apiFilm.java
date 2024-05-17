package apiFilm;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;
/**
* Servlet implementation class apiFilm
*/
@WebServlet("/apiFilm")
public class apiFilm extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Vettore contenente tutte le chiavi dei parametri
	 */
	public Vector<String> keys = new Vector<String>(4);
	
	/**
	 * HashMap che contiene tutti i parametri recuperati dalla richiesta get
	 */
	public HashMap<String, String> hash = new HashMap<String, String>();
	
	/**
	 * Vettore contenente tutte le singole condizioni da applicare nella query SQL
	 */
	public Vector<String> condition = new Vector<String>(1,1);
	
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public apiFilm() {
		super();
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "Giuseppe");
			
			//Connection conn = DriverManager.getConnection("PostgreSQL");
			RequestDispatcher dispatcher;
			
			String titolo = request.getParameter("titolo");
			request.setAttribute("titolo", titolo);
			
			String categoria = request.getParameter("categoria");
			request.setAttribute("categoria", categoria);
			
			String anno = request.getParameter("anno");
			request.setAttribute("anno", anno);
			
			String valutazione = request.getParameter("valutazione");
			request.setAttribute("valutazione", valutazione);

			//inseriamo i parametri inviati dal client in un HashMap
			hash.put("Titolo", titolo);
			hash.put("Categoria", categoria);
			hash.put("Anno", anno);
			hash.put("Valutazione", valutazione);

			//inseriamo le chiavi dei parametri
			keys.add("Titolo");
			keys.add("Categoria");
			keys.add("Anno");
			keys.add("Valutazione");

			int hashSize = hash.size();
			//filtro l'hash map alla ricerca dei parametri non vuoti
			for(byte i = 0; i < hashSize; i++){
				if(hash.get(keys.elementAt(i)) == "") hash.remove(keys.elementAt(i));
				else condition.add(" \""+keys.elementAt(i)+"\" ='"+hash.get( keys.elementAt(i) )+"' " );
			}

			//stringa in cui verranno concatenate le condizioni
			String condizioniSQL = "";

			//compongo la sezione dei parametri in query SQL
			for (int i = 0; i < condition.size(); i++) {
				if((i + 1) < condition.size() ) condizioniSQL += condition.elementAt(i) + " AND ";
				else condizioniSQL += condition.elementAt(i);
			}
			
			String sql = "SELECT * FROM PUBLIC.\"Film\" WHERE " + condizioniSQL;	
			
			System.out.println(sql);
			
			Statement stmt = conn.createStatement();
			
			if(stmt.execute(sql)) System.out.println("query eseguita ");
			
			ResultSet result = stmt.getResultSet();
			dispatcher = getServletContext().getRequestDispatcher("/risposta.jsp");
			
			//creazione json di risposta
			JSONObject catalogo = new JSONObject();
			//creo array di film
			JSONArray filmArray = new JSONArray();
			int i = 0;
			while(result.next()) {
				i++;
				Film film = new Film(
						result.getString("Titolo"), 
						result.getString("Categoria"), 
						result.getString("Anno"), 
						result.getString("Valutazione"));
				
				JSONObject proprieta = new JSONObject();
				proprieta.put("titolo", film.getTitolo());
				proprieta.put("anno", film.getAnno());
				proprieta.put("categoria", film.getCategoria());
				proprieta.put("valutazione", film.getValutazione());
				filmArray.add(proprieta);
			}
			if(i==0) {
				catalogo.put("status", "empty");
				request.setAttribute("catalogo", catalogo.toJSONString());
				dispatcher.forward(request, response);
			}
			else catalogo.put("status", "ok");
			
			catalogo.put("film", filmArray);
			
			System.out.print(catalogo.toJSONString());
			request.setAttribute("catalogo", catalogo.toJSONString());
			dispatcher.forward(request, response);
		}
		catch (SQLException | ClassNotFoundException e) { e.printStackTrace();}
	}
}