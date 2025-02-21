<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.* " %>
<%@ page import="java.util.*" %>
<%

	try{

		request.setCharacterEncoding("UTF-8");
	
		String filename="";
		String realFolder="C:\\Users\\user\\workspace_BookMarket_YR\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\BookMarket\\resources\\images";
		int maxSize=5 * 1024 *1024;
		String encType="utf-8";
		
		MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
		
		String id=multi.getParameter("id");
		String name=multi.getParameter("name");
		String unitPrice=multi.getParameter("unitPrice");
		String author=multi.getParameter("author");
		String publisher=multi.getParameter("publisher");
		String releaseDate=multi.getParameter("releaseDate");
		String description=multi.getParameter("description");
		String category=multi.getParameter("category");
		String unitsInStock=multi.getParameter("unitsInStock");
		String condition=multi.getParameter("condition");
		
		System.out.println("전달된 데이터 - ID :"+ id +", 이름: " + name + ",가격: " + unitPrice);

		
		
		Enumeration files = multi.getFileNames();
		String fileName=(String) files.nextElement();
		fileName = id + ".jpg"; 
		System.out.println("최종 저장될 파일명: " + fileName);
		
		int price;
		
		if (unitPrice.isEmpty())
			price=0;
		else
			price=Integer.valueOf(unitPrice);
		
		long stock;
		
		if (unitsInStock.isEmpty())
			stock=0;
		else
			stock=Long.valueOf(unitsInStock);
		
		BookRepository dao=BookRepository.getInstance();
		
		Book newBook=new Book();
		newBook.setBookId(id);
		newBook.setName(name);
		newBook.setUnitPrice(price);
		newBook.setAuthor(author);
		newBook.setPublisher(publisher);
		newBook.setReleaseDate(releaseDate);
		newBook.setDescription(description);
		newBook.setCategory(category);
		newBook.setUnitsInStock(stock);
		newBook.setCondition(condition);
		newBook.setFilename(fileName);
		
		dao.addBook(newBook);
		
		System.out.println("도서 저장 완료 - ID :"+newBook.getBookId());
		System.out.println("업로드된 파일명 :"+fileName);
		
		response.sendRedirect("books.jsp");
		
	} catch(Exception e){
		e.printStackTrace();
		System.out.println("오류 발생: "+ e.getMessage());
	}
	
%>
	
		
		