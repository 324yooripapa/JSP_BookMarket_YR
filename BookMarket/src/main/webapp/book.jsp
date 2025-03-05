<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="dto.Book"%>
<%@ page import="dao.BookRepository" %>
<%@ page errorPage="exceptionNoBookId.jsp" %>

<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>도서 정보</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("도서를 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
<div class="container py-4">
	<%@ include file ="menu.jsp" %>
	<div class="p-5 mb-4 bg-body-tertiary rounded-3">
		<div class="container-fluid py-5">
			<h1 class="display-5 fw-bold">도서정보</h1>
			<p class="col-md-8 fs-4">BookInfo</p>
			</div>
	</div>
	
	<%
		String b_id = request.getParameter("b_id");
		System.out.println("전달된 도서 id : [" + b_id + "]");
		

		if (b_id == null || b_id.trim().isEmpty()){

			System.out.println("잘못된 접근입니다. 도서 ID가 없습니다.");
			response.sendRedirect("books.jsp");
			return;
		}
	
			BookRepository dao=BookRepository.getInstance();
			System.out.println("BookRepository 객체 생성됨");
			
			Book book=dao.getBookById(b_id);
			System.out.println("getBookById() 호출 완료, 결과: " + book);
			
			if (book==null){
			System.out.println("해당 ID의 도서를 찾을 수 없습니다: " + b_id);
			}
	%>
	
	<div class="row align-items-md-stretch">
		<div class="col-md-5">
			<img src="./resources/images/<%=book.getFilename() %>" style="width:70%">
		</div>
	<div class="col-md-6">
		<h3><b><%=book.getName() %></b></h3>
		<p><%=book.getDescription() %>
		<p><b>도서코드 :</b><span class="badge text-bg-danger">
		<%=book.getBookId() %></span>
		<p><b>저자</b>: <%=book.getAuthor() %>
		<p><b>출판사</b>: <%=book.getPublisher() %>
		<p><b>출판일</b>: <%=book.getReleaseDate() %>
		<p><b>분류</b>: <%=book.getCategory() %>
		<p><b>재고수</b>: <%=book.getUnitsInStock() %>
		<h4><%=book.getUnitPrice() %>원</h4>
		<p> <form name="addForm" action="/addCart.jsp?b_id=<%=book.getBookId()%>" method="post"><a href="#" class="btn btn-info" onclick="addToCart()">도서주문 &raquo;</a>
		<a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a>
		<a href="./books.jsp" class="btn btn-secondary"> 도서목록 &raquo;</a>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"/>
</div>
</body>
</html>