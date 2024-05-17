package apiFilm;
import java.util.*;
/***
* Classe che contiene gli attributi dei Film
*
* @author Giuseppe - Cristian
* 
*/
public class Film {
	private String Titolo;
	private String Categoria;
	private String Anno;
	private String Valutazione;
	
	/**
	 * @param titolo Titolo del film
	 * @param categoria Categoria del film
	 * @param annoProduzione Anno di produzione del film
	 * @param valutazione Valutazione del film
	 */
	public Film(String titolo, String categoria, String annoProduzione, String valutazione) {
		Titolo = titolo;
		Categoria = categoria;
		Anno = annoProduzione;
		Valutazione = valutazione;
	}
	/**
	 * @return Ritorna il titolo del film
	 */
	public String getTitolo() {
		return Titolo;
	}
	
	/**
	 * @return Ritorna la categoria del film
	 */
	public String getCategoria() {
		return Categoria;
	}
	
	
	/**
	 * @return Ritorna l'anno di produzione del film
	 */
	public String getAnno() {
		return Anno;
	}
	
	/**
	 * @return Ritorna la valutazione del film
	 */
	public String getValutazione() {
		return Valutazione;
	}
}

