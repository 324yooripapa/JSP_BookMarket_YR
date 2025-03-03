<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.* " %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
		request.setCharacterEncoding("UTF-8");
	
		String filename="";
		String realFolder="C:\\upload";
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
		
		PreparedStatement pstmt=null;
		
		String sql="INSERT INTO book VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setInt(3, price);
		pstmt.setString(4, author);
		pstmt.setString(5, description);
		pstmt.setString(6, publisher);
		pstmt.setString(7, category);
		pstmt.setLong(8, stock);
		pstmt.setString(9, releaseDate);
		pstmt.setString(10, condition);
		pstmt.setString(11, filename);
		pstmt.executeUpdate();
		
		if (pstmt!=null)
			pstmt.close();
		if (conn!=null)
			conn.close();
		
		response.sendRedirect("books.jsp");
	%>

		
		