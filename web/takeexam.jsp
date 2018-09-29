<html>
    <meta http-equiv="refresh" content="URL='finishexam.jsp'">
    <head> 
        
        <style>
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    -webkit-animation-name: fadeIn; /* Fade in the background */
    -webkit-animation-duration: 0.4s;
    animation-name: fadeIn;
    animation-duration: 0.4s
}

/* Modal Content */
.modal-content {
    position: fixed;
    bottom: 0;
    background-color: #fefefe;
    width: 100%;
    -webkit-animation-name: slideIn;
    -webkit-animation-duration: 0.4s;
    animation-name: slideIn;
    animation-duration: 0.4s
}

/* The Close Button */
.close {
    color: white;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

.modal-header {
    padding: 2px 16px;
    background-color: #5cb85c;
    color: white;
}

.modal-body {padding: 2px 16px;}

.modal-footer {
    padding: 2px 16px;
    background-color: #5cb85c;
    color: white;
}

/* Add Animation */
@-webkit-keyframes slideIn {
    from {bottom: -300px; opacity: 0} 
    to {bottom: 0; opacity: 1}
}

@keyframes slideIn {
    from {bottom: -300px; opacity: 0}
    to {bottom: 0; opacity: 1}
}

@-webkit-keyframes fadeIn {
    from {opacity: 0} 
    to {opacity: 1}
}

@keyframes fadeIn {
    from {opacity: 0} 
    to {opacity: 1}
}
</style>
        
        <script>
var isNS = (navigator.appName == "Netscape") ? 1 : 0;

if(navigator.appName == "Netscape") document.captureEvents(Event.MOUSEDOWN||Event.MOUSEUP);

function mischandler(){
return false;
}

function mousehandler(e){
var myevent = (isNS) ? e : event;
var eventbutton = (isNS) ? myevent.which : myevent.button;
if((eventbutton==2)||(eventbutton==3)) return false;
}
document.oncontextmenu = mischandler;
document.onmousedown = mousehandler;
document.onmouseup = mousehandler;

</script>

<script type="text/javascript">
function Killcopy(e) {
	return false;
}
function reEnable() {
return true;
}
document.onselectstart=new Function("return false")
if(window.sidebar){
document.onmousedown=killCopy
document.onclick=reEnable
}
</script>




        <script type="text/javascript">
            function noBack()
            {
                window.history.forward(1);
            }
            noBack();
            window.onload = noBack;
            window.onpageshow = function(evt) {
                if (evt.persisted)
                    noBack()
            }
            window.onunload = function() {
                void (0)
            }
        </script>
         <link rel="stylesheet" href="css/radio.css"> 
         <link rel="stylesheet" href="css/btn.css"> 
         <link rel="stylesheet" href="css/.css"> 
        
    </head>
   <link rel="stylesheet" href="css/materialize.css">
     <jsp:useBean id="studentbean" class="exam.StudentBean" scope="session" />
        <jsp:useBean id="exambean" class="exam.ExamBean" scope="session" />
  
        <%
            String min1 = request.getParameter("min");
            if (min1 == null) {
                min1 = "30";
            }
            String sec1 = request.getParameter("sec");
            if (sec1 == null) {
                sec1 = "00";
            }
        %>    
        <script language ="javascript" >
            var tim;
            var min = <%=min1%>;
            var sec = <%=sec1%>;
            // var f = new Date();
            function f2() {
                if (parseInt(sec) > 0) {
                    sec = parseInt(sec) - 1;
                    //document.getElementById("showtime").innerHTML = "Your Left Time  is :"+min+" Minutes ," + sec+" Seconds";
                    //document.getElementById("min").innerHTML = min;
                    //document.getElementById("sec").innerHTML = sec;
                    document.forma.min.value = min;
                    document.forma.sec.value = sec;
                    tim = setTimeout("f2()", 1000);
                }
                else {
                    if (parseInt(sec) == 0) {
                        min = parseInt(min) - 1;
                        if (parseInt(min) < 0) {
                            clearTimeout(tim);
                            //location.href = "default5.aspx";
                            document.getElementById('Cancel').click();
                        }
                        else {
                            sec = 60;
                            //document.getElementById("showtime").innerHTML = "Your Left Time  is :" + min + " Minutes ," + sec + " Seconds";
                            // document.getElementById("min").innerHTML = min;
                            // document.getElementById("sec").innerHTML = sec; 
                            document.forma.min.value = min;
                            document.forma.sec.value = sec;
                            tim = setTimeout("f2()", 1000);
                        }
                    }

                }
            }
        </script>
       <%

            String action = request.getParameter("action");
            exam.Question q = null;
            
            
            
          
            if (action == null) {
                exambean.setCcode(studentbean.getCcode());
                exambean.loadQuestions();
            } else if (action.equals("Submit")) {
                response.sendRedirect("finishexam.jsp");
                return;
            } else{
                String answer = request.getParameter("answer");
                exambean.setAnswer(answer);
                if (exambean.isLastQuestion()) {
                    response.sendRedirect("finishexam.jsp");
                    return;
                } 
            }

            q = exambean.nextQuestion();

        %>     
 
      
      

 


        <form action=takeexam.jsp method=post name="forma">
            
            <nav>
    <div class="nav-wrapper black-text">
      <a class="brand-logo center"><img src="images/logo.gif" height="65px"/></a>
      <ul id="nav-mobile" class="right hide-on-med-and-down ">
          <li><input id="min" name="min" type="text" size="1" readonly="true"  value="<%=min1%>"></li>
          <li><input id="sec" name="sec" size="3" type="text" readonly="true" value="<%= sec1%>"></li>
      </ul>
    </div>
  </nav>
      </br>
       <div class="chip">
    Question #<%= exambean.getQno() + 1%> 
   
  </div>
            <!-- Questions :  <%= exambean.getQno() + 1%>  /  <%=exambean.getTotal()%> -->
            
    
    
    <table>
                <tr>
                <h6> <div class="card-panel hoverable"><%=q.getQuestion()%> </div></h6>
                </tr>
   </table>
                <div class="mf-radio-block mf-is-success">
   
          <div class="mf-radio">
            <label>
              <input type="radio" name="answer" value=1 /><i class="mf-radio-button"></i><span><%=q.getAns1()%></span>
            </label>
          </div>
          <div class="mf-radio">
            <label>
              <input type="radio" name="answer" value=2 /><i class="mf-radio-button"></i><span><%=q.getAns2()%></span>
            </label>
          </div>
           <div class="mf-radio">
            <label>
              <input type="radio" name="answer" value=3 /><i class="mf-radio-button"></i><span><%=q.getAns3()%></span>
            </label>
          </div>
          <div class="mf-radio">
            <label>
              <input type="radio" name="answer" value=4 /><i class="mf-radio-button"></i><span><%=q.getAns4()%></span>
            </label>
          </div>
    </div>
            <style>
                .page-footer {
                    position: relative;
                   padding-top: 230px;
                }
                
            </style>
            <footer class="page-footer white">
                <center>
                <div class="conatiner">
                    <input class="gray-text text-lighten-4 left" type=submit id="myBtn" value="Question">
                     <input type=submit value="first">
                    <input type=submit value="Previous" name="act">
                <input  type=submit value="Next"  name="action">  
                 <input type=submit value="Last">
                <input class="gray-text text-lighten-4 right" type=submit id="Cancel" value="Submit"  name="action">
                </div>
                
            </footer>
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
      <h5>Questions</h5>
    </div>
    <div class="modal-body">
     <ul class="pagination">
	 <table class="centered">
	 <tr>
	<td><li class="active"><a href="#!">1</a></li>
    <td><li class="waves-effect"><a href="#!">2</a></li>
    <td><li class="waves-effect"><a href="#!">3</a></li>
    <td><li class="waves-effect"><a href="#!">4</a></li>
    <td><li class="waves-effect"><a href="#!">5</a></li>
    <td><li class="waves-effect"><a href="#!">6</a></li>
    <td><li class="waves-effect"><a href="#!">7</a></li>
    <td><li class="waves-effect"><a href="#!">8</a></li>
	<td><li class="waves-effect"><a href="#!">9</a></li>
    <td><li class="waves-effect"><a href="#!">10</a></li>
    <td><li class="waves-effect"><a href="#!">11</a></li>
    <td><li class="waves-effect"><a href="#!">12</a></li>
    <td><li class="waves-effect"><a href="#!">13</a></li>
	</tr>
    <tr>
	<td><li class="waves-effect"><a href="#!">14</a></li>
    <td><li class="waves-effect"><a href="#!">15</a></li>
    <td><li class="waves-effect"><a href="#!">16</a></li>
    <td><li class="waves-effect"><a href="#!">17</a></li>
    <td><li class="waves-effect"><a href="#!">18</a></li>
    <td><li class="waves-effect"><a href="#!">19</a></li>
    <td><li class="waves-effect"><a href="#!">20</a></li>
    <td><li class="waves-effect"><a href="#!">21</a></li>
	<td><li class="waves-effect"><a href="#!">22</a></li>
    <td><li class="waves-effect"><a href="#!">23</a></li>
    <td><li class="waves-effect"><a href="#!">24</a></li>
    <td><li class="waves-effect"><a href="#!">25</a></li>
    <td><li class="waves-effect"><a href="#!">26</a></li>
	</tr>
	</table>
  </ul>
    </div>
    <div class="modal-footer">
      <h6>Modal Footer</h6>
    </div>
  </div>

</div>

<script>
// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
                   

        </form>
            
        <script>f2();</script>
    </body>


