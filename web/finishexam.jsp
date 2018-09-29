<html>
    <body onload="noBack();">
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
<jsp:useBean id="studentbean" class="exam.StudentBean" scope="session" />
<jsp:useBean id="exambean" class="exam.ExamBean" scope="session" />
<link rel="stylesheet" href="css/materialize.css">

<style>
td {font:700 11pt verdana}
table{
    width:560px;
}
</style>

<center>


<table >
<tr>
<h5><div class="card-panel hoverable">Exam Result </div></h5>
</tr>

<tr>
<td>No. Of Questions 
<td><%= exambean.getTotal()%>
</tr>

<tr>
<td>No. of Questions Attempted 
<td><%= exambean.getQno() + 1 %> 
</tr>

<tr>
<td>No. Of Correct Answers 
<td>
<% 
  int  nomarks = exambean.getNoCorrectAnswers();
  out.println(nomarks);

%>
</tr>

</table>

<a href="login.jsp">Logout</a>


<%

try
{
  // insert exam details into EXAMS table
  exambean.addExamRecord( studentbean.getBcode(), studentbean.getRollno(), nomarks);
}
catch(Exception ex) 
{
   System.out.println(ex.getMessage());
}

%>
</body>
</html>




