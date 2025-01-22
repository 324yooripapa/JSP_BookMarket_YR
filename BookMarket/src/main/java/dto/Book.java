package dto;

import java.io.Serializable;

public class Book implements Serializable{
	
	private static final long serialVersionUID=-4274700572038677000L;
	
	private String bookid;
	private String name;
	private int unitPrice;
	private String author;
	private String description;
	private String publisher;
	private String category;
	private long unitsInStock;
	private String releaseDate;
	private String condition;
	
	
	public Book() {
		super();
	}
	
	public Book(String bookid, String name, Integer unitPrice) {
		this.bookid=bookid;
		this.name=name;
		this.unitPrice=unitPrice;
	}
}


