<%@ page import="java.io.*,java.util.*"%>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Roboto|Rubik" rel="stylesheet">
<link rel="stylesheet" href="css/login.css">

<% 
    Integer hit=(Integer)application.getAttribute("hitCounter");
    if(hit== null || hit== 0)
    {
        
        hit=1;
    } else {
    hit+=1;
}
    application.setAttribute("hitCounter",hit);
    


%>

<script type="text/javascript">
        function noBack()
         {
             window.history.forward(1);
         }
        noBack();
        window.onload = noBack;
        window.onpageshow = function(evt) { if (evt.persisted) noBack() }
        window.onunload = function() { void (0) }
    </script>
    
<body onload="noBack();">
<center>
    <header >
        <h3>OES</h3></header>
<div>
  <form action="login.jsp" method=post>
    <h3>Sign In</h3>
    <input type=text name=bcode size=10 placeholder="Batch Name">
	</br>
<input type=text name=rollno size=10 placeholder="Roll No">
    </br>
    <input type=password  size=10 name=pwd placeholder="Password">
	</br>
    <input type="submit" value="Sign In">
  </form>
</div>
</form>


</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br> <center>Students attending exams  <%=hit%></center>
<%
  // skip it if first run
  if ( request.getParameter("bcode") == null) return;
   
%>
   
<jsp:useBean id="studentbean" class="exam.StudentBean" scope="session" />
<jsp:setProperty name="studentbean" property="*" />

<%
  if ( studentbean.login() )
  {
     response.sendRedirect("startexam.jsp");
   }
  else
    out.println("<h4>Invalid Login. Try again! </h4>");

%>

</center>
</body>

</br></br></br></br></br></br></br></br>
<footer align="center" >
    <h4>Developed by :<a href="http://www.omtech.com">Om inc.</a></h4></footer>
</html>    
    
