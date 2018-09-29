<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<link rel="stylesheet" href="css/materialize.css">

<style>
    table {
        
        width: 500px;
        font-family: 'Robota' sans-serif;
    }
    
    
</style>
<%
String id = request.getParameter("userId");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "exam";
String userId = "root";
String password = "root";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h5 align="center"><font><strong>Student Result</strong></font></h5>
<center>
<table class="centered bordered highlight">
<tr>

</tr>
<tr>
<td><b>id</b></td>
<td><b>Batch Code</b></td>
<td><b>Roll No</b></td>
<td><b>Marks</b></td>
<td><b>Date of Exam</b></td>
</tr>
<%
try{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql ="SELECT * FROM exams";

resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>

<td><%=resultSet.getString("examid") %></td>
<td><%=resultSet.getString("bcode") %></td>
<td><%=resultSet.getString("rollno") %></td>
<td><%=resultSet.getString("marks") %></td>
<td><%=resultSet.getString("dexam") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>

<button onclick="myFunction()">Print</button>
<script>
    function myFunction(){
        window.print("table");
    }
    </script>
    
</center>