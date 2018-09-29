<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="exam.DBUtil"%>
<%@page import="java.sql.Connection"%>
<html>
    <link rel="stylesheet" href="css/materialize.css">
    <style>
            .s {color:blue;} /* Green */
            .s:hover {color:red;}
            
            .but {
border-radius:25px;
    background-color: #4CAF50; /* Green */
    border: none;
    color: white;
    padding: 4px 10px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
}
.butt{
    background-color: white; 
    color: black; 
    border: 2px solid #008CBA;
}
        </style>
    
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

<nav>
    <div class="nav-wrapper">
      <a class="brand-logo center">Instructions</a>
      <ul id="nav-mobile" class="left hide-on-med-and-down">
          <li><img src="images/logo.gif" height="65px"/></li>
      </ul>
    </div>
  </nav>
    </br>

<jsp:useBean id="studentbean" class="exam.StudentBean" scope="session" />


<center><h5><span class="center">Welcome <jsp:getProperty  name="studentbean" property="sname"/></span></h5></center>
              <center>     
             
                  <div class="container-fluid">
      <div><div class="row-fluid mycenter wfid_temp840204 panel" ></div><br class="wfid_temp840277 br"/><div class="row-fluid wfid_temp840305 panel" ><table border="0" class="table table-hover wfid_temp840337 table"><tbody><tr class="wfid_temp840373 tablerow"><th class="wfid_temp840400 tableheader" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840455">No.</span></th><th class="wfid_temp840484 tableheader" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840518">Category</span></th><th class="wfid_temp840546 tableheader" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840579">Description</span></th></tr><tr class="wfid_temp840656 tablerow"><td class="wfid_temp840683 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840716">1</span></td><td class="wfid_temp840761 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840794">Session</span></td><td class="wfid_temp840822 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp840909">In case of system issues, candidates will be allowed to re-login. However, the number of re-logins is restricted.</span></td></tr><tr class="wfid_temp840950 tablerow"><td class="wfid_temp840978 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841010">2</span></td><td class="wfid_temp841038 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841142">Session</span></td><td class="wfid_temp841172 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841205">Refreshing page or closing the browser will log you out of the system. Do not refresh page or close the browser during the exam.</span></td></tr><tr class="wfid_temp841266 tablerow"><td class="wfid_temp841293 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841325">3</span></td><td class="wfid_temp841352 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841384">Session</span></td><td class="wfid_temp841449 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841485">Once you submit the exam you will not be able to login again. Your exam is considered completed. Therefore, please be very careful and submit the exam only when you are sure you want to end the exam.</span></td></tr><tr class="wfid_temp841531 tablerow"><td class="wfid_temp841572 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841606">4</span></td><td class="wfid_temp841633 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841685">Browser</span></td><td class="wfid_temp841713 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841745">Do not press back button of the browser. It will log you out of the system.</span></td></tr><tr class="wfid_temp841780 tablerow"><td class="wfid_temp841805 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841837">5</span></td><td class="wfid_temp841881 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841914">Browser</span></td><td class="wfid_temp841941 tablecell" align="left" valign="middle" colspan="1" rowspan="1"><span class="wfid_temp841973">Supported browsers: Mozilla Firefox and Google Chrome.</span></td></tr></tbody></table></div></div>
             </div>
             
                  </br></br></br>
                  
<a class ="but butt s"href="previousexams.jsp">Previous Exam</a>    
  
         
         
         <%
   int rollno=Integer.parseInt (studentbean.getRollno());
   System.out.print("rollno*****"+rollno);
    Connection con = DBUtil.getConnection();
    PreparedStatement ps = con.prepareStatement("select rollno from exams where rollno="+rollno);
    ResultSet rs = ps.executeQuery();
    boolean b=false;
    String s=null;
    while(rs.next())
    {
      s=rs.getString("rollno");
       b=true;
    }
   // System.out.print(s+"***************");
         if(b)
         {
             %>
        <a style="color:brown"> you have already been appeared for the exam.</a>
        <% } 
         else{ %>
<a class ="but butt s" href="takeexam.jsp">Start Exam </a>
     <%     }
         
   rs.close();
   ps.close();
   con.close();
%>

<a class ="but butt s" href="logout.jsp">Logout </a>
