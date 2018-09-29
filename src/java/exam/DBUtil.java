// Member Bean
package exam;

import java.sql.*;

public class DBUtil
{

 public static void clean(Connection con, PreparedStatement ps)
 {
   try
   { if ( ps != null )  ps.close();
     if ( con != null) con.close();
   }
    catch(Exception ex)
   { System.out.println(ex.getMessage()); }
 }

 public static Connection  getConnection() throws Exception
 {
   Class.forName("com.mysql.jdbc.Driver");
   // connect using Thin driver
   Connection con =   DriverManager.getConnection("jdbc:mysql://localhost:3306/exam",
		"root","root");
   return con;
 }

} // end of DBUtil bean








