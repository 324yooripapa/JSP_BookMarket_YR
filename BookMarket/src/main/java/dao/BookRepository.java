package dao;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;


import mvc.database.DBConnection;
import dto.Book;

public class BookRepository {

	
	private static ArrayList<Book> listOfBooks=new ArrayList<Book>();
	private static BookRepository instance = new BookRepository();
	
	public static BookRepository getInstance() {
		return instance;
	}
	
	private Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String url = "jdbc:mysql://localhost:3306/JSPBookDB_YR?serverTimezone=Asia/Seoul";
		String user = "root";
		String password = "0000";
		
		return DriverManager.getConnection(url, user, password);
	}
	
	public BookRepository() {
		Book book1 = new Book("ISBN1234","C# 프로그래밍", 27000);
		book1.setAuthor("우재남");
		book1.setDescription("C#을 처음 접하는 독자를 대상으로 일대일 수업처럼 자세히 설명한 책이다. 꼭 알아야 할 핵심 개념은 기본 예제로 최대한 쉽게 설명했으며, 중요한 내용은 응용 예제, 퀴즈, 셀프 스터디, 예제 모음으로 한번 더 복습할 수 있다.");
		book1.setPublisher("한빛아카데미");
		book1.setCategory("IT모바일");
		book1.setUnitsInStock(1000);
		book1.setReleaseDate("2022/10/06");
		book1.setFilename("ISBN1234.jpg");
		
		Book book2 = new Book("ISBN1235","자바마스터",30000);
		book2.setAuthor("송미영");
		book2.setDescription("자바를 처음 배우는 학생을 위해 자바의 기본 개념과 실습 예제를 그림을 이용하여 쉽게 설명합니다. 자바의 이론적 개념>기본 예제>프로젝트 순으로 단계별 학습이 가능하며, 각 챕터의 프로젝트를 실습하면서 온라인 서점을 완성할 수 있도록 구성하였습니다.");
		book2.setPublisher("한빛아카데미");
		book2.setCategory("IT모바일");
		book2.setUnitsInStock(1000);
		book2.setReleaseDate("2023/01/01");
		book2.setFilename("ISBN1235.jpg");
		
		Book book3 = new Book("ISBN1236","파이썬 프로그래밍",30000);
		book3.setAuthor("최성철");
		book3.setDescription("파이썬으로 프로그래밍을 시작하는 입문자가 쉽게 이해할 수 있도록 기본 개념을 상세하게 설명하며, 다양한 예제를 제시합니다. 또한 프로그래밍의 기초 원리를 이해하면서 파이썬으로 데이터를 처리하는 기법도 배웁니다.");
		book3.setPublisher("한빛아카데미");
		book3.setCategory("IT모바일");
		book3.setUnitsInStock(1000);
		book3.setReleaseDate("2023/01/01");
		book3.setFilename("ISBN1236.jpg");
		
		listOfBooks.add(book1);
		listOfBooks.add(book2);
		listOfBooks.add(book3);
	}
	
	public ArrayList<Book> getAllBooks() {
	    System.out.println("BookRepository에서 전체 도서 목록 반환 중");

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    ArrayList<Book> listOfBooks = new ArrayList<>();

	    try {
	        conn = getConnection();
	        String sql = "SELECT * FROM book";
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Book book = new Book();
	            book.setBookId(rs.getString("b_id"));
	            book.setName(rs.getString("b_name"));
	            book.setUnitPrice(rs.getInt("b_unitPrice"));
	            book.setAuthor(rs.getString("b_author"));
	            book.setDescription(rs.getString("b_description"));
	            book.setPublisher(rs.getString("b_publisher"));
	            book.setCategory(rs.getString("b_category"));
	            book.setUnitsInStock(rs.getInt("b_unitsInStock"));
	            book.setReleaseDate(rs.getString("b_releaseDate"));
	            book.setFilename(rs.getString("b_filename"));
	            
	            listOfBooks.add(book);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return listOfBooks;
	}

		
		public Book getBookById(String id) {
		    System.out.println("BookRepository에서 검색 중: " + id);

		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    Book bookById = null;

		    try {
		        // DB 연결
		        conn = getConnection(); // DB 연결을 위한 별도 클래스 사용 (DBConnection.java)
		        
		        String sql = "SELECT * FROM book WHERE b_id = ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, id);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            bookById = new Book();
		            bookById.setBookId(rs.getString("b_id"));
		            bookById.setName(rs.getString("b_name"));
		            bookById.setUnitPrice(rs.getInt("b_unitPrice"));
		            bookById.setAuthor(rs.getString("b_author"));
		            bookById.setDescription(rs.getString("b_description"));
		            bookById.setPublisher(rs.getString("b_publisher"));
		            bookById.setCategory(rs.getString("b_category"));
		            bookById.setUnitsInStock(rs.getInt("b_unitsInStock"));
		            bookById.setReleaseDate(rs.getString("b_releaseDate"));
		            bookById.setFilename(rs.getString("b_filename"));

		            System.out.println("데이터베이스에서 찾은 도서: " + bookById.getName());
		        } else {
		            System.out.println("해당 ID의 도서를 찾을 수 없습니다: " + id);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (pstmt != null) pstmt.close();
		            if (conn != null) conn.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return bookById;
		}

		public void addBook(Book book) {
			listOfBooks.add(book);
		}
		
	}

