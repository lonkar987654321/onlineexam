package examejb;

import java.io.Serializable;
import javax.ejb.*;
import javax.naming.*;
import javax.sql.DataSource;
import java.sql.*;
import java.rmi.*;
import examejb.*;


public class ExamEJB3 implements SessionBean {

  public ExamEJB3() {};

  @Override
  public void setSessionContext(SessionContext ctx) {  }
  public void unsetEntityContext() {}

  @Override
  public void ejbActivate() {  }
  @Override
  public void ejbPassivate() { }

  @Override
  public void ejbRemove(){}
  public void ejbCreate() throws CreateException
  { }


  public void add(String bcode, String rollno,int marks) throws RemoteException
  {
    Connection con = null;
    PreparedStatement ps = null;
    try
    {
     // get next exam id
     Context ctx = new InitialContext();
     DataSource ds = (DataSource) ctx.lookup("java:comp/env/datasource");
     //DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Exam");
     con = ds.getConnection();
     Statement st = con.createStatement();
     ResultSet  rs = st.executeQuery("select max(examid)from exams");
     rs.next();
     String examid = rs.getString(1);
     rs.close();
     st.close();

     //  insert new row
     ps = con.prepareStatement("insert into exams values(?,?,?,?,sysdate)");
     ps.setString(1,examid);
     ps.setString(2,bcode);
     ps.setString(3,rollno);
     ps.setInt(4,marks);
     ps.executeUpdate();
    }
    catch(Exception ex)
    {
	  throw new RemoteException( ex.getMessage());
    }
    finally
    {
      try
      {
		ps.close();
		con.close();
      }
      catch(Exception ex) {}
    } // end of final
 } // end of ad


}  // end of bean