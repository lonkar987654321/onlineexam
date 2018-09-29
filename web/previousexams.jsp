<%@page import="java.sql.*,exam.*"%>
<link rel="stylesheet" href="css/materialize.css"> 
<jsp:useBean id="studentbean" class="exam.StudentBean" scope="session" />
<%
    Connection con = DBUtil.getConnection();
    PreparedStatement ps = con.prepareStatement("select examid, dexam, marks from exams where bcode = ? and rollno = ? order by dexam desc");
    ps.setString(1,studentbean.getBcode());
    ps.setString(2,studentbean.getRollno());
    ResultSet rs = ps.executeQuery();
 %>
 
 <style>
     table {
         width: 500px;
         
     }
    
     </style>
 <center>
     <h5><div class="card-panel hoverable">Previous Exam </div></h5>

 <table class="highlight" class="centered">
 
<tr>
 <th>Exam Id</th>
 <th>Date Of Exam
 <th>No. Of Marks
 </tr>
 
<%
   
    while(rs.next())
    {
%>

<tr>
<td><%= rs.getString("examid")%>
<td><%= rs.getString("dexam")%>
<td><%= rs.getString("marks")%>
</tr>

<%
   }
   rs.close();
   ps.close();
   con.close();
%>

</table>

<a href="startexam.jsp">Back </a> 

