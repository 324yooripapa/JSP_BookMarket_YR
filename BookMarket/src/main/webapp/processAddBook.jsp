<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String b_filename = "";
	String realFolder = "C:\\workspace_BookMarket_YR\\BookMarket\\src\\main\\webapp\\resources\\images";
	int maxSize = 5 * 1024 * 1024;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	// 🛠 파라미터 값 가져오기
	String b_id = multi.getParameter("id");
	String b_name = multi.getParameter("name");
	String b_unitPrice = multi.getParameter("unitPrice");
	String b_author = multi.getParameter("author");
	String b_publisher = multi.getParameter("publisher");
	String b_releaseDate = multi.getParameter("releaseDate");
	String b_description = multi.getParameter("description");
	String b_category = multi.getParameter("category");
	String b_unitsInStock = multi.getParameter("unitsInStock");
	String b_condition = multi.getParameter("condition");
	
	System.out.println(" 전달된 데이터 - ID: " + b_id + ", 이름: " + b_name + ", 가격: " + b_unitPrice);
	
	// 🛠 필드 값 체크
	if (b_id == null || b_id.trim().isEmpty()) {
	    System.out.println(" 오류: b_id 값이 없습니다!");
	    out.println("<script>alert('도서 ID가 입력되지 않았습니다.'); history.back();</script>");
	    return;
	}

	// 🛠 파일 업로드 확인
	Enumeration files = multi.getFileNames();
	if (files.hasMoreElements()) {
	    String fileElement = (String) files.nextElement();
	    b_filename = multi.getFilesystemName(fileElement);
	    if (b_filename == null) {
	        b_filename = b_id + ".jpg"; 
	    }
	} else {
	    b_filename = "default.jpg"; 
	}
	System.out.println(" 저장될 파일명: " + b_filename);
	
	// 🛠 숫자 변환 (예외 처리)
	int unitPrice = 0;
	long unitsInStock = 0;
	try {
	    if (!b_unitPrice.isEmpty()) unitPrice = Integer.parseInt(b_unitPrice);
	    if (!b_unitsInStock.isEmpty()) unitsInStock = Long.parseLong(b_unitsInStock);
	} catch (NumberFormatException e) {
	    System.out.println(" 숫자 변환 오류: " + e.getMessage());
	    out.println("<script>alert('가격 또는 재고 수량이 올바르지 않습니다.'); history.back();</script>");
	    return;
	}
	
	// 🛠 DB 연결 확인
	if (conn == null) {
	    System.out.println("📌 DB 연결 실패: conn이 null입니다.");
	    out.println("<script>alert('데이터베이스 연결에 실패했습니다.'); history.back();</script>");
	    return;
	}
	
	// 🛠 SQL 실행
	PreparedStatement pstmt = null;
	String sql = "INSERT INTO book VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, b_id);
	pstmt.setString(2, b_name);
	pstmt.setInt(3, unitPrice);
	pstmt.setString(4, b_author);
	pstmt.setString(5, b_description);
	pstmt.setString(6, b_publisher);
	pstmt.setString(7, b_category);
	pstmt.setLong(8, unitsInStock);
	pstmt.setString(9, b_releaseDate);
	pstmt.setString(10, b_condition);
	pstmt.setString(11, b_filename);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	response.sendRedirect("books.jsp");
%>
