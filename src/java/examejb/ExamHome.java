package examejb;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;
import java.rmi.RemoteException;

public interface ExamHome extends EJBHome {

  public ExamRemote create() throws CreateException, RemoteException;

}
