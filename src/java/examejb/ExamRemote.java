package examejb;

import java.rmi.RemoteException;
import javax.ejb.*;


public interface ExamRemote extends EJBObject {

  public void add(String bcode, String rollno, int marks)
       throws RemoteException;


}
