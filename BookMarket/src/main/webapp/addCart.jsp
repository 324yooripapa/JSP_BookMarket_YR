<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Book"%>
<%@ page import="dao.BookRepository"%>
<%
	String b_id = request.getParameter("id");
	if (b_id == null || b_id.trim().equals("")) {
		response.sendRedirect("books.jsp");
		return;
	}

	BookRepository dao = BookRepository.getInstance();

	Book product = dao.getBookById(b_id);
	if (product == null) {
		response.sendRedirect("exceptionNoBookId.jsp");
	}

	ArrayList<Book> goodsList = dao.getAllBooks();
	Book goods = new Book();
	for (int i = 0; i < goodsList.size(); i++) {
		goods = goodsList.get(i);
		if (goods.getBookId().equals(b_id)) { 			
			break;
		}
	}
	
	ArrayList<Book> list = (ArrayList<Book>) session.getAttribute("cartlist");
	if (list == null) { 
		list = new ArrayList<Book>();
		session.setAttribute("cartlist", list);
	}

	int cnt = 0;
	Book goodsQnt = new Book();
	for (int i = 0; i < list.size(); i++) {
		goodsQnt = list.get(i);
		if (goodsQnt.getBookId().equals(b_id)) {
			cnt++;
			int orderQuantity = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}

	if (cnt == 0) { 
		goods.setQuantity(1);
		list.add(goods);
	}

	response.sendRedirect("book.jsp?id=" + b_id);
%>