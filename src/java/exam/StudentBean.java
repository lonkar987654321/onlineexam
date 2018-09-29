// Item Bean

package exam;

import  java.sql.*;
import  java.util.*;

import  exam.*;

public class StudentBean
{
	String bcode,rollno,pwd, ccode, sname;

	public String getCcode()
	{  return  ccode; }

    public String getSname()
	{  return  sname; }

	public void setBcode(String bcode)
	{
		  this.bcode = bcode;
    }

    public String getBcode()
    {
		  return bcode;
    }

    public void setRollno(String rollno)
	{
	  this.rollno = rollno;
	}

	public String getRollno()
	{
	  return rollno;
    }


	public void setPwd(String pwd)
	{
	  this.pwd = pwd;
    }

    public String getPwd()
    {
		  return pwd;
    }


    public boolean login()
    {
	  Connection con = null;
	  PreparedStatement ps = null;
      try
  	  {
		  con = DBUtil.getConnection();
		  ps = con.prepareStatement("select ccode,sname from batches b,students s where  s.bcode = b.bcode and s.bcode = ?  and s.rollno = ? and s.pwd = ? ");
		  ps.setString(1,bcode);
		  ps.setString(2,rollno);
		  ps.setString(3,pwd);
		  ResultSet rs = ps.executeQuery();
		  if ( ! rs.next() )
		    return false;
		  else
		  {
			 ccode = rs.getString(1);
			 sname = rs.getString(2);
		     return true;
	      }
       } // end of try
       catch ( Exception ex)
       {
		     System.out.println( ex.getMessage());
		     return false;
       }
       finally
       {
		     DBUtil.clean(con,ps);
	   }
    } // end of login

} // end of bean
